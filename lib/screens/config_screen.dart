import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:flutter_application_1/widget/card_widget.dart';
import 'package:flutter_application_1/widget/politica_privacidad_widget.dart';
import 'package:flutter_application_1/widget/terminos_condiciones_widget.dart';
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

  void _abrirLegal(String tipo) {
    if (tipo == 'privacidad') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PoliticaPrivacidadWidget()),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TerminosCondicionesWidget()),
    );
  }

  Widget _filaLegal({
    required IconData icono,
    required String titulo,
    required VoidCallback onTap,
    required double tamanoTexto,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xff3979BD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icono, color: Colors.white, size: 23),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                titulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: tamanoTexto,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _filaDatoInstitucional({
    required String etiqueta,
    required String valor,
    required double tamanoEtiqueta,
    required double tamanoValor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            etiqueta,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: tamanoEtiqueta, color: Colors.grey),
          ),
          Text(
            valor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: tamanoValor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var temas = Provider.of<ThemeApk>(context);
    final ancho = MediaQuery.sizeOf(context).width;
    final anchoContenido = anchoDiseno(context);
    final anchoTarjeta = anchoContenido * 0.9;
    final anchoTexto = anchoContenido;
    final alto = MediaQuery.of(context).size.height;
    final esHorizontal = ancho > alto;
    final espacioSeccion = esHorizontal
        ? 10.0
        : (alto * 0.026).clamp(20.0, 24.0).toDouble();
    final espacioBotonSalir = esHorizontal
        ? 14.0
        : (alto * 0.045).clamp(26.0, 34.0).toDouble();
    final margenInferiorContenido = esHorizontal
        ? 12.0
        : (alto * 0.04).clamp(24.0, 32.0).toDouble();
    final tamanoEtiqueta = (anchoTexto * 0.035).clamp(14.0, 18.0).toDouble();
    final tamanoValor = (anchoTexto * 0.028).clamp(12.0, 16.0).toDouble();
    Map? dato = Provider.of<ServiceApi>(context).datos;
    final esAprendiz = '${dato?['rol']}'.trim().toLowerCase() == 'aprendiz';
    final altoTarjetaSecundaria = esHorizontal
        ? 116.0
        : (alto * 0.15).clamp(122.0, 138.0).toDouble();
    final tamanoTextoLegal = (anchoTexto * 0.04).clamp(14.0, 17.0).toDouble();
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final parteInferiorVerde = alto * 0.22 - 50;
          final parteInferiorRol = alto * 0.1 + alto * 0.05;
          final inicioContenido =
              (parteInferiorVerde > parteInferiorRol
                  ? parteInferiorVerde
                  : parteInferiorRol) +
              24;
          return Stack(
            children: [
              Positioned(
                top: -50,
                left: 0,
                right: 0,
                height: alto * 0.22,
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeApk.verdeModoOscuro,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Positioned(
                top: (alto * 0.04).clamp(24.0, 32.0).toDouble(),
                left: 0,
                right: 0,
                child: Text(
                  "Mi perfil",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: anchoTexto * 0.075,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: alto * 0.1,
                left: 0,
                right: 0,
                child: Center(
                  child: CardWidget(
                    ancho: anchoTarjeta,
                    alto: alto * 0.05,
                    decoracion: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ThemeApk.fondoModoOscuro,
                      border: Border.all(
                        color: ThemeApk.bordeModoOscuro,
                        width: 0.5,
                      ),
                    ),
                    contenido: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${dato?['rol']} - SENA",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: (anchoTexto * 0.05).clamp(14.0, 20.0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: inicioContenido,
                child: LayoutBuilder(
                  builder: (context, contentConstraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: contentConstraints.maxHeight,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: ancho,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  // top: (alto * 0.001)
                                  //     .clamp(12.0, 18.0)
                                  //     .toDouble(),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Transform.translate(
                                      offset: Offset(0, esHorizontal ? 0 : -15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: anchoTarjeta,
                                            child: Text(
                                              "Datos institucionales SENA",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: anchoTexto * 0.04,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: esHorizontal
                                                ? espacioSeccion
                                                : espacioSeccion + 22,
                                          ),
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            width: anchoTarjeta,
                                            decoration: BoxDecoration(
                                              color: temas.cardDesc,
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              border: Border.all(
                                                color: temas.bordercardDesc,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                _filaDatoInstitucional(
                                                  etiqueta: "Nombre completo",
                                                  valor:
                                                      '${dato?["nombre"] ?? "Sin nombre"}',
                                                  tamanoEtiqueta:
                                                      tamanoEtiqueta,
                                                  tamanoValor: tamanoValor,
                                                ),
                                                if (esAprendiz) ...[
                                                  Divider(
                                                    height: 1,
                                                    color: temas.bordercardDesc,
                                                  ),
                                                  _filaDatoInstitucional(
                                                    etiqueta: "Programa",
                                                    valor:
                                                        '${dato?["programa"] ?? "Sin programa"}',
                                                    tamanoEtiqueta:
                                                        tamanoEtiqueta,
                                                    tamanoValor: tamanoValor,
                                                  ),
                                                  Divider(
                                                    height: 1,
                                                    color: temas.bordercardDesc,
                                                  ),
                                                  _filaDatoInstitucional(
                                                    etiqueta:
                                                        "Ficha de caracterización",
                                                    valor:
                                                        '${dato?["ficha"] ?? "Sin ficha"}',
                                                    tamanoEtiqueta:
                                                        tamanoEtiqueta,
                                                    tamanoValor: tamanoValor,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: espacioSeccion),
                                    SizedBox(
                                      width: anchoTarjeta,
                                      child: Text(
                                        "Preferencias",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: anchoTexto * 0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: espacioSeccion),
                                    CardWidget(
                                      ancho: anchoTarjeta,
                                      alto: altoTarjetaSecundaria,
                                      decoracion: BoxDecoration(
                                        // color: ThemeApk.fondoModoOscuro,
                                        color: temas.cardDesc,
                                        borderRadius: BorderRadius.circular(22),
                                        border: Border.all(
                                          color: temas.bordercardDesc,
                                        ),
                                      ),
                                      contenido: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: anchoContenido * 0.04,
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              clipBehavior: Clip.antiAlias,
                                              width: (anchoTexto * 0.08)
                                                  .clamp(38.0, 48.0)
                                                  .toDouble(),
                                              height: (anchoTexto * 0.08)
                                                  .clamp(38.0, 48.0)
                                                  .toDouble(),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(22),
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
                                            SizedBox(
                                              width: anchoContenido * 0.04,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Modo claro",
                                                    style: TextStyle(
                                                      fontSize:
                                                          anchoTexto * 0.04,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Alterna entre tema claro y oscuro",
                                                    style: TextStyle(
                                                      fontSize:
                                                          anchoTexto * 0.028,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Switch(
                                              value: Provider.of<ThemeApk>(
                                                context,
                                              ).claro,
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: espacioSeccion),
                                    SizedBox(
                                      width: anchoTarjeta,
                                      child: Text(
                                        "Ayuda y legal",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: anchoTexto * 0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: espacioSeccion),

                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      width: anchoTarjeta,
                                      height: altoTarjetaSecundaria,
                                      decoration: BoxDecoration(
                                        // color: ThemeApk.fondoModoOscuro,
                                        color: temas.cardDesc,
                                        borderRadius: BorderRadius.circular(22),
                                        border: Border.all(
                                          // color: ThemeApk.bordeModoOscuro
                                          color: temas.bordercardDesc,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(22),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: _filaLegal(
                                                icono: Icons.shield_outlined,
                                                titulo:
                                                    "Política de privacidad",
                                                onTap: () =>
                                                    _abrirLegal('privacidad'),
                                                tamanoTexto: tamanoTextoLegal,
                                              ),
                                            ),
                                            Divider(
                                              height: 1,
                                              color: ThemeApk.bordeModoOscuro,
                                            ),
                                            Expanded(
                                              child: _filaLegal(
                                                icono:
                                                    Icons.description_outlined,
                                                titulo:
                                                    "Términos y condiciones",
                                                onTap: () =>
                                                    _abrirLegal('terminos'),
                                                tamanoTexto: tamanoTextoLegal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: espacioBotonSalir),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: margenInferiorContenido,
                                      ),
                                      child: SizedBox(
                                        width: anchoTarjeta,
                                        height: 58,
                                        child: ElevatedButton.icon(
                                          onPressed: () async {
                                            final serviceApi =
                                                Provider.of<ServiceApi>(
                                                  context,
                                                  listen: false,
                                                );
                                            if (!context.mounted) return;
                                            final cierreSesion = serviceApi
                                                .logout();
                                            Navigator.pushReplacementNamed(
                                              context,
                                              "/login",
                                            );
                                            await cierreSesion;
                                          },
                                          icon: const Icon(
                                            Icons.logout,
                                            size: 21,
                                          ),
                                          label: const Text("Cerrar sesión"),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                const Color.fromARGB(
                                                  255,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                            backgroundColor: const Color(
                                              0xff3979BD,
                                            ),
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            side: const BorderSide(
                                              color: Color.fromARGB(
                                                255,
                                                1,
                                                33,
                                                68,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            textStyle: const TextStyle(
                                              fontSize: 15,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomnavigationbarWidget(
        alto: alto,
        ancho: ancho,
        nombrePantalla: "perfil",
      ),
    );
  }
}
