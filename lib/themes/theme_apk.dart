import 'package:flutter/material.dart';

class ThemeApk extends ChangeNotifier{
  ThemeApk(){
    modo(false);
  }
  var fondoClaro = Color(0xffF0F0EA);


  //modo oscuro
  static final modoOscuro = ThemeData.dark().copyWith(
  );
  static final verdeModoOscuro = Color(0xDFAACA19);
  static final bordeModoOscuro = Color(0xff4B3B68);
  static final fondoModoOscuro = Color(0xEF1D1929);
  ThemeData temaGeneral = ThemeData.dark().copyWith();
  var claro = false;

  //modo oscuro(configuracion)

   var letrasModoOscuro;
   var cardDesc;
   var bordercardDesc;
   var textcardDesc;

  Future<void> modo(bool cambioModo)async {
    if(!cambioModo){
      claro = false;
      temaGeneral = ThemeData.dark().copyWith(
        //modo oscuro



        //configuracion
      );
      //modo oscuro (configuracion)
      cardDesc = Color(0xEF1D1929);
      bordercardDesc = Color(0xff4B3B68);
      textcardDesc = Color(0xDFC5E43D);
      notifyListeners();
    }else{
      claro = true;
      temaGeneral = ThemeData.light().copyWith(
        
      );
      //modo oscuro (configuracion)
      cardDesc = Colors.white;
      bordercardDesc = Color(0x3D000000);
      textcardDesc = Colors.black;
      notifyListeners();
    }
  }
}