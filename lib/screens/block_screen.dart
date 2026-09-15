import 'package:flutter/material.dart';

class BlockScreen extends StatelessWidget{
  const BlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
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
                fontSize: ancho*0.1
              ),),
              Icon(Icons.block,size: ancho*0.1,)
            ],
          ),
        ),
      ),
    );
  }
}