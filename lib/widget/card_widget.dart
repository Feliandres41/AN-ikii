import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget{
  CardWidget({
    super.key,
    required this.ancho,
    required this.alto,
    required this.decoracion,
    required this.contenido,
  });
  double ancho;
  double alto;
  Widget contenido;
  Decoration decoracion;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho,
      height: alto,
      decoration: decoracion,
      child: contenido,
    );
  }
}