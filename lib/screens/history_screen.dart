import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/config/voice_config.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:flutter_application_1/widget/card_widget.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ServiceApi>().verBusqueda();
    });
  }

  int cartaPrincipal = 0;

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.sizeOf(context).width;
    final anchoTexto = anchoDiseno(context);
    final alto = MediaQuery.of(context).size.height;
    final temas = Provider.of<ThemeApk>(context);
    //paginacion

    // final datos = Provider.of<ServiceApi>(context).verBusqueda();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(AppBarWidget.altura),
          child: AppBarWidget(),
        ),
        body: Column(
          children: [
            Container(
              color: !temas.claro
                  ? Color.fromARGB(195, 20, 16, 43)
                  : temas.blanco,
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(top: alto * 0.01),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Historial de Términos",
                              style: TextStyle(
                                color: temas.letrasModoOscuro,
                                fontSize: anchoTexto * 0.055,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                    indicatorColor: ThemeApk.verdeModoOscuro,
                    labelColor: ThemeApk.verdeModoOscuro,
                    indicatorAnimation: TabIndicatorAnimation.linear,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: anchoTexto * 0.02,
                          children: [
                            Icon(Icons.layers_outlined),
                            Text("Lista"),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: anchoTexto * 0.02,
                          children: [Icon(Icons.menu_book), Text("Tabla")],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<ServiceApi>(
              builder: (context, value, child) {
                final lista = value.historial["historial"] as List? ?? [];

                return lista.isNotEmpty
                    ? Expanded(
                        child: TabBarView(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: alto * 0.02),
                                // Text("${Provider.of<ServiceApi>(context).historial["historial"].length} Términos registrados"),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      final registro = lista[index];
                                      final busqueda = registro is Map
                                          ? registro["busqueda"]
                                          : null;
                                      final objeto = busqueda is Map
                                          ? busqueda["objeto_esp"]
                                          : null;
                                      return Column(
                                        children: [
                                          CardWidget(
                                            alto: alto * 0.09,
                                            ancho: ancho * 0.9,
                                            decoracion: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                                bottom: alto * 0.01,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${busqueda["objeto_esp"]}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize:
                                                              anchoTexto * 0.05,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "EN",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  anchoTexto * 0.04,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: temas
                                                                  .moradoClaroFijo,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: anchoTexto * 0.015,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              busqueda["objeto_eng"],
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontSize: anchoTexto * 0.04,
                                                                fontWeight: FontWeight.bold,
                                                                color: temas.verdeClaroTranslucidoFijo,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: anchoTexto * 0.015,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "${busqueda["pronunciacion"]}",
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontSize: anchoTexto * 0.04,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await Future.delayed(
                                                        Duration(seconds: 1),
                                                      );
                                                      VoiceConfig.hablar(
                                                        busqueda["objeto_eng"],
                                                      );
                                                    },
                                                    child: CardWidget(
                                                      ancho: anchoTexto * 0.08,
                                                      alto: anchoTexto * 0.08,

                                                      decoracion: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        color: Color(
                                                          0xFFA47AF3,
                                                        ),
                                                      ),

                                                      contenido: Icon(
                                                        Icons
                                                            .volume_up_outlined,
                                                        color: temas.blanco,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: alto * 0.02),
                                        ],
                                      );
                                    },
                                    // separatorBuilder: (_,_)=>Divider(),
                                    itemCount: lista.length,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: alto * 0.01),
                                  child: Column(
                                    children: [
                                      SizedBox(height: alto * 0.02),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Tarjeta ${cartaPrincipal + 1} de ${lista.length}",
                                            style: TextStyle(
                                              color: temas.letrasModoOscuro,
                                              fontSize: anchoTexto * 0.05,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await Future.delayed(
                                                Duration(seconds: 1),
                                              );
                                              VoiceConfig.hablar(
                                                lista[cartaPrincipal]["busqueda"]["objeto_eng"],
                                              );
                                            },
                                            icon: Icon(
                                              Icons.volume_up_outlined,
                                              size: anchoTexto * 0.08,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: alto * 0.02),
                                      CardWidget(
                                        ancho: ancho * 0.9,
                                        alto: alto * 0.46,
                                        decoracion: BoxDecoration(
                                          border: Border.all(
                                            color: Provider.of<ThemeApk>(
                                              context,
                                            ).bordercardDesc,
                                          ),
                                          color: temas.fondoCartaModo,
                                        ),
                                        //lista[0]["busqueda"]
                                        contenido: Column(
                                          children: [
                                            SizedBox(height: alto * 0.01),
                                            Text(
                                              lista[cartaPrincipal]["busqueda"]["objeto_esp"],
                                              style: TextStyle(
                                                color: temas.letrasModoOscuro,
                                                fontSize: anchoTexto * 0.055,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              spacing: anchoTexto * 0.02,
                                              children: [
                                                Text(
                                                  lista[cartaPrincipal]["busqueda"]["objeto_eng"],
                                                  style: TextStyle(
                                                    fontSize: anchoTexto * 0.055,
                                                    fontWeight: FontWeight.bold,
                                                    color: temas
                                                        .verdeClaroTranslucidoFijo,
                                                  ),
                                                ),

                                                Text(
                                                  lista[cartaPrincipal]["busqueda"]["pronunciacion"],
                                                  style: TextStyle(
                                                    fontSize: anchoTexto * 0.055,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              // height: 3.5,
                                              height: alto * 0.03,
                                              color: Colors.transparent,
                                            ),
                                            // SizedBox(
                                            //   height: alto*0.02,
                                            // ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    await Future.delayed(
                                                      Duration(seconds: 1),
                                                    );
                                                    VoiceConfig.hablar(
                                                      lista[cartaPrincipal]["busqueda"]["oracion_pasado"],
                                                    );
                                                  },
                                                  child: CardWidget(
                                                    ancho: ancho * 0.9,
                                                    alto: alto * 0.05,
                                                    decoracion: BoxDecoration(
                                                      color:
                                                          temas.moradoClaroFijo,
                                                      // borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    contenido: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      spacing: anchoTexto * 0.02,
                                                      children: [
                                                        Text(
                                                          "Pasado",
                                                          style: TextStyle(
                                                            fontSize:
                                                                anchoTexto * 0.038,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                              0xFF3C295C,
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .volume_up_outlined,
                                                          size: anchoTexto * 0.058,
                                                          color: Color.fromARGB(
                                                            255,
                                                            40,
                                                            16,
                                                            82,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: alto * 0.015),
                                                Text(
                                                  lista[cartaPrincipal]["busqueda"]["oracion_pasado"],
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: anchoTexto * 0.036,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //presente
                                            Divider(
                                              // height: 3.5,
                                              height: alto * 0.03,
                                              color: Colors.transparent,
                                            ),
                                            // SizedBox(
                                            //   height: alto*0.02,
                                            // ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    await Future.delayed(
                                                      Duration(seconds: 1),
                                                    );
                                                    VoiceConfig.hablar(
                                                      lista[cartaPrincipal]["busqueda"]["oracion_presente"],
                                                    );
                                                  },
                                                  child: CardWidget(
                                                    ancho: ancho * 0.9,
                                                    alto: alto * 0.05,
                                                    decoracion: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            76,
                                                            143,
                                                            214,
                                                          ),
                                                      // borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    contenido: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      spacing: anchoTexto * 0.02,
                                                      children: [
                                                        Text(
                                                          "Presente",
                                                          style: TextStyle(
                                                            fontSize:
                                                                anchoTexto * 0.038,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                const Color.fromARGB(
                                                                  255,
                                                                  13,
                                                                  31,
                                                                  51,
                                                                ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .volume_up_outlined,
                                                          size: anchoTexto * 0.058,
                                                          color: Color.fromARGB(
                                                            255,
                                                            13,
                                                            38,
                                                            65,
                                                          ),
                                                        ),

                                                        //0xFF3C295C
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: alto * 0.015),
                                                Text(
                                                  lista[cartaPrincipal]["busqueda"]["oracion_presente"],
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: anchoTexto * 0.036,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //futuro
                                            Divider(
                                              // height: 3.5,
                                              height: alto * 0.03,
                                              color: Colors.transparent,
                                            ),
                                            // SizedBox(
                                            //   height: alto*0.02,
                                            // ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    await Future.delayed(
                                                      Duration(seconds: 1),
                                                    );
                                                    VoiceConfig.hablar(
                                                      lista[cartaPrincipal]["busqueda"]["oracion_futuro"],
                                                    );
                                                  },
                                                  child: CardWidget(
                                                    ancho: ancho * 0.9,
                                                    alto: alto * 0.05,
                                                    decoracion: BoxDecoration(
                                                      // color: const Color(0xff3979BD)
                                                      color: temas
                                                          .verdeClaroTranslucidoFijo,
                                                      // borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    contenido: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      spacing: anchoTexto * 0.02,
                                                      children: [
                                                        Text(
                                                          "Futuro",
                                                          style: TextStyle(
                                                            fontSize:
                                                                anchoTexto * 0.038,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                              0xFF14361C,
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .volume_up_outlined,
                                                          size: anchoTexto * 0.058,
                                                          color: Color(
                                                            0xFF14361C,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: alto * 0.015),
                                                Text(
                                                  lista[cartaPrincipal]["busqueda"]["oracion_futuro"],
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: anchoTexto * 0.036,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Divider(),
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: alto * 0.033,
                                      left: ancho * 0.05,
                                      right: ancho * 0.05,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (cartaPrincipal > 0) {
                                              setState(() {
                                                cartaPrincipal--;
                                              });
                                            }
                                          },
                                          child: CardWidget(
                                            ancho: ancho * 0.4,
                                            alto: alto * 0.05,
                                            decoracion: BoxDecoration(
                                              border: Border.all(
                                                color: Provider.of<ThemeApk>(
                                                  context,
                                                ).bordercardDesc,
                                              ),
                                              color: temas.fondoCartaModo,
                                            ),
                                            contenido: Center(
                                              child: Text("Anterior"),
                                            ),
                                          ),
                                        ),
                                  
                                        GestureDetector(
                                          onTap: () {
                                            if (cartaPrincipal <
                                                lista.length - 1) {
                                              setState(() {
                                                cartaPrincipal++;
                                              });
                                            }
                                            print("siguiente\n $cartaPrincipal");
                                          },
                                          child: CardWidget(
                                            ancho: ancho * 0.4,
                                            alto: alto * 0.05,
                                            decoracion: BoxDecoration(
                                              border: Border.all(
                                                color: Provider.of<ThemeApk>(
                                                  context,
                                                ).bordercardDesc,
                                              ),
                                              color: temas.fondoCartaModo,
                                            ),
                                            contenido: Center(
                                              child: Text("Siguiente"),
                                            ),
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
                      )
                    : Center(child: Text("No has registrado nada"));
              },
            ),
          ],
        ),

        bottomNavigationBar: BottomnavigationbarWidget(
          ancho: ancho,
          alto: MediaQuery.of(context).size.height,
          nombrePantalla: "historial",
        ),
      ),
    );
  }
}
