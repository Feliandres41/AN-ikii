import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';

class BlockScreen extends StatelessWidget{
  const BlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.sizeOf(context).width;
    final anchoTexto = anchoDiseno(context);
    final alto = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: ancho*0.9,
          height: alto*0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Beta terminada ",style: TextStyle(
                fontSize: anchoTexto*0.1
              ),),
              Icon(Icons.block,size: anchoTexto*0.1,)
            ],
          ),
        ),
      ),
    );
  }
}