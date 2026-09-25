import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/router/router_app.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:provider/provider.dart';

void main(){
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(ProviderApi());
}

class ProviderApi extends StatelessWidget{
  const ProviderApi({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>ServiceApi()),
      ChangeNotifierProvider(create: (_)=>ThemeApk())
    ],child: Myapp(),);
  }
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouterApp.rutaInicial,
      routes: RouterApp.rutas,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeApk>(context).temaGeneral,
    );
  }
}
