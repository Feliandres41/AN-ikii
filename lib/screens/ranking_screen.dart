import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';

class RankingScreen  extends StatelessWidget{
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),




      
      
      bottomNavigationBar: BottomnavigationbarWidget(
        ancho: ancho, 
        alto: alto, 
        nombrePantalla: "ranking"),
    );
  }
}