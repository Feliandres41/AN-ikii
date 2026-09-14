import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DatosTemporales {
  static const String _claveToken = 'token';
  static const String _claveDatos = 'datos_usuario';
  static const String _claveHistorial = 'historial_usuario';

  Future<void> guardarToken(String token) async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setString(_claveToken, token);
  }

  Future<String?> obtenerToken() async {
    final preferencias = await SharedPreferences.getInstance();
    return preferencias.getString(_claveToken);
  }

  Future<void> guardarDatos(Map datos) async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setString(_claveDatos, jsonEncode(datos));
  }

  Future<Map?> obtenerDatos() async {
    final preferencias = await SharedPreferences.getInstance();
    final datosGuardados = preferencias.getString(_claveDatos);
    if (datosGuardados == null || datosGuardados.isEmpty) {
      return null;
    }

    final datos = jsonDecode(datosGuardados);
    return datos is Map ? datos : null;
  }

  Future<void> guardarHistorial(Map historial) async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setString(_claveHistorial, jsonEncode(historial));
  }

  Future<Map?> obtenerHistorial() async {
    final preferencias = await SharedPreferences.getInstance();
    final historialGuardado = preferencias.getString(_claveHistorial);
    if (historialGuardado == null || historialGuardado.isEmpty) {
      return null;
    }

    final historial = jsonDecode(historialGuardado);
    return historial is Map ? historial : null;
  }

  Future<void> eliminarToken() async {
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.remove(_claveToken);
    await preferencias.remove(_claveDatos);
  }
}
