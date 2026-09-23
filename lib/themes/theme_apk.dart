import 'package:flutter/material.dart';

class ThemeApk extends ChangeNotifier{
  ThemeApk(){
    modo(true);
    coloresDeArranque();
    notifyListeners();
  }
  

  var fondoClaro = Color(0xffF0F0EA);


  //modo oscuro
  static final modoOscuro = ThemeData.dark().copyWith(
  );
  static final verdeModoOscuro = Color(0xDFAACA19);
  static final bordeModoOscuro = Color(0xff4B3B68);
  static final fondoModoOscuro = Color(0xEF1D1929);
  ThemeData temaGeneral = ThemeData.dark(
    useMaterial3: true
  ).copyWith(
  );
  var claro = true;

  //modo oscuro(configuracion)

   var verdeModoOscuroProvider = Color(0xDFAACA19);
   var fondoCartaModo;
   var bordeModerado;
   var blanco;
   var moradoClaroFijo;
   var moradoClaroTranslucidoFijo;
   var verdeClaroTranslucidoFijo;

   var letrasModoOscuro;
   var cardDesc;
   var bordercardDesc;
   var textcardDesc;
  
  void coloresDeArranque(){
    fondoCartaModo = fondoModoOscuro;
    bordeModerado = Colors.transparent;
    verdeModoOscuroProvider = Color(0xDFAACA19);
    moradoClaroFijo = Color.fromARGB(255, 140, 107, 201);
    moradoClaroTranslucidoFijo = Color.fromARGB(83, 59, 47, 92);
    blanco = Color.fromARGB(255, 255, 255, 255);
    
    verdeClaroTranslucidoFijo = Color(0xDFAACA19);

    if(claro){
      bordeModerado = Color(0xDFAACA19);
      fondoCartaModo = const Color.fromARGB(206, 255, 255, 255);
      moradoClaroTranslucidoFijo = Color.fromARGB(82, 84, 60, 148);
    }
  }
  Future<void> modo(bool cambioModo)async {
    if(!cambioModo){
      claro = false;
      letrasModoOscuro = Colors.white;
      temaGeneral = ThemeData.dark(
        useMaterial3: true
      ).copyWith(
        //modo oscuro
        scaffoldBackgroundColor: !claro ? Color(0xff1F1A38) : fondoClaro,


        //configuracion
      );
      //modo oscuro (configuracion)
      cardDesc = Color(0xEF1D1929);
      bordercardDesc = Color(0xff4B3B68);
      textcardDesc = Color(0xDFC5E43D);
      coloresDeArranque();
      notifyListeners();
    }else{
      claro = true;
      letrasModoOscuro = Colors.black;
      temaGeneral = ThemeData.light(
        useMaterial3: true
      ).copyWith(
        scaffoldBackgroundColor: !claro ? Color(0xff1F1A38) : fondoClaro,
      );
      //modo oscuro (configuracion)
      cardDesc = Colors.white;
      bordercardDesc = Color(0x3D000000);
      textcardDesc = Colors.black;
      coloresDeArranque();
      notifyListeners();
    }
  }
}