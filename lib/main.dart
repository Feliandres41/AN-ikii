import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/router/router_app.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:provider/provider.dart';

void main(){
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // DateTime ahora = DateTime.now();

  // DateTime limite = DateTime(2026, 9, 15, 14, 42);

  // if (ahora.isAfter(limite) || ahora.isAtSameMomentAs(limite)) {
  //   runApp(
  //     MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       home: BlockScreen(),
  //     )
  //   );
  //   return;
  // }
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
      theme: Provider.of<ThemeApk>(context,).temaGeneral,
      builder: (context, child) {
        return PopScope(
          canPop: false,

          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final salir = await showDialog<bool>(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: const Text('Salir'),
                  content: const Text(
                    '¿Estás seguro de que quieres salir de la aplicación?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop(false);
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop(true);
                      },
                      child: const Text('Salir'),
                    ),
                  ],
                );
              },
            );

            if (salir == true) {
              SystemNavigator.pop();
            }
          },

          child: child!,
        );
      },
    );
  }
}
