import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/model_ia_config.dart';
import 'package:flutter_application_1/screens/camera_screen.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:provider/provider.dart';

class BottomnavigationbarWidget extends StatefulWidget {
  BottomnavigationbarWidget({
    super.key,
    required this.ancho,
    required this.alto,
    required this.nombrePantalla,
    this.tomarFoto,
    this.onResultado,
  });
  double ancho;
  double alto;
  String nombrePantalla;
  final Future<XFile?> Function()? tomarFoto;
  final ValueChanged<Map?>? onResultado;

  @override
  State<BottomnavigationbarWidget> createState() =>
      _BottomnavigationbarWidgetState();
}

bool estado = false;
bool cargandoDatos = false;

class _BottomnavigationbarWidgetState extends State<BottomnavigationbarWidget> {
  bool _navegandoACamara = false;

  void animacion() {
    Timer(Duration(milliseconds: 100), () {
      if (!mounted) return;
      setState(() {
        estado = true;
      });
    });
    Timer(Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        estado = false;
      });
    });
  }
  @override
  void initState(){
    cargandoDatos = false;
  }

  @override
  Widget build(BuildContext context) {
    var nombre = widget.nombrePantalla;
    var ancho = MediaQuery.sizeOf(context).width;
    var anchoDiseno = widget.ancho;
    var alto = widget.alto;
    var temas = Provider.of<ThemeApk>(context);
    final altoBarra = (alto * 0.09).clamp(64.0, 76.0).toDouble();
    final tamanoCamara = (anchoDiseno * 0.15).clamp(56.0, 72.0).toDouble();
    final tamanoIconoCamara = (tamanoCamara * 0.6).clamp(28.0, 40.0).toDouble();
    final altoBarraConCamara = altoBarra + tamanoCamara / 2;
    return Container(
      width: ancho,
      height: altoBarraConCamara,
      decoration: BoxDecoration(
        border: Border.all(color: temas.bordercardDesc),
        color: temas.cardDesc,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: (ancho * 0.04).clamp(12.0, 24.0),
          right: (ancho * 0.04).clamp(12.0, 24.0),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        nombre != "inicio"
                            ? Navigator.pushReplacementNamed(context, "/home")
                            : null;
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: nombre == "inicio"
                                ? ThemeApk.verdeModoOscuro
                                : Colors.grey,
                          ),
                          Text(
                            "Inicio",
                            style: TextStyle(
                              color: nombre == "inicio"
                                  ? ThemeApk.verdeModoOscuro
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //hstorial
                    GestureDetector(
                      onTap: () {
                        nombre != "historial"
                            ? Navigator.pushReplacementNamed(
                                context,
                                "/history",
                              )
                            : null;
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.history,
                            color: nombre == "historial"
                                ? ThemeApk.verdeModoOscuro
                                : Colors.grey,
                          ),
                          Text(
                            "Historial",
                            style: TextStyle(
                              color: nombre == "Historial"
                                  ? ThemeApk.verdeModoOscuro
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   child: Column(
                    //     children: [
                    //       Icon(Icons.camera_alt_outlined,color: nombre=="camara"
                    //         ? ThemeApk.verdeModoOscuro
                    //         : Colors.grey,),
                    //       Text("Camara",style: TextStyle(color: nombre=="camara"
                    //         ? ThemeApk.verdeModoOscuro
                    //         : Colors.grey),),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(width: ancho * 0.1),

                    GestureDetector(
                      onTap: () {
                        nombre!="ranking"
                        ?Navigator.pushReplacementNamed(context, "/ranking")
                        :null;
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.leaderboard_outlined,
                            color: nombre == "ranking"
                                ? ThemeApk.verdeModoOscuro
                                : Colors.grey,
                          ),
                          Text(
                            "Ranking",
                            style: TextStyle(
                              color: nombre == "ranking"
                                  ? ThemeApk.verdeModoOscuro
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        nombre != "perfil"
                            ? Navigator.pushReplacementNamed(context, "/config")
                            : null;
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_outlined,
                            color: nombre == "perfil"
                                ? ThemeApk.verdeModoOscuro
                                : Colors.grey,
                          ),
                          Text(
                            "Perfil",
                            style: TextStyle(
                              color: nombre == "perfil"
                                  ? ThemeApk.verdeModoOscuro
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 800),
              bottom: nombre != "camara"
                  ? altoBarraConCamara - tamanoCamara
                  : altoBarraConCamara - tamanoCamara,
              // estado ? 10
              // : alto*0.04,
              left: ancho / 2 - tamanoCamara / 1.5,
              child: GestureDetector(
                onTap: () async {
                  if (_navegandoACamara) return;
                  if (nombre == "camara") {
                    setState(() {
                      cargandoDatos = true;
                    });
                  }

                  if (nombre != "camara") {
                    _navegandoACamara = true;
                    print("Navegando");
                    // setState(() {
                    //   estado = !estado;
                    // });
                    // !estado ? animacion() : null;
                    // Provider.of<ThemeApk>(context, listen: false).modo(estado);
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CameraScreen()),
                    );
                  } else {
                    final foto = await widget.tomarFoto?.call();
                    if (foto == null) {
                      if (context.mounted) {
                        setState(() {
                          cargandoDatos = false;
                        });
                      }
                      return;
                    }

                    final imagenBytes = await foto.readAsBytes();
                    if (!context.mounted) return;

                    final resultado = await ModelIaConfig.mandarImagen(
                      imagenBytes,
                      context,
                    );
                    widget.onResultado?.call(resultado);
                    if (!context.mounted) return;
                    setState(() {
                      cargandoDatos = false;
                    });
                  }
                  if (!mounted) return;
                  setState(() {
                    cargandoDatos = false;
                  });
                },
                child: Container(
                  width: tamanoCamara,
                  height: tamanoCamara,
                  decoration: BoxDecoration(
                    // image:DecorationImage(image: AssetImage("assets/logo.png")),
                    color: const Color(0xDFAACA19),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    key: ValueKey("Boton de camara"),
                    child: !cargandoDatos
                        ? Icon(
                            Icons.camera_alt_outlined,
                            size: tamanoIconoCamara,
                            color:
                                // Color(0xFFA47AF3)
                                nombre == "camara"
                                ? Colors.white
                                : Colors.black,
                          )
                        : CircularProgressIndicator(
                            color: nombre == "camara"
                                ? Colors.white
                                : Colors.black,
                          ),
                  ),
                  // Icon(
                  //   Icons.camera_alt_outlined,
                  //   size: tamanoIconoCamara,
                  //   color:
                  //       // Color(0xFFA47AF3)
                  //       nombre == "camara" ? Colors.white : Colors.black,
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
