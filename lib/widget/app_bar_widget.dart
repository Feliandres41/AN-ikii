import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.height;//sirve para responsive
    final tamanoTitulo = (ancho * 0.065).clamp(22.0, 30.0).toDouble();
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: Container(
          width: ancho * 0.2,
          height: ancho * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/logo.png")),
          ),
        ),
        elevation: 1.1,
        backgroundColor: Provider.of<ThemeApk>(context).cardDesc,
        shadowColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "ANüikii",
          style: TextStyle(
            fontSize: tamanoTitulo,
            color: Color(0xFFA47AF3),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.pushReplacementNamed(context, "/config");
              Navigator.pushReplacementNamed(context, "/config");
            },
            child: Card(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Icon(Icons.wifi, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
