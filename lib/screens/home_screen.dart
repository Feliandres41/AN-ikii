import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/voice_config.dart';
import 'package:flutter_application_1/models/glosario_model.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:flutter_application_1/widget/card_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
  Datos del servidor
  */
  int cantidadGlosario = 6;
  // int cantidad = 3;

  List<GlosarioModel> glosarioTecnico = [
    //1
    GlosarioModel(
      nombreEsp: "Desarrollo de software",
      nombreEng: "Software Development",
    ),
    //2
    GlosarioModel(nombreEsp: "Base de datos", nombreEng: "Database"),
    //3
    GlosarioModel(
      nombreEsp: "Interfaz de usuario",
      nombreEng: "User Interface (UI)",
    ),
    //4
    GlosarioModel(nombreEsp: "Programación", nombreEng: "Programming"),
    //5
    GlosarioModel(nombreEsp: "Depuración de código", nombreEng: "Debugging"),
    //6
    GlosarioModel(
      nombreEsp: "Control de versiones",
      nombreEng: "Version Control",
    ),
  ];

  ////////
  bool glosario = false;

  Map? datosG;

  @override
  Widget build(BuildContext context) {
    final historial = Provider.of<ServiceApi>(context).historial;
    final listaHistorial = historial["historial"] as List? ?? [];
    final _cantidad = listaHistorial.length;
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    final temas = Provider.of<ThemeApk>(context);
    AppBarWidget.info =false;

    temas.coloresDeArranque();

    return Scaffold(
      backgroundColor: !temas.claro ? Color(0xff1F1A38) : temas.fondoClaro,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),

      body: Consumer<ServiceApi>(
        builder: (context, value, child) {
          final dato = value.datos;

          final esAprendiz =
              '${dato?['rol']}'.trim().toLowerCase() == 'aprendiz';

          datosG = dato;

          return dato == null || dato.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeApk.fondoModoOscuro,
                  ),
                )
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 24),

                  child: Center(
                    child: Column(
                      spacing: alto * 0.02,

                      children: [
                        SizedBox(),

                        CardWidget(
                          ancho: ancho * 0.9,
                          alto: 90,

                          decoracion: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Provider.of<ThemeApk>(
                                context,
                              ).bordercardDesc,
                            ),
                            color: temas.fondoCartaModo,
                          ),

                          contenido: Padding(
                            padding: const EdgeInsets.only(left: 15),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,

                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: ThemeApk.verdeModoOscuro,
                                      borderRadius: BorderRadius.circular(1000),
                                    ),

                                    child: const Icon(Icons.person_3_rounded),
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,

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

                        SizedBox(height: alto * 0.004),

                        // informacion general de la aplicacion
                        CardWidget(
                          ancho: ancho * 0.9,
                          alto: alto * 0.28,

                          decoracion: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Provider.of<ThemeApk>(
                                context,
                              ).bordercardDesc,
                            ),
                            color: temas.fondoCartaModo,
                          ),

                          contenido: Padding(
                            padding: EdgeInsets.only(
                              left: ancho * 0.05,
                              top: alto * 0.01,
                              right: ancho * 0.05,
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "¿Qué tienes frente a ti?",

                                  style: TextStyle(
                                    color: temas.letrasModoOscuro,
                                    fontSize: ancho * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  "Aprende su nombre técnico, término en inglés y pronunciación.",

                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ancho * 0.035,
                                  ),

                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: alto * 0.01),

                                Row(
                                  spacing: ancho * 0.03,

                                  children: [
                                    CardWidget(
                                      ancho: ancho * 0.08,
                                      alto: ancho * 0.08,

                                      decoracion: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFA47AF3),
                                      ),

                                      contenido: Icon(
                                        Icons.volume_up_outlined,
                                        color: temas.blanco,
                                      ),
                                    ),

                                    Text(
                                      "Audio nativo y pronunciación",

                                      style: TextStyle(
                                        color: temas.letrasModoOscuro,
                                        fontSize: ancho * 0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: alto * 0.015),

                                Row(
                                  spacing: ancho * 0.03,

                                  children: [
                                    CardWidget(
                                      ancho: ancho * 0.08,
                                      alto: ancho * 0.08,

                                      decoracion: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: temas.verdeClaroTranslucidoFijo,
                                      ),

                                      contenido: Icon(
                                        Icons.menu_book_outlined,
                                        color: temas.blanco,
                                      ),
                                    ),

                                    Text(
                                      "Normas técnicas y SENA",

                                      style: TextStyle(
                                        color: temas.letrasModoOscuro,
                                        fontSize: ancho * 0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: alto * 0.015),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      "/camera",
                                    );
                                  },

                                  child: Center(
                                    child: CardWidget(
                                      ancho: ancho * 0.9,
                                      alto: alto * 0.05,

                                      decoracion: BoxDecoration(
                                        border: Border.all(
                                          color: temas.bordeModerado,
                                        ),
                                        color: temas.verdeClaroTranslucidoFijo,
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      contenido: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        spacing: ancho * 0.03,

                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            size: ancho * 0.06,
                                          ),

                                          Text(
                                            "Probar escaner",

                                            style: TextStyle(
                                              color: temas.letrasModoOscuro,
                                              fontSize: ancho * 0.04,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // glosario
                        Padding(
                          padding: EdgeInsets.only(
                            top: alto * 0.02,
                            bottom: alto * 0.02,
                          ),
                          child: AnimatedSize(
                            duration: Duration(seconds: 1),
                            curve: Curves.decelerate,

                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Provider.of<ThemeApk>(
                                    context,
                                  ).bordercardDesc,
                                ),
                                color: temas.fondoCartaModo,
                              ),

                              width: ancho * 0.9,

                              // CAMBIO:
                              // cerrado mantiene tu altura original.
                              // abierto deja que el contenido determine
                              // la altura para evitar overflow.
                              height: glosario ? null : alto * 0.09,

                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: alto * 0.015,
                                  left: ancho * 0.08,
                                  right: ancho * 0.08,
                                ),

                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              "Glosario Técnico",

                                              style: TextStyle(
                                                color: temas.letrasModoOscuro,
                                                fontSize: ancho * 0.055,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Text(
                                              "$cantidadGlosario términos",

                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: ancho * 0.035,
                                              ),
                                            ),
                                          ],
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              glosario = !glosario;
                                            });
                                          },

                                          icon: Icon(
                                            !glosario
                                                ? Icons.arrow_right_sharp
                                                : Icons.arrow_drop_up_sharp,

                                            size: ancho * 0.09,

                                            color: temas.textcardDesc,
                                          ),
                                        ),
                                      ],
                                    ),

                                    glosario
                                        ? Column(
                                            children: [
                                              SizedBox(height: alto * 0.02),
                                              ...glosarioTecnico.map((
                                                elemento,
                                              ) {
                                                return Column(
                                                  children: [
                                                    CardWidget(
                                                      ancho: double.infinity,
                                                      alto: alto * 0.07,
                                                      decoracion: BoxDecoration(
                                                        color: temas.cardDesc,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              30,
                                                            ),
                                                        border: Border.all(
                                                          color: temas
                                                              .bordercardDesc,
                                                        ),
                                                      ),

                                                      contenido: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                              left:
                                                                  ancho * 0.05,
                                                              top: alto * 0.01,
                                                              right:
                                                                  ancho * 0.05,
                                                            ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  elemento
                                                                      .nombreEsp,
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        ancho *
                                                                        0.038,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "EN: ",
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            ancho *
                                                                            0.033,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      elemento
                                                                          .nombreEng,
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            ancho *
                                                                            0.035,
                                                                        color: temas
                                                                            .verdeModoOscuroProvider,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Transform.translate(
                                                              offset: Offset(
                                                                0,
                                                                -5,
                                                              ),
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  VoiceConfig.hablar(
                                                                    elemento
                                                                        .nombreEng,
                                                                  );
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .volume_up_outlined,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: alto * 0.03,
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // SizedBox(
                        //   // height: alto * 0.00,
                        // ),
                        Divider(),

                        // SizedBox(
                        //   height: alto * 0.00,
                        // ),

                        // historial
                        // CardWidget(
                        //   ancho: ancho * 0.9,
                        //   alto: alto * 0.09,

                        //   decoracion: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     border: Border.all(
                        //       color: Provider.of<ThemeApk>(
                        //         context,
                        //       ).bordercardDesc,
                        //     ),
                        //     color: temas.fondoCartaModo
                        //   ),

                        //   contenido: Padding(
                        //     padding: EdgeInsets.only(
                        //       top: alto * 0.015
                        //     ),

                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           spacing: ancho * 0.07,
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.center,

                        //           children: [
                        //             Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.center,

                        //               children: [
                        //                 Text(
                        //                   "Historial de Escaneos",

                        //                   style: TextStyle(
                        //                     color:
                        //                         temas.letrasModoOscuro,
                        //                     fontSize: ancho * 0.055,
                        //                     fontWeight: FontWeight.bold
                        //                   ),
                        //                 ),

                        //                 Text(
                        //                   "$cantidad términos guardados",

                        //                   style: TextStyle(
                        //                     color: Colors.grey,
                        //                     fontSize: ancho * 0.035,
                        //                   )
                        //                 )
                        //               ],
                        //             )
                        //           ],
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // // ranking
                        // SizedBox(
                        //   height: alto * 0.004,
                        // ),

                        // CardWidget(
                        //   ancho: ancho * 0.9,
                        //   alto: alto * 0.09,

                        //   decoracion: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     border: Border.all(
                        //       color: Provider.of<ThemeApk>(
                        //         context,
                        //       ).bordercardDesc,
                        //     ),
                        //     color: temas.fondoCartaModo
                        //   ),

                        //   contenido: Padding(
                        //     padding: EdgeInsets.only(
                        //       top: alto * 0.015
                        //     ),

                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.center,

                        //           children: [
                        //             Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.center,

                        //               children: [
                        //                 Text(
                        //                   "Ranking ANüikii",

                        //                   style: TextStyle(
                        //                     color:
                        //                         temas.letrasModoOscuro,
                        //                     fontSize: ancho * 0.055,
                        //                     fontWeight: FontWeight.bold
                        //                   ),
                        //                 ),

                        //                 Text(
                        //                   "Proximamente",

                        //                   style: TextStyle(
                        //                     color: const Color.fromARGB(
                        //                       255,
                        //                       233,
                        //                       217,
                        //                       72
                        //                     ),
                        //                     fontSize: ancho * 0.035,
                        //                   )
                        //                 )
                        //               ],
                        //             ),
                        //           ],
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // )
                        Padding(
                          padding: EdgeInsets.only(top: ancho * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: ancho * 0.2,
                            children: [
                              CardWidget(
                                ancho: ancho * 0.35,
                                alto: alto * 0.09,

                                decoracion: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Provider.of<ThemeApk>(
                                      context,
                                    ).bordercardDesc,
                                  ),
                                  color: temas.fondoCartaModo,
                                ),
                                contenido: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.history_sharp,
                                      size: ancho * 0.09,
                                    ),
                                    Text(
                                      "$_cantidad",
                                      style: TextStyle(fontSize: ancho * 0.05),
                                    ),
                                  ],
                                ),
                              ),

                              CardWidget(
                                ancho: ancho * 0.35,
                                alto: alto * 0.09,

                                decoracion: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Provider.of<ThemeApk>(
                                      context,
                                    ).bordercardDesc,
                                  ),
                                  color: temas.fondoCartaModo,
                                ),
                                contenido: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.leaderboard_outlined,
                                      size: ancho * 0.09,
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(fontSize: ancho * 0.05),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
