import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool textPresentation = false;
  bool logo = false;
  bool textEstado = false;
  int a = 0;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100),() {
      setState(() {
        textPresentation = true;
      });
    },);
    Timer(Duration(seconds: 3), () {
      setState(() {
        textEstado = true;
        logo = true;
      });
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        a++;
      });
      if (a == 6) {
        setState(() {
          logo = false;
        });
        timer.cancel();
        Navigator.pushReplacementNamed(context, "/login");
      }else if(a==3){
        setState(() {
          logo = true;
        });
      }else if(a==5){
        setState(() {
          logo = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final medidas = MediaQuery.of(context).size;
    final ancho = medidas.width;
    final anchoTexto = anchoDiseno(context);
    final alto = medidas.height;
    final temas = Provider.of<ThemeApk>(context);
    print(temas.claro);
    return Scaffold(
      backgroundColor: temas.claro ? temas.fondoClaro : Colors.black,
      body:
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: alto * 0.05),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        width: logo 
                        ?ancho*0.45
                        :ancho*0.5,
                        child: Image.asset(
                          "assets/logo.png",
                          // width: ancho*0.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                      //ANüikii
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        child: textPresentation
                        ?Column(
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
                                        fontSize: anchoTexto * 0.1,
                                        fontWeight: FontWeight.bold,
                                        color: temas.moradoClaroFijo
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
                                        fontSize: anchoTexto * 0.043,
                                        fontWeight: FontWeight.w300,
                                        // color: Colors.lightGreenAccent,
                                        color: temas.claro
                                        ? Color.fromARGB(223, 116, 141, 6)
                                        : Colors.black
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
                                        fontSize: anchoTexto * 0.032,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                        : null,
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
