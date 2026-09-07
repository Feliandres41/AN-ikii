import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool fondo = false;
  bool ocultar = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1, milliseconds: 300), (timer) {
      setState(() {
        fondo = !fondo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final medidas = MediaQuery.of(context).size;
    final ancho = medidas.width;
    final alto = medidas.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: alto * 0.3,
            left: ancho * 0.05,
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: fondo ? 1 : 0,
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                width: fondo ? ancho : 0,
                height: fondo ? alto * 0.5 : 0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(34, 101, 72, 189),
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
            ),
          ),
          Center(
            child: Card(
              color: Color.fromARGB(240, 29, 25, 41),
              child: Container(
                width: ancho * 0.9,
                height: alto * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff4B3B68), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(153, 77, 172, 14),
                              borderRadius: BorderRadius.circular(1000),
                              image: DecorationImage(
                                image: AssetImage("assets/logo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child: Text("Logo"),
                          ),
                        ],
                      ),
                      SizedBox(height: alto * 0.04),
                      Text(
                        "ANüikii",
                        style: TextStyle(
                          fontSize: ancho * 0.07,
                          color: Color.fromARGB(255, 164, 122, 243),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: alto * 0.04),
                      SizedBox(
                        width: ancho * 0.75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Número de documento"),
                            SizedBox(height: alto * 0.01),
                            TextField(
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 164, 122, 243),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 164, 122, 243),
                                  ),
                                ),
                                prefixIcon: Icon(Icons.badge_outlined),
                                prefixIconColor: Color.fromARGB(
                                  255,
                                  164,
                                  122,
                                  243,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //contraseña
                      SizedBox(height: alto * 0.04),
                      SizedBox(
                        width: ancho * 0.75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contraseña"),
                            SizedBox(height: alto * 0.01),
                            TextField(
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 164, 122, 243),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 164, 122, 243),
                                  ),
                                ),
                                prefixIcon: Icon(Icons.key),
                                prefixIconColor: Color.fromARGB(
                                  255,
                                  164,
                                  122,
                                  243,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                    ocultar = !ocultar;
                                  },
                                  child: Icon(
                                    ocultar
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                suffixIconColor: ocultar
                                    ? Colors.grey
                                    : Colors.white,
                              ),
                            ),
                            SizedBox(height: alto * 0.02),
                            Center(
                              child: Text(
                                "Ingresar con tus credenciales asignadas del sena",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ancho * 0.03,
                                ),
                              ),
                            ),
                            SizedBox(height: alto * 0.01),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffA9CA19),
                                fixedSize: Size(ancho * 0.75, alto * 0.02),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Iniciar Sesión",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.arrow_right_outlined,
                                    size: ancho * 0.1,
                                    color: Colors.black,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
