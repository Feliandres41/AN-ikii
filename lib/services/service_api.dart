import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServiceApi extends ChangeNotifier{
  final _url = "http://10.4.62.45:8000/api";
  String? _token;
  Map? datos;

  void logout() {
    _token = null;
    datos = null;
    notifyListeners();
  }

  //login
  Future<int> login(String document, String password)async{
    try{
      final url = Uri.parse("$_url/login");
      final respuesta = await http.post(
        url,
        body:jsonEncode({
          "user_name":document,
          "password":password
        }),
        headers: {
          "Content-Type":"application/json",
        },
        
      );
      if(respuesta.statusCode==200){
        _token = jsonDecode(respuesta.body)["token"];
        print("Login exitoso\n${respuesta.body}\n_________________________________");
        await user();
        notifyListeners();
        return 200;
      }else{
        print("Credenciales incorrectas\n${respuesta.body}");
        return 401;
      }
    }catch(e){
      print("Error de conexión\n$e");
      return 404;
    }
  }

  Future<Map> user()async{
    try{
      final url = Uri.parse("$_url/user");
      final respuesta = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_token",
          "Content-Type": "application/json",
        },
      );
      if(respuesta.statusCode==200){
        print("DATOS:\n${respuesta.body}\n___________________________");
        final data = jsonDecode(respuesta.body)["user"];
        datos = data;
        notifyListeners();
        return data;
      }else{
        print("Credenciales incorrectas\n${respuesta.body}");
        return {"respuesta":"sin dato"};
      }
    }catch(e){
      print("Error de conexión\n$e");
      return {"error":"$e"};
    }
  }
}