
import '../screens/screens.dart';
class RouterApp {
  static final rutaInicial = "/";

  static final rutas = {
    "/":(context)=>SplashScreen(),
    // "/block":(context)=>BlockScreen(),
    "/login":(context)=>LoginScreen(),
    "/home":(context)=>HomeScreen(),
    "/ranking":(context)=>RankingScreen(),
    "/camera":(context)=>CameraScreen(),
    "/config":(context)=>ConfigScreen(),
    "/history":(context)=>HistoryScreen()
    // "/config":(context)=>ConfigScreen()
  };
}