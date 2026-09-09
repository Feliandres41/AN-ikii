import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/config_screen.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:flutter_application_1/widget/card_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Map? datosG;
  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final tamanoTitulo = (ancho * 0.065).clamp(22.0, 30.0).toDouble();
    return Scaffold(
      backgroundColor: Provider.of<ThemeApk>(context).cardDesc,
      appBar: AppBar(
        leading: Container(
          width: ancho * 0.2,
          height: ancho * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/logo.png")),
          ),
        ),
        elevation: 1.1,
        backgroundColor: Provider.of<ThemeApk>(context).cardDesc,
        shadowColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "ANüikii",
          style: TextStyle(
            fontSize: tamanoTitulo,
            color: Color(0xFFA47AF3),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.pushReplacementNamed(context, "/config");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ConfigScreen()),
              );
            },
            child: Card(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Icon(Icons.wifi, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ServiceApi>(
        builder: (context, value, child) {
          final dato = value.datos;
          final esAprendiz =
              '${dato?['rol']}'.trim().toLowerCase() == 'aprendiz';
          datosG = dato;
          return dato!.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeApk.fondoModoOscuro,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CardWidget(
                            colorCard: Provider.of<ThemeApk>(context).cardDesc,
                            shadowCard: Provider.of<ThemeApk>(context).cardDesc,
                            elevacion: 1,
                            ancho: ancho * 0.9,
                            alto: 120,
                            decoracion: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Provider.of<ThemeApk>(
                                  context,
                                ).bordercardDesc,
                              ),

                              // color: ThemeApk.fondoModoOscuro
                            ),
                            contenido: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: ThemeApk.verdeModoOscuro,
                                        borderRadius: BorderRadius.circular(
                                          1000,
                                        ),
                                      ),
                                      child: const Icon(Icons.person_3_rounded),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "¡Hola, ${dato["rol"]}!",
                                            style: TextStyle(
                                              fontSize: (ancho * 0.05).clamp(
                                                18.0,
                                                28.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (esAprendiz)
                                          Text(
                                            "Ficha: ${dato["ficha"]}",
                                            style: TextStyle(
                                              fontSize: (ancho * 0.03).clamp(
                                                12.0,
                                                16.0,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        },
      ),
      bottomNavigationBar: BottomnavigationbarWidget(
        ancho: ancho,
        alto: MediaQuery.of(context).size.height,
        nombrePantalla: "inicio",
      ),
    );
  }
}
