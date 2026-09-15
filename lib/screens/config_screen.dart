import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:flutter_application_1/widget/card_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConfigScreen extends StatefulWidget {
  ConfigScreen({
    super.key,
    // required this.dato
  });
  // Map? dato;

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
    var temas = Provider.of<ThemeApk>(context);
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    final tamanoEtiqueta = (ancho * 0.035).clamp(14.0, 18.0).toDouble();
    final tamanoValor = (ancho * 0.028).clamp(12.0, 16.0).toDouble();
    Map? dato = Provider.of<ServiceApi>(context).datos;
    final esAprendiz = '${dato?['rol']}'.trim().toLowerCase() == 'aprendiz';
    return Scaffold(
      backgroundColor: !temas.claro ? Color(0xff1F1A38) : temas.fondoClaro,
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
          child: Stack(
            children: [
              Positioned(
                top: -50,
                width: ancho,
                height: alto * 0.22,
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeApk.verdeModoOscuro,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(top: alto * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mi perfil",
                        style: TextStyle(
                          fontSize: ancho * 0.075,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: alto * 0.1),
                child: SizedBox(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CardWidget(
                            ancho: ancho * 0.9,
                            alto: alto * 0.05,
                            decoracion: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: ThemeApk.fondoModoOscuro,
                              // color: Provider.of<ThemeApk>(context).cardDesc,
                              border: Border.all(
                                color: ThemeApk.bordeModoOscuro,
                                width: 0.5,
                              ),
                            ),
                            contenido: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: alto * 0.0075,
                              children: [
                                // Text(dato?["nombre"],style: TextStyle(
                                //   fontWeight: FontWeight.bold
                                // ),),
                                Container(
                                  width: ancho * 0.425,
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: ThemeApk.verdeModoOscuro,
                                    //   width: 0.5,
                                    // ),
                                    // borderRadius: BorderRadius.circular(20),
                                    // color: Color.fromARGB(47, 170, 202, 25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 3,
                                      bottom: 3,
                                      right: 10,
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${dato?['rol']} - SENA",
                                        style: TextStyle(
                                          color: Colors.white,
                                          // temas
                                          //     .verdeModoOscuroProvider, //Modo claro/Modo oscuro
                                          fontSize: (ancho * 0.05).clamp(
                                            14.0,
                                            20.0,
                                          ),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: alto * 0.035),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ancho * 0.06),
                            child: Text(
                              "Datos institucionales SENA",
                              style: TextStyle(
                                fontSize: ancho * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: alto * 0.02),

                      CardWidget(
                        ancho: ancho * 0.9,
                        alto: esAprendiz
                            ?
                              //fisico
                              alto * 0.22
                            //emulador
                            // (alto * 0.19).clamp(156.0, 184.0).toDouble()
                            : 88.0,
                        decoracion: BoxDecoration(
                          // color: ThemeApk.fondoModoOscuro,
                          color: temas.cardDesc,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: temas.bordercardDesc),
                        ),
                        contenido: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              if (esAprendiz)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: ancho * 0.04,
                                    right: ancho * 0.04,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.center,
                                        children: [
                                          // Expanded(
                                          //   flex: 5,
                                          //   child: Text(
                                          //     "Nombre completo",
                                          //     maxLines: 1,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     style: TextStyle(
                                          //       fontSize: tamanoEtiqueta,
                                          //       color: Colors.grey,
                                          //     ),
                                          //   ),
                                          // ),
                                          // const SizedBox(width: 8),
                                          Text(
                                            "Nombre completo",
                                            style: TextStyle(
                                              fontSize: tamanoEtiqueta,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '${dato?["nombre"] ?? "Sin nombre"}',
                                            style: TextStyle(
                                              fontSize: tamanoValor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Nombre completo",
                                          style: TextStyle(
                                            fontSize: tamanoEtiqueta,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Text(
                                            '${dato?["nombre"] ?? "Sin nombre"}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: tamanoValor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (esAprendiz) ...[
                                Divider(),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: ancho * 0.04,
                                    // right: ancho * 0.04,
                                    // bottom: 8,
                                    // top: 6,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Programa",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: tamanoEtiqueta,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '${dato?["programa"] ?? "Sin programa"}',
                                            style: TextStyle(
                                              fontSize: tamanoValor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: ancho * 0.04,
                                    // right: ancho * 0.04,
                                    // bottom: 8,
                                    // top: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Ficha de caracterización",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: tamanoEtiqueta,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          // const SizedBox(width: 8),
                                          Text(
                                            '${dato?["ficha"]}',
                                            style: TextStyle(
                                              fontSize: tamanoValor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: alto * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ancho * 0.06),
                            child: Text(
                              "Preferencias",
                              style: TextStyle(
                                fontSize: ancho * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: alto * 0.02),
                      CardWidget(
                        ancho: ancho * 0.9,
                        alto: alto * 0.1,
                        decoracion: BoxDecoration(
                          // color: ThemeApk.fondoModoOscuro,
                          color: temas.cardDesc,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: temas.bordercardDesc),
                        ),
                        contenido: Padding(
                          padding: EdgeInsets.only(left: ancho * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: ancho * 0.04),
                                child: Container(
                                  width: alto * 0.05,
                                  height: alto * 0.05,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: !estado
                                        ? const Color.fromARGB(
                                            135,
                                            104,
                                            58,
                                            183,
                                          )
                                        : Colors.white,
                                  ),
                                  child: Icon(
                                    !estado
                                        ? Icons.nightlight_outlined
                                        : Icons.sunny,
                                    color: !estado
                                        ? Colors.white
                                        : Colors.amber,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: alto * 0.025),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        !estado ? "Modo oscuro" : "Modo claro",
                                        style: TextStyle(
                                          fontSize: ancho * 0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Alterna entre tema claro y oscuro",
                                        style: TextStyle(
                                          fontSize: ancho * 0.028,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: ancho * 0.02),
                                child: Switch(
                                  value: Provider.of<ThemeApk>(context).claro,
                                  onChanged: (value) {
                                    setState(() {
                                      estado = value;
                                      Provider.of<ThemeApk>(
                                        context,
                                        listen: false,
                                      ).modo(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: alto * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ancho * 0.06),
                            child: Text(
                              "Ayuda y legal",
                              style: TextStyle(
                                fontSize: ancho * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: alto * 0.02),

                      Container(
                        width: ancho * 0.9,
                        decoration: BoxDecoration(
                          // color: ThemeApk.fondoModoOscuro,
                          color: temas.cardDesc,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            // color: ThemeApk.bordeModoOscuro
                            color: temas.bordercardDesc,
                          ),
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

                      SizedBox(height: alto * 0.04),

                      Padding(
                        padding: EdgeInsets.only(bottom: alto * 0.04),
                        child: SizedBox(
                          width: ancho * 0.9,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final serviceApi = Provider.of<ServiceApi>(
                                context,
                                listen: false,
                              );
                              if (!context.mounted) return;
                              final cierreSesion = serviceApi.logout();
                              Navigator.pushReplacementNamed(context, "/login");
                              await cierreSesion;
                            },
                            icon: const Icon(Icons.logout, size: 20),
                            label: const Text("Cerrar sesión"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                              backgroundColor: const Color(0xff3979BD),
                              elevation: 0,
                              side: const BorderSide(color: Color.fromARGB(255, 1, 33, 68)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   // height: alto*0.02,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomnavigationbarWidget(
        alto: alto,
        ancho: ancho,
        nombrePantalla: "perfil",
      ),
    );
  }
}
