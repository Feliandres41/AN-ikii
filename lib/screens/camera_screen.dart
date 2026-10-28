import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/responsive.dart';
import 'package:flutter_application_1/config/voice_config.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:flutter_application_1/widget/app_bar_widget.dart';
import 'package:flutter_application_1/widget/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  bool ayuda = true;
  bool cargando = false;
  //camara
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  bool _isInitializingCamera = false;
  bool _cameraPaused = false;
  bool _disposeAfterInitialization = false;
  Future<void>? _cameraDisposal;

  Future<XFile?> tomarFoto() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return null;
    }

    return controller.takePicture();
  }

  Future<void> _mostrarResultado(Map? resultado) async {
    if (!mounted || resultado == null) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(dialogContext).height * 0.82,
          ),
          child: _ResultadoCamara(resultado: resultado),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _cameraPaused = true;
      if (_isInitializingCamera) {
        _disposeAfterInitialization = true;
      } else {
        _cameraDisposal = _disposeCameraController();
      }
    } else if (state == AppLifecycleState.resumed) {
      _cameraPaused = false;
      _disposeAfterInitialization = false;
      if (_controller == null) {
        _initializeCamera();
      }
    }
  }

  Future<void> _disposeCameraController() async {
    final controller = _controller;
    _controller = null;
    if (mounted) setState(() {});
    await controller?.dispose();
  }

  Future<void> _initializeCamera() async {
    if (_isInitializingCamera || _controller != null || _cameraPaused) return;
    _isInitializingCamera = true;
    CameraController? controller;

    try {
      await _cameraDisposal;
      _cameraDisposal = null;
      if (!mounted || _cameraPaused) return;

      cameras = await availableCameras();
      if (!mounted || _cameraPaused) return;

      if (cameras.isEmpty) {
        return;
      }

      controller = CameraController(
        cameras[0],
        ResolutionPreset.ultraHigh,
        enableAudio: false,
      );
      _controller = controller;

      await controller.initialize();

      if (!mounted) return;

      setState(() {});
    } on CameraException catch (error) {
      if (identical(_controller, controller)) {
        _controller = null;
        await controller?.dispose();
      }
      if (!mounted) return;
      final mensaje = switch (error.code) {
        'CameraAccessDenied' =>
          'Se denegó el permiso de cámara. Vuelve a intentarlo y selecciona Permitir.',
        'CameraAccessDeniedWithoutPrompt' =>
          'El acceso a la cámara está desactivado. Habilítalo en Ajustes del iPhone.',
        'CameraAccessRestricted' =>
          'El acceso a la cámara está restringido en este dispositivo.',
        _ =>
          'No se pudo acceder a la cámara: ${error.description ?? error.code}',
      };
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(mensaje)));
    } catch (e) {
      if (identical(_controller, controller)) {
        _controller = null;
        await controller?.dispose();
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo inicializar la cámara: $e')),
      );
    } finally {
      _isInitializingCamera = false;
      if (_disposeAfterInitialization && _cameraPaused) {
        _disposeAfterInitialization = false;
        await _disposeCameraController();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    final controller = _controller;
    _controller = null;
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.sizeOf(context).width;
    final anchoDisenoPantalla = anchoDiseno(context);
    final alto = MediaQuery.of(context).size.height;
    AppBarWidget.info = false;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppBarWidget.altura),
        child: AppBarWidget(),
      ),
      body: Stack(
        // fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: _controller == null || !_controller!.value.isInitialized
                ? Text("")
                : CameraPreview(_controller!),
          ),
          Positioned(
            top: alto * 0.03,
            right: alto * 0.03,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  ayuda = !ayuda;
                });
              },
              child: Container(
                width: anchoDisenoPantalla * 0.1,
                height: anchoDisenoPantalla * 0.1,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(104, 0, 0, 0),
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: ayuda ? Icon(Icons.close) : Icon(Icons.help),
              ),
            ),
          ),
          ayuda
              ? Positioned(
                  bottom: -1,
                  // left: -4,
                  child: Container(
                    width: ancho,
                    height: alto * 0.15,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      color: Provider.of<ThemeApk>(context).cardDesc,
                    ),
                    child: Center(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: ancho * 0.85,
                        height: alto * 0.13,
                        decoration: BoxDecoration(
                          color: Provider.of<ThemeApk>(context).bordercardDesc,
                          border: Border.all(color: Colors.white, width: 0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: ancho * 0.04,
                            right: ancho * 0.0,
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: anchoDisenoPantalla * 0.15,
                                  height: anchoDisenoPantalla * 0.15,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(68, 178, 160, 212),
                                    borderRadius: BorderRadius.circular(20),
                                    // Provider.of<ThemeApk>(context).cardDesc,
                                  ),
                                  child: Icon(Icons.filter_center_focus_sharp),
                                ),
                              ),
                              SizedBox(width: anchoDisenoPantalla * 0.04),
                              Flexible(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: ancho * 0.01,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Molde de Escaneo Inteligente",
                                      style: TextStyle(
                                        fontSize: anchoDisenoPantalla * 0.035,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Alinea el objeto al lente de la camara,  ANüikii te dara su nombre en ingles y más",
                                      style: TextStyle(
                                        fontSize: anchoDisenoPantalla * 0.027,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  bottom: alto * 0.05,
                  left: ancho * 0.45,
                  child: SizedBox.shrink(),
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
          SizedBox(width: ancho, height: alto),
        ],
      ),

      bottomNavigationBar: BottomnavigationbarWidget(
        ancho: ancho,
        alto: alto,
        nombrePantalla: "camara",
        tomarFoto: tomarFoto,
        onResultado: _mostrarResultado,
      ),
    );
  }
}

