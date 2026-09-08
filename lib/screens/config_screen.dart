
import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/widget/card_widget.dart';
import 'package:provider/provider.dart';

class ConfigScreen extends StatefulWidget{
  ConfigScreen({
    super.key,
    required this.dato
  });
  Map? dato;

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool estado = false;

  void _mostrarContenidoLegal(String titulo) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: const Text('Contenido próximamente disponible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _filaLegal({
    required IconData icono,
    required String titulo,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xff3979BD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icono, color: Colors.white, size: 21),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                titulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("Mi perfil",style: TextStyle(
      //     fontWeight: FontWeight.bold
      //   ),),
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: Container(
          width: ancho,
          height: alto,
          child: Stack(
            children: [
              Positioned(
                top: -50,
                width: ancho,
                height: alto*0.22,
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeApk.verdeModoOscuro,
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(top: alto*0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Mi perfil",style: TextStyle(
                        fontSize: ancho*0.075,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                )
              ),

              Padding(
                padding: EdgeInsets.only(top: alto*0.1),
                child: SizedBox(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CardWidget(
                            colorCard: Colors.transparent,
                            shadowCard: Colors.transparent,
                            ancho: ancho*0.9,
                            alto: alto*0.1, 
                            elevacion: 0,
                            decoracion: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: ThemeApk.fondoModoOscuro,
                              border: Border.all(color: ThemeApk.bordeModoOscuro,width: 0.5)
                            ),
                            contenido: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: alto*0.0075,
                              children: [
                                Text(widget.dato?["nombre"]),
                                Container(
                                  width: ancho*0.425,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(98, 170, 202, 25)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:10, top: 3,bottom: 3,right: 10),
                                    child: Row(
                                      children: [
                                        Text("${widget.dato?['rol']} - ${widget.dato?['ficha']}",style: TextStyle(
                                          color: Color.fromARGB(223, 197, 228, 61),//Modo claro/Modo oscuro
                                          fontSize: ancho*0.04,
                                          fontWeight: FontWeight.w600
                                        ),)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ), 
                          ),
                        ],
                      ),
                      SizedBox(
                        height: alto*0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ancho*0.06),
                            child: Text("Datos institucionales SENA",style: TextStyle(
                              fontSize: ancho*0.04,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: alto*0.02,
                      ),

                      CardWidget(
                        shadowCard: Colors.transparent, 
                        colorCard: Colors.transparent, 
                        ancho: ancho*0.9, 
                        alto: alto*0.18, 
                        elevacion: 0, 
                        decoracion: BoxDecoration(
                          color: ThemeApk.fondoModoOscuro,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: ThemeApk.bordeModoOscuro)
                        ),
                        contenido: Padding(
                          padding: EdgeInsets.only(top: alto*0.02,),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: ancho*0.04,right: ancho*0.04,bottom: alto*0.012),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Nombre completo",style: TextStyle(
                                      fontSize: ancho*0.035,
                                      color: Colors.grey
                                    ),),
                                    SizedBox(
                                      width: ancho*0.078,
                                    ),
                                    Flexible(
                                      child: Text(widget.dato?["nombre"],style: TextStyle(
                                        fontSize: ancho*0.028,
                                        fontWeight: FontWeight.w600
                                      ),maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.only(left: ancho*0.04,right: ancho*0.04,bottom: alto*0.012,top: alto*0.008),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Programa",style: TextStyle(
                                      fontSize: ancho*0.035,
                                      color: Colors.grey
                                    ),),
                                    SizedBox(
                                      width: ancho*0.2,
                                    ),
                                    Flexible(
                                      child: Text(widget.dato?["programa"],style: TextStyle(
                                        fontSize: ancho*0.028,
                                        fontWeight: FontWeight.w600
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: EdgeInsets.only(left: ancho*0.04,right: ancho*0.04,bottom: alto*0.012,top: alto*0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Ficha de caracterización",style: TextStyle(
                                      fontSize: ancho*0.035,
                                      color: Colors.grey
                                    ),),
                                    SizedBox(
                                      width: ancho*0.2,
                                    ),
                                    Flexible(
                                      child: Text('${widget.dato?["ficha"]}',style: TextStyle(
                                        fontSize: ancho*0.028,
                                        fontWeight: FontWeight.w600
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,),
                                    )
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ), 
                      ),
                      SizedBox(
                        height: alto*0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ancho*0.06),
                            child: Text("Datos institucionales SENA",style: TextStyle(
                              fontSize: ancho*0.04,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: alto*0.02,
                      ),
                      CardWidget(
                        shadowCard: Colors.transparent, 
                        colorCard: Colors.transparent, 
                        ancho: ancho*0.9, 
                        alto: alto*0.1, 
                        elevacion: 0, 
                        decoracion: BoxDecoration(
                            color: ThemeApk.fondoModoOscuro,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: ThemeApk.bordeModoOscuro)
                          ),
                        contenido: Padding(
                          padding: EdgeInsets.only(left: ancho*0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: alto*0.05,
                                height: alto*0.05,
                                
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: !estado
                                    ? const Color.fromARGB(135, 104, 58, 183)
                                    : Colors.white,
                                ),
                                child: Icon(
                                  !estado
                                  ?Icons.nightlight_outlined
                                  :Icons.sunny,
                                  color: !estado
                                  ? Colors.white
                                  : Colors.amber,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: alto*0.025),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      estado
                                      ? "Modo oscuro"
                                      : "Modo claro",style: TextStyle(
                                        fontSize: ancho*0.04,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text("Alterna entre tema claro y oscuro",style: TextStyle(
                                      fontSize: ancho*0.028,
                                      color: Colors.grey
                                    ),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: ancho*0.02),
                                child: Switch(value: estado, onChanged: (value) {
                                  setState(() {
                                    estado = value;
                                  });
                                },),
                              )
                            ],
                          ),
                        ), 
                      ),
                      SizedBox(
                        height: alto*0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ancho*0.06),
                            child: Text("Ayuda y legal",style: TextStyle(
                              fontSize: ancho*0.04,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: alto*0.02,
                      ),



                      Container(
                        width: ancho * 0.9,
                        decoration: BoxDecoration(
                          color: ThemeApk.fondoModoOscuro,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: ThemeApk.bordeModoOscuro),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _filaLegal(
                                icono: Icons.shield_outlined,
                                titulo: "Política de privacidad",
                                onTap: () => _mostrarContenidoLegal(
                                  "Política de privacidad",
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: ThemeApk.bordeModoOscuro,
                              ),
                              _filaLegal(
                                icono: Icons.description_outlined,
                                titulo: "Términos y condiciones",
                                onTap: () => _mostrarContenidoLegal(
                                  "Términos y condiciones",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: alto*0.02,
                      ),

                      SizedBox(
                        width: ancho * 0.9,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Provider.of<ServiceApi>(
                              context,
                              listen: false,
                            ).logout();
                            Navigator.pushReplacementNamed(context, "/login");
                          },
                          icon: const Icon(Icons.logout, size: 20),
                          label: const Text("Cerrar sesión"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xffff6b6b),
                            backgroundColor: const Color(0xff32191d),
                            elevation: 0,
                            side: const BorderSide(
                              color: Color(0xff74302f),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: alto*0.02,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}