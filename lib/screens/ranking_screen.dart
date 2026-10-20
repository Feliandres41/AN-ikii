import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/screens/ranking_ficha_screen.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

class RankingScreen  extends StatefulWidget{
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}
class _RankingScreenState extends State<RankingScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _recargarRanking();
  }

  Future<void> _recargarRanking() async {
    if (!mounted) return;

    final service = Provider.of<ServiceApi>(context, listen: false);
    await service.rankingProramas();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _recargarRanking();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AppBarWidget.info = false;
    super.dispose();
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
            final data = value.getProgramas;
            if (data.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final ranking = [...data]
              ..sort((a, b) =>
                  (b["total_busquedas"] as num).compareTo(a["total_busquedas"] as num));

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    ancho * 0.05,
                    alto * 0.025,
                    ancho * 0.05,
                    alto * 0.01,
                  ),
                  child: Text(
                    "Ranking de programas",
                    style: TextStyle(
                      fontSize: anchoTexto * 0.055,
                      fontWeight: FontWeight.bold,
                      color: temas.letrasModoOscuro,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(
                      ancho * 0.05,
                      alto * 0.01,
                      ancho * 0.05,
                      alto * 0.04,
                    ),
                    itemBuilder: (context, index) {
                      final datos = ranking[index];
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
                                "${datos["name"]}",
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
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                            SizedBox(width: ancho * 0.02),
                            IconButton(
                              tooltip: "Ver fichas",
                              onPressed: () async {
                                final respuesta = await Provider.of<ServiceApi>(
                                  context,
                                  listen: false,
                                ).rankingFichas(datos["id"]);
                                if (respuesta == 200 && context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RankingFichaScreen(),
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
                    itemCount: ranking.length,
                  ),
                ),
              ],
            );
          }
        ),




      
      
      bottomNavigationBar: BottomnavigationbarWidget(
        ancho: ancho, 
        alto: alto, 
        nombrePantalla: "ranking"),
    );
  }
}