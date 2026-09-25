import 'package:flutter/material.dart';

class TerminosCondicionesWidget extends StatelessWidget {
  const TerminosCondicionesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;

    final backgroundColor = isDark ? const Color(0xFF1F1A38) : const Color(0xFFF0F0EA);
    final cardColor = isDark ? const Color(0xFF2A2346) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1D1D1D);
    final mutedText = isDark ? Colors.white70 : const Color(0xFF5C5C5C);
    final borderColor = isDark ? const Color(0xFF4B3B68) : const Color(0xFFEAEAEA);
    final accent = const Color(0xFFA9CA19);
    final accentSoft = const Color(0xFFA47AF3);

    final secciones = [
      _SeccionLegal(
        titulo: '1. Aceptación de los términos y condiciones',
        texto:
            'Al acceder y utilizar la aplicación ANüikii, el usuario acepta expresamente cumplir con estos Términos y Condiciones. Si no está de acuerdo con ellos, deberá abstenerse de utilizar la plataforma y de continuar con el proceso de acceso institucional.',
      ),
      _SeccionLegal(
        titulo: '2. Objeto de la aplicación',
        texto:
            'La aplicación ANüikii tiene como finalidad apoyar procesos de formación, aprendizaje, consulta de términos técnicos, acompañamiento académico y gestión institucional del SENA Regional La Guajira, en el marco de sus funciones misionales y de formación profesional.',
      ),
      _SeccionLegal(
        titulo: '3. Uso autorizado de la plataforma',
        texto:
            'El usuario debe ser una persona vinculada al SENA y utilizar la aplicación únicamente para fines académicos, formativos e institucionales autorizados por la entidad. Queda prohibido compartir credenciales, manipular la seguridad del sistema, acceder a información ajena, interferir con su funcionamiento o utilizarla para actividades ilegales, fraudulentas o no autorizadas.',
      ),
      _SeccionLegal(
        titulo: '4. Seguridad, responsabilidades y deberes del usuario',
        texto:
            'El usuario será responsable por la custodia de sus credenciales y por el uso correcto de la aplicación. Deberá informar de inmediato cualquier uso indebido, sospecha de acceso no autorizado o vulneración de la seguridad institucional. El SENA podrá limitar, suspender o cancelar el acceso cuando exista riesgo para la seguridad, el cumplimiento normativo o el adecuado uso de la plataforma.',
      ),
      _SeccionLegal(
        titulo: '5. Propiedad intelectual e industrial',
        texto:
            'Los contenidos, logotipos, diseños, interfaces, textos, iconos, gráficos y elementos visuales de la aplicación son propiedad del SENA o de terceros autorizados para su uso. Queda prohibida su reproducción, distribución, modificación o explotación sin autorización previa y escrita de la entidad.',
      ),
      _SeccionLegal(
        titulo: '6. Uso de funciones asistidas por inteligencia artificial',
        texto:
            'La aplicación puede incluir funciones de apoyo o análisis mediante inteligencia artificial. Estas funciones tienen carácter orientador y académico y no reemplazan la validación humana, la revisión institucional ni la decisión oficial de la entidad. El usuario debe utilizar estas herramientas con criterio, responsabilidad y bajo la normativa institucional vigente.',
      ),
      _SeccionLegal(
        titulo: '7. Limitación de responsabilidad',
        texto:
            'El SENA realizará los esfuerzos razonables para garantizar la operación, seguridad y continuidad de la plataforma. No obstante, no garantiza la disponibilidad ininterrumpida del servicio ni la ausencia total de errores, fallas técnicas o interrupciones. En la medida permitida por la ley, el SENA no será responsable por daños indirectos, incidentales o consecuentes derivados del uso indebido o de contingencias ajenas a la entidad.',
      ),
      _SeccionLegal(
        titulo: '8. Modificaciones, vigencia y actualización',
        texto:
            'El SENA podrá actualizar la aplicación, sus contenidos, funcionalidades o estos términos y condiciones, con el fin de mejorar la prestación del servicio, atender ajustes normativos o fortalecer la seguridad y la gestión institucional. El uso continuo de la plataforma implica la aceptación de los términos vigentes en el momento del acceso.',
      ),
      _SeccionLegal(
        titulo: '9. Ley aplicable y jurisdicción',
        texto:
            'Estos términos y condiciones se regirán por la legislación vigente en Colombia. Cualquier conflicto relacionado con su interpretación, aplicación o cumplimiento será sometido a la jurisdicción competente de la República de Colombia.',
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1F1A38) : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
          color: textColor,
        ),
        title: Text(
          'Términos y condiciones',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: (ancho * 0.045).clamp(18.0, 24.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: ancho > 850 ? 820 : ancho * 0.94,
            child: Card(
              color: cardColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
                side: BorderSide(color: borderColor, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ancho * 0.05,
                  vertical: alto * 0.03,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(isDark ? 0.18 : 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: accent.withOpacity(isDark ? 0.5 : 0.35),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.description_outlined,
                              color: accent,
                              size: (ancho * 0.055).clamp(18.0, 28.0),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Condiciones de uso institucional',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: (ancho * 0.032).clamp(13.0, 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...secciones.map(
                        (seccion) => Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                seccion.titulo,
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: (ancho * 0.038).clamp(15.0, 18.0),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                seccion.texto,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: mutedText,
                                  fontSize: (ancho * 0.033).clamp(13.0, 15.5),
                                  height: 1.7,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: accentSoft.withOpacity(isDark ? 0.18 : 0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: accentSoft.withOpacity(isDark ? 0.55 : 0.35),
                          ),
                        ),
                        child: Text(
                          'SENA Regional La Guajira\nEste documento es una base institucional para uso interno o preliminar y debe ser revisado por la dependencia legal o administrativa correspondiente antes de su publicación oficial.',
                          style: TextStyle(
                            color: textColor,
                            fontSize: (ancho * 0.03).clamp(11.5, 14.0),
                            height: 1.5,
                          ),
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
    );
  }
}

class _SeccionLegal {
  final String titulo;
  final String texto;

  const _SeccionLegal({
    required this.titulo,
    required this.texto,
  });
}
