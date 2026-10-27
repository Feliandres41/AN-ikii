# ANüikii

ANüikii es una aplicación móvil desarrollada con Flutter para apoyar procesos de formación, aprendizaje y gestión institucional dentro del marco del SENA Regional La Guajira.

## Descripción
La aplicación está orientada a fortalecer la experiencia de aprendizaje de los usuarios vinculados al SENA, ofreciendo acceso a contenido académico, herramientas de consulta, historial de búsquedas, apoyo visual y recursos para la formación técnica.

## Objetivo
Facilitar la consulta de términos técnicos y el aprendizaje mediante una experiencia digital más dinámica, institucional y útil para la comunidad del SENA.

## Funcionalidades principales
- Inicio de sesión institucional
- Recuperación de sesión activa
- Perfil del usuario
- Tema claro y oscuro
- Historial de búsquedas
- Glosario técnico
- Apoyo visual con cámara
- Ranking institucional por programas y fichas
- Política de privacidad y términos y condiciones
- Navegación general de la aplicación

## Stack tecnológico
- Flutter
- Dart
- Provider para gestión de estado
- HTTP para consumo de servicios
- Material Design 3
- Integración con servicios del backend
- Soporte para cámara y funciones de IA

## Estructura del proyecto
```bash
.
├── android/
├── ios/
├── lib/
│   ├── config/
│   ├── models/
│   ├── router/
│   ├── screens/
│   ├── scripts/
│   ├── services/
│   ├── themes/
│   └── widget/
├── linux/
├── macos/
├── windows/
├── test/
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
├── README.md
└── ...
```

## Requisitos
Antes de ejecutar el proyecto, asegúrate de contar con lo siguiente:

- Flutter SDK instalado y configurado correctamente
- Dart SDK incluido con Flutter
- Android Studio o VS Code con soporte para Flutter
- Emulador Android o dispositivo físico para pruebas
- Acceso a la API o backend institucional asociado al proyecto
- Permisos de plataforma según el entorno de ejecución

## Instalación
1. Clona el repositorio:
```bash
git clone <url-del-repositorio>
```

2. Ingresa a la carpeta del proyecto:
```bash
cd AN-ikii
```

3. Instala las dependencias:
```bash
flutter pub get
```

4. Ejecuta la aplicación:
```bash
flutter run
```

## Preparar iOS con Xcode

En un Mac con Flutter, Xcode y CocoaPods instalados, desde la raíz del proyecto:

```bash
flutter pub get
cd ios
pod install
```

Abre `ios/Runner.xcworkspace` en Xcode (no `Runner.xcodeproj`) para que CocoaPods
pueda enlazar los plugins iOS, incluido `flutter_tts`. La dependencia de voz ya
está declarada en `pubspec.yaml`; no es necesario agregarla manualmente en Xcode.

## Configuración
Asegúrate de verificar y configurar correctamente:

- URL base del backend o API
- claves o servicios externos
- permisos para cámara, almacenamiento y acceso a internet
- entorno de desarrollo y producción
- credenciales institucionales y seguridad de datos

## Estado del proyecto
Versión actual: v1.0.0

Este proyecto se encuentra en una etapa inicial de desarrollo con una base funcional estable para uso institucional y pruebas preliminares.

## Importante
La aplicación está orientada al entorno institucional del SENA y requiere validación final con la dependencia responsable antes de una implementación o distribución amplia.

## Licencia
Este proyecto está destinado para uso institucional y académico dentro del marco del SENA. Se recomienda revisar la política interna de uso, seguridad y manejo de datos antes de su difusión o despliegue institucional.

## Contacto
- Proyecto: ANüikii
- Versión: v1.0.0