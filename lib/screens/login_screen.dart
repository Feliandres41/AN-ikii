import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/service_api.dart';
import 'package:flutter_application_1/themes/theme_apk.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool login = false;
  bool fondo = false;
  bool ocultar = true;
  bool errorDocument = false;
  bool errorPassword = false;
  final _document = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> formKeyDocument = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _verificarSesion();
  }

  Future<void> _verificarSesion() async {
    final sesionActiva = await Provider.of<ServiceApi>(
      context,
      listen: false,
    ).restaurarSesion();
    if (!mounted) return;

    if (sesionActiva) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  void dispose(){
    _document.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final medidas = MediaQuery.of(context).size;
    final ancho = medidas.width;
    final alto = medidas.height;
    final temas = Provider.of<ThemeApk>(context);
    return Scaffold(
       backgroundColor: temas.claro ? temas.fondoClaro : Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: alto * 0.3,
            left: ancho * 0.05,
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: fondo ? 1 : 0,
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                width: fondo ? ancho : 0,
                height: fondo ? alto * 0.5 : 0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(34, 101, 72, 189),
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              height: errorDocument || errorPassword
                ?alto * 0.84
                :alto * 0.8 ,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Card(
                  shadowColor: Colors.transparent,
                  color: temas.fondoCartaModo,
                  child: Container(
                    width: ancho * 0.9,
                    height: errorDocument || errorPassword
                    ?alto * 0.83
                    :alto * 0.79,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff4B3B68), width: 0.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 31,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  // color: const Color.fromARGB(153, 77, 172, 14),
                                  borderRadius: BorderRadius.circular(1000),
                                  image: DecorationImage(
                                    image: AssetImage("assets/logo.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // child: Text("Logo"),
                              ),
                            ],
                          ),
                          // SizedBox(height: alto * 0.02),
                          Text(
                            "ANüikii",
                            style: TextStyle(
                              fontSize: ancho * 0.07,
                              color: Color.fromARGB(255, 164, 122, 243),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: alto * 0.04),
                          SizedBox(
                            width: ancho * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Número de documento"),
                                SizedBox(height: alto * 0.01),
                                Form(
                                  key: formKeyDocument,
                                  child: TextFormField(
                                    validator: (value) => 
                                    value!.isEmpty
                                    ?"No se valen datos vacios"
                                    : !RegExp(r'^\d+$').hasMatch(value)
                                    ? "Solo se permiten números"
                                    : value.length<5
                                    ? "Minimo 5 caracteres"
                                    : null,
                                    onChanged: (value) =>
                                      value.isNotEmpty && value.length>5
                                      ? setState(() {
                                        formKeyDocument.currentState!.validate();
                                        if(formKeyDocument.currentState!.validate()){
                                          errorDocument=false;
                                        }
                                      })
                                      : null,
                                    
                                    controller: _document,
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    style: TextStyle(color: temas.letrasModoOscuro),
                                    cursorColor: temas.letrasModoOscuro,
                                    decoration: InputDecoration(
                                      
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 164, 122, 243),
                                          width: 2
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 164, 122, 243),
                                          width: 2
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.badge_outlined),
                                      prefixIconColor: !errorDocument
                                      ?Color.fromARGB(
                                        255,
                                        164,
                                        122,
                                        243,
                                      )
                                      :const Color.fromARGB(255, 253, 114, 114),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 253, 114, 114)
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                        color: Color.fromARGB(255, 253, 114, 114)
                                      )
                                      // err
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //contraseña
                          SizedBox(height: alto * 0.02),
                          SizedBox(
                            width: ancho * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Contraseña"),
                                SizedBox(height: alto * 0.01),
                                Form(
                                  key: formKeyPassword,
                                  child: TextFormField(
                                    validator: (value) => 
                                    value!.isEmpty
                                    ?"No se valen datos vacios"
                                    : value.length<6
                                    ? "Minimo 6 caracteres"
                                    : null,
                                    onChanged: (value) =>
                                    value.isNotEmpty && value.length>5
                                    ? setState(() {
                                      formKeyDocument.currentState!.validate();
                                      if(formKeyPassword.currentState!.validate()){
                                        errorPassword=false;
                                      }
                                    })
                                    : null,
                                    obscureText: ocultar,
                                    controller: _password,
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    style: TextStyle(color: temas.letrasModoOscuro),
                                    cursorColor: temas.letrasModoOscuro,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color(0xFFA47AF3),
                                          width: 2
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 164, 122, 243),
                                          width: 2
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.key),
                                      prefixIconColor: !errorPassword
                                      ?Color.fromARGB(
                                        255,
                                        164,
                                        122,
                                        243,
                                      )
                                      :const Color.fromARGB(255, 253, 114, 114),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 253, 114, 114)
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                        color: Color.fromARGB(255, 253, 114, 114)
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {});
                                          ocultar = !ocultar;
                                        },
                                        child: Icon(
                                          ocultar
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                      suffixIconColor: ocultar
                                          ? Color.fromARGB(196, 164, 122, 243)
                                          : Colors.white,
                                      
                                    ),
                                  ),
                                ),
                                SizedBox(height: alto * 0.03),
                                Center(
                                  child: Text(
                                    "Ingresar con tus credenciales asignadas del sena",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ancho * 0.03,
                                    ),
                                  ),
                                ),
                                SizedBox(height: alto * 0.03),
                                ElevatedButton(
                                  onPressed: () async{
                                    setState(() {
                                      errorDocument = false;
                                      errorPassword = false;
                                    });
                                    if(formKeyDocument.currentState!.validate() && formKeyPassword.currentState!.validate()){
                                      setState(() {
                                        login = true;
                                      });
                                      int code = await Provider.of<ServiceApi>(context,listen: false).login(_document.text, _password.text);
                                      if(code==200){
                                        Navigator.pushReplacementNamed(context, "/home");
                                      }else if(code==401){
                                        setState(() {
                                          login = false;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: const Color.fromARGB(255, 100, 24, 18),
                                            content: Container(
                                              child: Center(
                                                child: Text(
                                                  "Credenciales incorrectas",style: TextStyle(
                                                    color: Colors.white
                                                  ),
                                                ),
                                              ), 
                                            )
                                          )
                                        );
                                      }else if(code==404){
                                        setState(() {
                                          login = false;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: const Color.fromARGB(255, 100, 24, 18),
                                            content: Container(
                                              child: Center(
                                                child: Text(
                                                  "No hay internet",style: TextStyle(
                                                    color: Colors.white
                                                  ),
                                                ),
                                              ), 
                                            )
                                          )
                                        );
                                      }
                                    }else if(!formKeyDocument.currentState!.validate()){
                                      print("ok");
                                      setState(() {
                                        errorDocument = true;
                                        errorPassword = false;
                                      });
                                      return;
                                    }
                                    else if(!formKeyPassword.currentState!.validate()){
                                      print("ok");
                                      setState(() {
                                        errorPassword = true;
                                        errorDocument = false;
                                      });
                                      return;
                                    }
                                    setState(() {
                                      errorDocument = false;
                                      errorPassword = false;
                                      // login = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffA9CA19),
                                    fixedSize: Size(ancho * 0.75, alto * 0.065),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: Duration(seconds: 1),
                                    key: ValueKey("botonLogin"),
                                    child: login
                                    ? CircularProgressIndicator(
                                      color: Colors.black,
                                      
                                    ) 
                                    :Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Iniciar Sesión",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Icon(
                                          Icons.arrow_right_rounded,
                                          size: ancho * 0.08,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: alto*0.03,
                                ),
                                SizedBox(
                                  width: ancho*0.75,
                                  child: Column(
                                    spacing: alto*0.015,
                                    children: [
                                      Divider(
                                        color: Color(0xff4B3B68),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        spacing: ancho*0.015,
                                        children: [
                                          Icon(
                                            Icons.verified_user_outlined,
                                            color: Color(0xffA9CA19),
                                            size: ancho*0.05,
                                          ),
                                          Text("Acceso seguro Institucional Sena",style: TextStyle(
                                            fontSize: ancho*0.03
                                          ),)
                                        ],
                                      )
                                    ],
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
            ),
          ),
        ],
      ),
    );
  }
}
