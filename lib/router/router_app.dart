import 'package:flutter_application_1/screens/home_screen.dart';

import '../screens/screens.dart';
class RouterApp {
  static final rutaInicial = "/";

  static final rutas = {
    "/":(context)=>SplashScreen(),
    "/login":(context)=>LoginScreen(),
    "/home":(context)=>HomeScreen(),
    "/config":(context)=>ConfigScreen()
    // "/config":(context)=>ConfigScreen()
  };
}