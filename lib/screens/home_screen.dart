import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/config_screen.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/card_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{
  HomeScreen({super.key});
  Map? datosG;
  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeApk.fondoModoOscuro,
      appBar: AppBar(
        elevation: 1.1,
        backgroundColor: ThemeApk.fondoModoOscuro,
        shadowColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: 
        Text(
          "ANüikii",
          style: TextStyle(
            fontSize: ancho * 0.065,
            color: Color.fromARGB(255, 164, 122, 243),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.pushReplacementNamed(context, "/config");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConfigScreen(dato: datosG),));
            },
            child: Card(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Icon(Icons.wifi,color: Colors.green,),
              ),
            ),
          )
        ],
      ),
      body: Consumer<ServiceApi>(builder: (context, value, child) {
        final dato = value.datos;
        datosG = dato;
        return dato!.isEmpty
        ? Center(
          child: CircularProgressIndicator(
            color: ThemeApk.fondoModoOscuro,
          ),
        )
        :Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CardWidget(
                    colorCard: Colors.transparent,
                    shadowCard: Colors.transparent,
                    elevacion: 1,
                    ancho: ancho*0.9, 
                    alto: alto*0.1,
                    decoracion: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: ThemeApk.bordeModoOscuro
                      ),
                      color: ThemeApk.fondoModoOscuro
                      
                    ),
                    contenido: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: ThemeApk.verdeModoOscuro,
                              borderRadius: BorderRadius.circular(1000)
                            ),
                            child: Icon(Icons.person_3_rounded),
                          ),
                          Container(
                            width: ancho*0.5,
                            height: 50,
                            child: Column(
                              children: [
                                Text("¡Hola, ${dato["rol"]}!",style: TextStyle(
                                  fontSize: ancho*0.05
                                ),),
                                Text("Ficha: ${dato["ficha"]}",style: TextStyle(
                                  fontSize: ancho*0.03
                                ))
                              ],
                            ),
                          ),
                          Container(
                            width: ancho*0.09,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },),
    );
  }
}