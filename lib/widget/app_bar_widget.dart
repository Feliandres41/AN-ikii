import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/services.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({
    super.key,
  });
  static bool info = false;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  Color iconoStatus = Colors.green;
  // void iconoEstado(NetworkStatus estado){
  //   if(estado== NetworkStatus.connected){
  //     print("ASLKDHASBF ASCCLSADHNASM");
  //     setState(() {
  //       iconoStatus = Colors.green;
  //     });
  //   }else if(estado== NetworkStatus.connecting){
  //     setState(() {
  //       iconoStatus = const Color.fromARGB(255, 126, 126, 5);
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    var providerNet = Provider.of<NetworkService>(context).status;
    print("_______________________________________________________\n estado: ${providerNet}  tipo: ${providerNet.runtimeType}\n");
    final ancho = MediaQuery.of(context).size.height;//sirve para responsive
    final tamanoTitulo = (ancho * 0.065).clamp(22.0, 30.0).toDouble();
    final temas = Provider.of<ThemeApk>(context);
    // iconoEstado(providerNet);
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        leading: !AppBarWidget.info 
        ?Container(
          width: ancho * 0.2,
          height: ancho * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/logo.png")),
          ),
        )
        : IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_outlined,color: temas.verdeClaroTranslucidoFijo,)),
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
                child: Icon(
                  providerNet == NetworkStatus.disconnected   ?Icons.wifi_off_outlined :  providerNet == NetworkStatus.connecting ? Icons.wifi_2_bar_outlined : Icons.wifi, 
                  color: providerNet == NetworkStatus.disconnected 
                  ?const Color.fromARGB(255, 207, 50, 39)
                  : providerNet == NetworkStatus.connecting 
                  ? const Color.fromARGB(255, 224, 209, 67)
                  : Colors.green
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
