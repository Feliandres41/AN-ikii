import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget{
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool ayuda = true;
  bool cargando = false;

  CameraController? _controller;
  List<CameraDescription> cameras = [];
  @override
  void initState(){
    _initializeCamera();
  }
  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _controller = CameraController(cameras[0], ResolutionPreset.high);

    await _controller!.initialize();

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),
      body: Stack(
        // fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: _controller == null || !_controller!.value.isInitialized
                ? Text("Hola")
                : CameraPreview(_controller!),
          ),
          Positioned(
            top: alto*0.03,
            right: alto*0.03,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  ayuda = !ayuda;
                });
              },
              child: Container(
                width: ancho*0.1,
                height: ancho*0.1,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(104, 0, 0, 0),
                  borderRadius: BorderRadius.circular(1000)
                ),
                child:
                ayuda
                ?Icon(Icons.close)
                : Icon(Icons.help),
              ),
            )
          ),
          ayuda
          ?Positioned(
            bottom: -1,
            // left: -4,
            child: Container(
              width: ancho,
              height: alto*0.15,
              // color: Colors.red,
              decoration: BoxDecoration(
                color: Provider.of<ThemeApk>(context).cardDesc
              ),
              child: Center(
                child: Container(
                  width: ancho*0.85,
                  height: alto*0.1,
                  decoration: BoxDecoration(
                    color: Provider.of<ThemeApk>(context).bordercardDesc,
                    border: Border.all(
                      color: Colors.white,
                      width: 0.2
                    ),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: ancho*0.04,right: ancho*0.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            width: ancho*0.15,
                            height: ancho*0.15,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(68, 178, 160, 212),
                              borderRadius: BorderRadius.circular(20)
                              // Provider.of<ThemeApk>(context).cardDesc,
                            ),
                            child: Icon(
                              Icons.filter_center_focus_sharp
                            ),
                          )
                        ),
                        SizedBox(width: ancho*0.04,),
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(top: ancho*0.04),
                            child: Column(
                              spacing: ancho*0.01,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Molde de Escaneo Inteligente",style: TextStyle(
                                  fontSize: ancho*0.035,
                                  fontWeight: FontWeight.bold
                                ),),
                                Text("Alinea el objeto al lente de la camara,  ANüikii te dara su nombre en ingles y más",style: TextStyle(
                                  fontSize: ancho*0.027,
                                ),),
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          )
          :Positioned(
            bottom: alto*0.05,
            left: ancho*0.45,
            child: 
            SizedBox.shrink()
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       width: ancho*0.15,
            //       height: ancho*0.15,
            //       decoration: BoxDecoration(
            //         border: Border.all(
            //           color: Colors.white,
            //           width: ancho*0.01
            //         ),
            //         color: Colors.grey,
            //         borderRadius: BorderRadius.circular(1000)
            //       ),
            //       child: Container(
            //         width: ancho*0.0001,
            //         height: ancho*0.0001,
            //         // color: Colors.blue,
            //         decoration: BoxDecoration(
            //         ),
            //         child: Icon(Icons.camera),
            //       ),
            //     ),
            //   ],
            // )
          ),
        ],
      ),




      
      
      bottomNavigationBar: BottomnavigationbarWidget(
        ancho: ancho, 
        alto: alto, 
        nombrePantalla: "camara"),
    );
  }
}