import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool textEstado = false;
  int a = 0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        textEstado = true;
      });
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        a++;
      });
      if (a == 6) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final medidas = MediaQuery.of(context).size;
    final ancho = medidas.width;
    final alto = medidas.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          // Stack(
          //   children: [
          //     Positioned(
          //       key: ValueKey("Icono"),
          //       top: alto * 0.1,
          //       // right: ancho * 0.01,
          //       child: GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             textEstado = !textEstado;
          //           });
          //         },
          //         child: Image.asset(
          //           'assets/sena_splash.gif',
          //           // width: size.clamp(160.0, 320.0),
          //           // height: size.clamp(160.0, 320.0),
          //           width: ancho,
          //           fit: BoxFit.contain,
          //           errorBuilder: (context, error, stackTrace) =>
          //               IconoSplash(size: size.clamp(160.0, 320.0)),
          //         ),
          //       ),
          //     ),
          //     AnimatedContainer(
          //       duration: Duration(seconds: 1),
          //       height: !textEstado ? 0 : alto * 0.02,
          //       child: Text("PRUEBA INTERNA"),
          //     ),
          //   ],
          // ),
          Stack(
            // fit: StackFit.loose,
            children: [
              Positioned(
                top: alto * 0.2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {});
                    textEstado = !textEstado;
                  },
                  child: Image.asset("assets/splashs.gif", width: ancho),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: alto * 0.4),
                      // TweenAnimationBuilder<double>(
                      //   tween: Tween(
                      //     begin: 0,
                      //     end: textEstado ? ancho * 0.1 : 0,
                      //   ),
                      //   duration: const Duration(milliseconds: 700),
                      //   curve: Curves.easeOutBack,
                      //   builder: (context, fontSize, child) {
                      //     return Text(
                      //       "ANüikii",
                      //       style: TextStyle(
                      //         fontSize: fontSize,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     );
                      //   },
                      // ),

                      //ANüikii
                      Column(
                        spacing: 10,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 0.0,
                              end: textEstado ? 1.0 : 0.0,
                            ),
                            duration: const Duration(
                              milliseconds: 500,
                              seconds: 1,
                            ),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Opacity(
                                  opacity: value.clamp(0.0, 1.0),
                                  child: Text(
                                    'ANüikii',
                                    style: TextStyle(
                                      fontSize: ancho * 0.1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          //sub
                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 0.0,
                              end: textEstado ? 0.9 : 0.0,
                            ),
                            duration: const Duration(
                              milliseconds: 800,
                              seconds: 2,
                            ),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Opacity(
                                  opacity: value.clamp(0.0, 1.0),
                                  child: Text(
                                    'BILINGÜISMO TECNICO AGROPECUARIO',
                                    style: TextStyle(
                                      fontSize: ancho * 0.04,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.lightGreenAccent,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          //sub-sub
                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 0.0,
                              end: textEstado ? 0.9 : 0.0,
                            ),
                            duration: const Duration(
                              // milliseconds: 1000,
                              seconds: 2,
                            ),
                            curve: Curves.easeOutBack,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Opacity(
                                  opacity: value.clamp(0.0, 1.0),
                                  child: Text(
                                    'SERVICIO NACIONAL DE APRENDIZAJE - COLOMBIA',
                                    style: TextStyle(
                                      fontSize: ancho * 0.03,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
