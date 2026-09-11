import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget{
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    final temas = Provider.of<ThemeApk>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),

      body: Column(
        children: [],
      ),







      bottomNavigationBar: BottomnavigationbarWidget(
        ancho: ancho,
        alto: MediaQuery.of(context).size.height,
        nombrePantalla: "historial",
      ),
    );
  }
}