class _ResultadoCamara extends StatelessWidget {
  const _ResultadoCamara({required this.resultado});

  final Map resultado;

  @override
  Widget build(BuildContext context) {
    final temas = Provider.of<ThemeApk>(context);
    final anchoDiseno = MediaQuery.sizeOf(context).width.clamp(0.0, 600.0);
    final tamanoTextoTermino = (anchoDiseno * 0.045)
        .clamp(18.0, 24.0)
        .toDouble();
    final tamanoTextoPronunciacion = (anchoDiseno * 0.032)
        .clamp(13.0, 16.0)
        .toDouble();
    final secciones = [
      ("Pasado", resultado["oracion_pasado"], const Color(0xff916dcc)),
      ("Presente", resultado["oracion_presente"], const Color(0xff4b91d8)),
      ("Futuro", resultado["oracion_futuro"], const Color(0xffa9c516)),
    ];

    return Material(
      color: temas.cardDesc,
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Texto en inglés: ${resultado["objeto_eng"] ?? "Sin información"}",
                      style: TextStyle(
                        color: ThemeApk.verdeModoOscuro,
                        fontSize: tamanoTextoTermino + 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: "Escuchar término",
                    onPressed: () =>
                        VoiceConfig.hablar('${resultado["objeto_eng"] ?? ""}'),
                    icon: const Icon(Icons.volume_up_outlined),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pronunciación: ${resultado["pronunciacion"] ?? "Sin información"}",
                  style: TextStyle(
                    color: temas.letrasModoOscuro,
                    fontSize: tamanoTextoPronunciacion + 5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Texto en español: ${resultado["objeto_esp"] ?? "Sin información"}",
                  style: TextStyle(
                    color: temas.letrasModoOscuro,
                    fontSize: tamanoTextoPronunciacion + 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              for (final seccion in secciones)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: temas.fondoCartaModo,
                    border: Border.all(color: seccion.$3),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: seccion.$3,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              seccion.$1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              tooltip: "Escuchar oración",
                              visualDensity: VisualDensity.compact,
                              onPressed: () =>
                                  VoiceConfig.hablar('${seccion.$2 ?? ""}'),
                              icon: const Icon(
                                Icons.volume_up_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                        child: Text(
                          '${seccion.$2 ?? "Sin información"}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: temas.letrasModoOscuro,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  label: const Text("Cerrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
