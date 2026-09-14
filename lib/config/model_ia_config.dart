import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/scripts/ia_scripts.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';

class ModelIaConfig{
  static var mapa;
  static final _modelIa =GenerativeModel(
    model: 'gemini-3.5-flash-lite',
    apiKey: 'AQ.Ab8RN6I4vdTf3NK94l9ZNJmJUQUPO2zwbb-PdndpDL3h3nw_gQ',
  );
  
  static Future<
  void
  > mandarImagen(Uint8List imagenBytes, BuildContext context) async {
    print("___");
    try {
      final response = await _modelIa.generateContent([
        Content.multi([
          TextPart(
            // "Quiero que analices la imagen q te voy a mandar y solo enfocate en lo principal,e ignora lo q esta alrededor y dime que es el objeto",
            IaScripts.analisisDatos,
          ),
          DataPart('image/jpeg', imagenBytes),
        ]),
      ]);
      if (response != null) {
        String? respuesta = response.text;
        print("Dato obtenido correctamente\n${response.text}");
        mapa = jsonDecode(respuesta!);
        Provider.of<ServiceApi>(context,listen: false).registrarBusqueda(mapa);
        // return response.text;
      }
    } catch (e) {
      print("Error\n$e\n____________________________");
    }
    // return "Error al mostrar";
  }
}