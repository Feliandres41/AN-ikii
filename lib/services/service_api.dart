import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/datos_temporales.dart';

class ServiceApi extends ChangeNotifier {
  final _url = "https://caa-fonseca.education/api";
  final _datosTemporales = DatosTemporales();
  String? _token;
  Map? datos;

  Future<int> logout() async {
    final token = _token;
    if (token != null && token.isNotEmpty) {
      _token = null;
      datos = null;
      await _datosTemporales.eliminarToken();
      notifyListeners();

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
        if (datos != null) {
          await _datosTemporales.guardarDatos(datos!);
        }
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
        datos = data;
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
}
