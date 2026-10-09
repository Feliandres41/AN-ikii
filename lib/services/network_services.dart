import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum NetworkStatus { 
  disconnected, // Esto es tu 1: Sin internet
  connecting,   // Esto es tu 2: Cargando / cambiando de wifi a datos
  connected,    // Esto es tu 3: Con internet
}

class NetworkService extends ChangeNotifier {
  // Instancia que habla con el sistema Android/iOS para saber si estás en WIFI o DATOS
  final _connectivity = Connectivity();
  
  // Instancia que hace un ping real a Google para confirmar que HAY internet de verdad
  final _checker = InternetConnection();
  
  // Guardamos la suscripción para poder cancelarla luego y no gastar memoria
  late StreamSubscription _subscription;

  // AQUÍ ESTÁ TU VARIABLE PRINCIPAL
  // Empieza en "connecting" porque al abrir la app no sabemos aún si hay internet
  NetworkStatus _status = NetworkStatus.connecting;
  
  // Getter público para que desde afuera puedas leer el valor
  // Ej: networkService.status te devuelve disconnected, connecting o connected
  NetworkStatus get status => _status;

  // Estos 3 son atajos para que en tu UI no tengas que comparar el enum
  // En vez de hacer: if(status == NetworkStatus.connected)
  // Puedes hacer: if(isConnected)
  bool get isDisconnected => _status == NetworkStatus.disconnected; // es 1?
  bool get isConnecting => _status == NetworkStatus.connecting;   // es 2?
  bool get isConnected => _status == NetworkStatus.connected;     // es 3?

  // Constructor: apenas se crea el servicio en el main, empieza a trabajar
  NetworkService() {
    _init();
  }

  // Método que inicia todo
  Future<void> _init() async {
    // 1. Verifica el estado inicial apenas abre la app
    bool hasInternet = await _checker.hasInternetAccess;
    _status = hasInternet ? NetworkStatus.connected : NetworkStatus.disconnected;
    notifyListeners(); // ¡AVISA A TODA LA APP QUE CAMBIÓ LA VARIABLE!

    // 2. Se queda escuchando para siempre los cambios de red
    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      
      // Si detecta un cambio (de WIFI a DATOS por ejemplo)
      // Primero pone el estado en "cargando"
      _status = NetworkStatus.connecting;
      print("2");
      notifyListeners(); // Avisa: ahora es 2

      // Luego verifica si realmente hay internet (tarda 1 seg)
      if (results.contains(ConnectivityResult.none)) {
        print("1");
        _status = NetworkStatus.disconnected; // 1 - No hay ni WIFI ni DATOS
      } else {
        print("3");
        bool hasInternet = await _checker.hasInternetAccess;
        // Si hay WIFI/DATOS y el ping funcionó = 3, si no = 1
        _status = hasInternet ? NetworkStatus.connected : NetworkStatus.disconnected;
      }
      notifyListeners(); // Avisa del estado final 1 o 3
    });
  }

  // Limpia todo cuando se cierra la app
  @override
  void dispose() {
    _subscription.cancel(); // Deja de escuchar
    super.dispose();
  }
}