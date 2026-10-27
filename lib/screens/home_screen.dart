import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
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
  String? _claveConsultaPuestoFicha;
  int? _puestoFicha;
  bool _consultandoPuestoFicha = false;

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

  Future<void> _consultarPuestoFicha(
    ServiceApi servicio,
    String programa,
    String numeroFicha,
  ) async {
    if (_consultandoPuestoFicha) return;
    _consultandoPuestoFicha = true;

    final puesto = await servicio.puestoFichaEnPrograma(
      programa: programa,
      numeroFicha: numeroFicha,
    );

    if (!mounted) return;
    setState(() {
      _puestoFicha = puesto;
      _consultandoPuestoFicha = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final historial = Provider.of<ServiceApi>(context).historial;
    final listaHistorial = historial["historial"] as List? ?? [];
    final _cantidad = listaHistorial.length;
    final ancho = MediaQuery.sizeOf(context).width;
    final anchoTexto = anchoDiseno(context);
    final alto = MediaQuery.of(context).size.height;
    final altoTarjetaEstadistica = (alto * 0.09)
        .clamp(80.0, 120.0)
        .toDouble();
    final temas = Provider.of<ThemeApk>(context);
    AppBarWidget.info =false;

    temas.coloresDeArranque();

    return Scaffold(
      backgroundColor: !temas.claro ? Color(0xff1F1A38) : temas.fondoClaro,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppBarWidget.altura),
        child: AppBarWidget(),
      ),

      body: Consumer<ServiceApi>(
        builder: (context, value, child) {
          final dato = value.datos;

          final esAprendiz =
              '${dato?['rol']}'.trim().toLowerCase() == 'aprendiz';

          datosG = dato;
          final programa = '${dato?["programa"] ?? ""}'.trim();
          final numeroFicha = '${dato?["ficha"] ?? ""}'.trim();
          final claveFicha = '$programa|$numeroFicha';
          if (esAprendiz &&
              programa.isNotEmpty &&
              numeroFicha.isNotEmpty &&
              _claveConsultaPuestoFicha != claveFicha) {
            _claveConsultaPuestoFicha = claveFicha;
            _puestoFicha = null;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _consultarPuestoFicha(value, programa, numeroFicha);
              }
            });
          }

          return dato == null || dato.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeApk.fondoModoOscuro,
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: (constraints.maxHeight - 44)
                            .clamp(0.0, double.infinity),
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            spacing: alto * 0.02,

                            children: [
                              SizedBox(height: alto * 0.004),
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
                                            fontSize: (anchoTexto * 0.05).clamp(
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
                                            fontSize: (anchoTexto * 0.03).clamp(
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
                        Container(
                          width: ancho * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Provider.of<ThemeApk>(
                                context,
                              ).bordercardDesc,
                            ),
                            color: temas.fondoCartaModo,
                          ),

                          child: Padding(
                            padding: EdgeInsets.only(
                              left: ancho * 0.05,
                              top: alto * 0.01,
                              right: ancho * 0.05,
                              bottom: alto * 0.02,
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  "¿Qué tienes frente a ti?",

                                  style: TextStyle(
                                    color: temas.letrasModoOscuro,
                                    fontSize: anchoTexto * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  "Aprende su nombre técnico, término en inglés y pronunciación.",

                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: anchoTexto * 0.035,
                                  ),

                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: alto * 0.01),

                                Row(
                                  spacing: anchoTexto * 0.03,

                                  children: [
                                    CardWidget(
                                      ancho: anchoTexto * 0.08,
                                      alto: anchoTexto * 0.08,

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
                                        fontSize: anchoTexto * 0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: alto * 0.015),

                                Row(
                                  spacing: anchoTexto * 0.03,

                                  children: [
                                    CardWidget(
                                      ancho: anchoTexto * 0.08,
                                      alto: anchoTexto * 0.08,

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
                                        fontSize: anchoTexto * 0.035,
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
                                      ancho: ancho * 0.8,
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

                                        spacing: anchoTexto * 0.03,

                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            size: anchoTexto * 0.06,
                                          ),

                                          Text(
                                            "Probar escaner",

                                            style: TextStyle(
                                              color: temas.letrasModoOscuro,
                                              fontSize: anchoTexto * 0.04,
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
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Provider.of<ThemeApk>(
                                    context,
                                  ).bordercardDesc,
                                ),
                                color: temas.fondoCartaModo,
                              ),
                              child: SizedBox(
                                width: ancho * 0.9,
                                child: Flex(
                                direction: Axis.vertical,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: alto * 0.015,
                                      left: anchoTexto * 0.08,
                                      right: anchoTexto * 0.08,
                                      bottom: glosario ? 0 : alto * 0.015,
                                    ),
                                    child: Row(
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
                                                fontSize: anchoTexto * 0.055,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            Text(
                                              "$cantidadGlosario términos",

                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: anchoTexto * 0.035,
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

                                            size: anchoTexto * 0.075,

                                            color: temas.textcardDesc,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (glosario)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: anchoTexto * 0.08,
                                        right: anchoTexto * 0.08,
                                        bottom: alto * 0.015,
                                      ),
                                      child: Column(
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
                                                                        anchoTexto *
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
                                                                            anchoTexto *
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
                                                                            anchoTexto *
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
                                        ),
                                      ),
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
                        Padding(
                          padding: EdgeInsets.only(top: alto * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: anchoTexto * 0.1,
                            children: [
                              CardWidget(
                                ancho: ancho * 0.399,
                                alto: altoTarjetaEstadistica,
                                decoracion: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: temas.bordercardDesc,
                                  ),
                                  color: temas.fondoCartaModo,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                contenido: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: (ancho * 0.025).clamp(
                                      8.0,
                                      14.0,
                                    ),
                                  ),
                                  child: Row(
                                    spacing: anchoTexto * 0.025,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color:
                                              temas.verdeClaroTranslucidoFijo,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: Icon(
                                          Icons.history_rounded,
                                          color: temas.letrasModoOscuro,
                                          size: 22,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Historial",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: (anchoTexto * 0.03)
                                                    .clamp(11.0, 14.0),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "$_cantidad",
                                              style: TextStyle(
                                                color: temas.letrasModoOscuro,
                                                fontSize: (anchoTexto * 0.05)
                                                    .clamp(20.0, 26.0),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              CardWidget(
                                ancho: ancho * 0.399,
                                alto: altoTarjetaEstadistica,
                                decoracion: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: temas.bordercardDesc,
                                  ),
                                  color: temas.fondoCartaModo,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                contenido: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: (ancho * 0.025).clamp(
                                      8.0,
                                      14.0,
                                    ),
                                  ),
                                  child: Row(
                                    spacing: anchoTexto * 0.025,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color:
                                              temas.verdeClaroTranslucidoFijo,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: Icon(
                                          Icons.leaderboard_rounded,
                                          color: temas.letrasModoOscuro,
                                          size: 22,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Puesto ficha",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: (anchoTexto * 0.03)
                                                    .clamp(11.0, 14.0),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              _puestoFicha == null
                                                  ? "—"
                                                  : "#$_puestoFicha",
                                              style: TextStyle(
                                                color: temas.letrasModoOscuro,
                                                fontSize: (anchoTexto * 0.05)
                                                    .clamp(20.0, 26.0),
                                                fontWeight: FontWeight.bold,
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: ancho * 0.08,
                            right: ancho * 0.08,
                            bottom: alto * 0.01,
                            top: alto * 0.01,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.auto_stories_outlined,
                                size: anchoTexto * 0.04,
                                color: temas.verdeClaroTranslucidoFijo,
                              ),
                              SizedBox(width: anchoTexto * 0.02),
                              Flexible(
                                child: Text(
                                  "Sigue aprendiendo paso a paso",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: (anchoTexto * 0.03).clamp(
                                      11.0,
                                      14.0,
                                    ),
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
