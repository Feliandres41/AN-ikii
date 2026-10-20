import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

class RankingFichaAprendices extends StatefulWidget{
  const RankingFichaAprendices({super.key});

  @override
  State<RankingFichaAprendices> createState() => _RankingFichaAprendicesState();
}

class _RankingFichaAprendicesState extends State<RankingFichaAprendices> {
  @override
  void dispose(){
    super.dispose();
    AppBarWidget.info =false;
  }
  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.sizeOf(context).width;
    final anchoTexto = anchoDiseno(context);
    final alto = MediaQuery.of(context).size.height;
    final temas = Provider.of<ThemeApk>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),
      body: Consumer<ServiceApi>(
        builder: (
          context, value, child){
            final data = value.getFichaAprendiz;
            final ficha = value.datosFicha;
            return data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                ancho * 0.05,
                alto * 0.025,
                ancho * 0.05,
                alto * 0.01,
              ),
              child: Column(
                children: [
                  Text(
                    "Ranking de aprendices",
                    style: TextStyle(
                      fontSize: anchoTexto * 0.055,
                      fontWeight: FontWeight.bold,
                      color: temas.letrasModoOscuro,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Ficha ${ficha["numero"]}",
                    style: TextStyle(
                      fontSize: anchoTexto * 0.038,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: alto * 0.025),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final datos = data[index];
                      final posicion = index + 1;
                      final color = posicion == 1
                          ? const Color(0xffd0ad24)
                          : posicion == 2
                          ? const Color(0xff7f8b99)
                          : posicion == 3
                          ? const Color(0xffa66b4d)
                          : temas.bordercardDesc;

                      return Container(
                        margin: EdgeInsets.only(bottom: alto * 0.018),
                        padding: EdgeInsets.symmetric(
                          horizontal: ancho * 0.04,
                          vertical: alto * 0.018,
                        ),
                        decoration: BoxDecoration(
                          color: temas.fondoCartaModo,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: color, width: 1.2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: ancho * 0.105,
                              height: ancho * 0.105,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.18),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "$posicion",
                                style: TextStyle(
                                  color: color,
                                  fontSize: anchoTexto * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: ancho * 0.04),
                            Expanded(
                              child: Text(
                                "${datos["nombre"]}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: temas.letrasModoOscuro,
                                  fontSize: anchoTexto * 0.038,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: ancho * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${datos["total_busquedas"]}",
                                  style: TextStyle(
                                    color: color,
                                    fontSize: anchoTexto * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "búsquedas",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: anchoTexto * 0.027,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: data.length,
                  ),
                  // SizedBox(
                  //     height: alto*0.05,
                  //   )
                ],
              ),
            );
          }
        ),
        bottomNavigationBar: BottomnavigationbarWidget(
        alto: alto,
        ancho: ancho,
        nombrePantalla: "rankings",
      ),
    );
  }
}