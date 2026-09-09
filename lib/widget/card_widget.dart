import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget{
  CardWidget({
    super.key,
    required this.shadowCard,
    required this.colorCard,
    required this.ancho,
    required this.alto,
    required this.elevacion,
    required this.contenido,
    required this.decoracion
  });
  Color shadowCard;
  Color colorCard;
  double ancho;
  double alto;
  double elevacion;
  Widget contenido;
  Decoration decoracion;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowCard,
      color: colorCard,
      elevation: elevacion,
      child: Container(
        width: ancho,
        height: alto,
        decoration: decoracion,
        child: contenido,
      ),
    );
  }
}