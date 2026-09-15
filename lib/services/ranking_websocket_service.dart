import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:web_socket_channel/web_socket_channel.dart';

class RankingWebSocketService {
  RankingWebSocketService({
    required this.endpoint,
    required this.token,
    this.protocols,
    this.subscriptionMessage,
  });

  factory RankingWebSocketService.pusherDashboard() {
    return RankingWebSocketService(
      endpoint:
          'wss://caa-fonseca.education/app/e2bcd40b49393d6486f5fc3bd65a374d?protocol=7&client=flutter&version=1.0',
      token: null,
      protocols: const [],
      subscriptionMessage: const {
        'event': 'pusher:subscribe',
        'data': {
          'channel': 'programming.dashboard',
        },
      },
    );
  }

  final String endpoint;
  final String? token;
  final Iterable<String>? protocols;
  final Map<String, dynamic>? subscriptionMessage;
  final _actualizaciones = StreamController<Map<String, dynamic>>.broadcast();

  WebSocketChannel? _canal;
  StreamSubscription<Object?>? _suscripcion;
  Timer? _reconexion;
  bool _cerrado = false;

  Stream<Map<String, dynamic>> get actualizaciones => _actualizaciones.stream;

  Future<void> conectar() async {
    if (_cerrado || _canal != null) return;

    try {
      final canal = WebSocketChannel.connect(
        Uri.parse(endpoint),
        protocols: protocols,
      );
      _canal = canal;

      await canal.ready;
      if (_cerrado) return;
      print('WebSocket ranking conectado');

      _suscripcion = canal.stream.listen(
        _procesarMensaje,
        onError: (_, _) => _programarReconexion(),
        onDone: _programarReconexion,
        cancelOnError: false,
      );

      if (subscriptionMessage != null) {
        final mensaje = {
          ...subscriptionMessage!,
          if (token != null && !subscriptionMessage!.containsKey('token'))
            'token': token,
        };
        canal.sink.add(jsonEncode(mensaje));
        print('Suscrito al canal programming.dashboard');
      }
    } catch (error) {
      print('Error WebSocket ranking: $error');
      _canal = null;
      _suscripcion = null;
      _programarReconexion();
    }
  }

  void _procesarMensaje(Object? mensaje) {
    final texto = switch (mensaje) {
      String valor => valor,
      Uint8List valor => utf8.decode(valor),
      List<int> valor => utf8.decode(valor),
      _ => null,
    };
    if (texto == null) return;

    try {
      final json = jsonDecode(texto);
      if (json is Map) {
        _actualizaciones.add(Map<String, dynamic>.from(json));
      }
    } on FormatException {
      // Ignora mensajes que no sean JSON.
    }
  }

  void _programarReconexion() {
    if (_cerrado || _reconexion?.isActive == true) return;

    _canal = null;
    _suscripcion = null;
    print('WebSocket ranking desconectado; reintentando en 5 segundos');
    _reconexion = Timer(const Duration(seconds: 5), conectar);
  }

  Future<void> desconectar() async {
    _cerrado = true;
    _reconexion?.cancel();
    await _suscripcion?.cancel();
    await _canal?.sink.close();
    _suscripcion = null;
    _canal = null;
  }

  Future<void> dispose() async {
    await desconectar();
    await _actualizaciones.close();
  }
}