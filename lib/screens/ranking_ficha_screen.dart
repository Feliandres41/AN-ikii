import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ranking_ficha_aprendices.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

class RankingFichaScreen extends StatefulWidget{
  const RankingFichaScreen({super.key});

  @override
  State<RankingFichaScreen> createState() => _RankingFichaScreenState();
}

class _RankingFichaScreenState extends State<RankingFichaScreen> {
  @override
  void initState(){
    super.initState();
    AppBarWidget.info =true;
  }
  @override
  void dispose(){
    super.dispose();
    AppBarWidget.info =false;
  }

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
      body: Consumer<ServiceApi>(
        builder: (
          context, value, child){
            final data = value.getFichas;
            return data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: alto * 0.025),
                  child: Text(
                    "Ranking de fichas",
                    style: TextStyle(
                      color: temas.letrasModoOscuro,
                      fontSize: ancho * 0.055,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Fichas con más búsquedas",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ancho * 0.033,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                      ancho * 0.05,
                      alto * 0.025,
                      ancho * 0.05,
                      alto * 0.04,
                    ),
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
                            fontSize: ancho * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: ancho * 0.04),
                      Expanded(
                        child: Text(
                          "Ficha ${datos["number_cohort"]}",
                          style: TextStyle(
                            color: temas.letrasModoOscuro,
                            fontSize: ancho * 0.042,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${datos["total_busquedas"]}",
                            style: TextStyle(
                              color: color,
                              fontSize: ancho * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "búsquedas",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ancho * 0.027,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: ancho * 0.02),
                      IconButton(
                        tooltip: "Ver aprendices",
                        onPressed: () async {
                          final respuesta = await Provider.of<ServiceApi>(
                            context,
                            listen: false,
                          ).rankingFichaAprendiz(datos["id"]);
                          if (respuesta == 200 && context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RankingFichaAprendices(),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: color,
                          size: ancho * 0.05,
                        ),
                      ),
                    ],
                  ),
                );
                    },
                    itemCount: data.length,
                  ),
                ),
              ],
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