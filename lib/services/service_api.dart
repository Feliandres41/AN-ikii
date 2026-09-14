import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/datos_temporales.dart';

class ServiceApi extends ChangeNotifier {
  ServiceApi() {
    recarga();
  }
  Future<void> recarga() async {
    try {
      final tokenGuardado = await _datosTemporales.obtenerToken();
      final datosGuardados = await _datosTemporales.obtenerDatos();
      if (tokenGuardado != null && datosGuardados != null) {
        _token = tokenGuardado;
        datos = datosGuardados;
        notifyListeners();
      }

      final historialGuardado = await _datosTemporales.obtenerHistorial();
      if (historialGuardado != null) {
        historial = _conservarUltimosVeinte(historialGuardado);
        notifyListeners();
      }
      if (_token != null && _token!.isNotEmpty) {
        await verBusqueda();
        notifyListeners();
        print("___");
      }
    } catch (e) {}
  }

  final _url = "https://caa-fonseca.education/api";
  final _datosTemporales = DatosTemporales();
  String? _token;
  bool _cerrandoSesion = false;
  Map? datos;
  Map historial = {};

  Future<int> logout() async {
    final token = _token;
    _cerrandoSesion = true;
    _token = null;
    datos = null;
    await _datosTemporales.eliminarToken();
    notifyListeners();

    if (token != null && token.isNotEmpty) {
      try {
        final url = Uri.parse("$_url/logout");
        final respuesta = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        if (respuesta.statusCode == 200) {
          await _datosTemporales.eliminarToken();
          print(
            "Cerraste sesion\n${respuesta.body}\n_________________________________",
          );
          notifyListeners();
          return 200;
        } else {
          print("Credenciales incorrectas\n${respuesta.body}");
          return 404;
        }
      } catch (e) {
        print("Error de conexión\n$e");
        return 404;
      }
    } else {
      return 404;
    }
  }

  Future<bool> restaurarSesion() async {
    if (_cerrandoSesion) return false;

    final token = await _datosTemporales.obtenerToken();
    final datosGuardados = await _datosTemporales.obtenerDatos();
    if (token == null || token.isEmpty || datosGuardados == null) {
      return false;
    }

    _token = token;
    datos = datosGuardados;
    notifyListeners();

    return true;
  }

  //login
  Future<int> login(String document, String password) async {
    print("Logueandose");
    _cerrandoSesion = false;
    try {
      final url = Uri.parse("$_url/login");
      final respuesta = await http.post(
        url,
        body: jsonEncode({"user_name": document, "password": password}),
        headers: {"Content-Type": "application/json"},
      );
      print(respuesta.statusCode);
      if (respuesta.statusCode == 200) {
        _token = jsonDecode(respuesta.body)["token"];
        await _datosTemporales.guardarToken(_token!);
        print(
          "Login exitoso\n${respuesta.body}\n_________________________________",
        );
        await user();
        notifyListeners();
        return 200;
      } else {
        print("Credenciales incorrectas\n${respuesta.body}");
        return 401;
      }
    } catch (e) {
      print("Error de conexión\n$e");
      return 404;
    }
  }

  Future<Map> user() async {
    try {
      final url = Uri.parse("$_url/user");
      final respuesta = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_token",
          "Content-Type": "application/json",
        },
      );
      if (respuesta.statusCode == 200) {
        print("DATOS:\n${respuesta.body}\n___________________________");
        final data = jsonDecode(respuesta.body)["user"];
        if (data is! Map) {
          return {"respuesta": "sin dato"};
        }

        datos = data;
        await _datosTemporales.guardarDatos(data);
        notifyListeners();
        return data;
      } else {
        print("Credenciales incorrectas\n${respuesta.body}");
        return {"respuesta": "sin dato"};
      }
    } catch (e) {
      print("Error de conexión\n$e");
      return {"error": "$e"};
    }
  }

  Future<bool> registrarBusqueda(Map mapa) async {
    if (_token == null || _token!.isEmpty) {
      print("No se pudo guardar la búsqueda: no hay token de sesión");
      return false;
    }

    try {
      final url = Uri.parse("$_url/busquedas");
      final respuesta = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(mapa),
      );

      print("Guardar búsqueda: ${respuesta.statusCode}\n${respuesta.body}");
      if (respuesta.statusCode == 201 || respuesta.statusCode == 200) {
        print("Dato agregado correctamente al historial ");
        await verBusqueda();
        return true;
      }
      return false;
    } catch (e) {
      print("Error al guardar la búsqueda\n$e");
      return false;
    }
  }

  Future<void> verBusqueda() async {
    print("obteniendo...");
    try {
      final url = Uri.parse("$_url/historial");
      final respuesta = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_token",
          "Content-Type": "application/json",
        },
      );
      print("respuesta: ${respuesta.statusCode}\n ${respuesta.body}");
      final datosHistorial = jsonDecode(respuesta.body);
      if (respuesta.statusCode == 200 && datosHistorial is Map) {
        historial = _conservarUltimosVeinte(datosHistorial);
        await _datosTemporales.guardarHistorial(historial);
        notifyListeners();
      } else {
        await cargarHistorialGuardado();
      }
      // if(respuesta.statusCode==201 || respuesta.statusCode==200){
      //  print("Dato agregado correctamente al historial ");
      //  return;
      // }
    } catch (e) {
      print("error\n$e");
      await cargarHistorialGuardado();
    }
  }

  Map _conservarUltimosVeinte(Map datosHistorial) {
    final registros = datosHistorial["historial"];
    if (registros is! List) return datosHistorial;

    final ordenados = registros.whereType<Map>().toList();
    ordenados.sort((a, b) {
      final fechaA =
          DateTime.tryParse('${a["fecha_registro"] ?? ""}') ??
          DateTime.fromMillisecondsSinceEpoch(0);
      final fechaB =
          DateTime.tryParse('${b["fecha_registro"] ?? ""}') ??
          DateTime.fromMillisecondsSinceEpoch(0);
      return fechaB.compareTo(fechaA);
    });

    return {...datosHistorial, "historial": ordenados.take(20).toList()};
  }

  Future<void> cargarHistorialGuardado() async {
    final historialGuardado = await _datosTemporales.obtenerHistorial();
    if (historialGuardado == null) return;

    historial = _conservarUltimosVeinte(historialGuardado);
    notifyListeners();
  }
}
