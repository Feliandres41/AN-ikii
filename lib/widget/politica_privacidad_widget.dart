import 'package:flutter/material.dart';

class PoliticaPrivacidadWidget extends StatelessWidget {
  const PoliticaPrivacidadWidget({super.key});

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
        titulo: '1. Responsable del tratamiento de datos',
        texto:
            'La aplicación ANüikii es una herramienta de apoyo académico y de gestión desarrollada para la comunidad del SENA Regional La Guajira. El tratamiento de datos personales se realiza bajo la responsabilidad institucional del SENA, en cumplimiento de la normativa vigente en Colombia y de los procedimientos administrativos y académicos de la entidad.',
      ),
      _SeccionLegal(
        titulo: '2. Información que se recopila',
        texto:
            'Para la prestación del servicio, la aplicación puede recopilar datos de identificación como número de documento, nombres, rol institucional, ficha, programa y datos de acceso requeridos para la autenticación de usuarios. Asimismo, puede registrar información de uso, historial de búsquedas, actividad dentro de la aplicación y datos técnicos necesarios para la seguridad, el funcionamiento y la gestión institucional.',
      ),
      _SeccionLegal(
        titulo: '3. Finalidad del tratamiento',
        texto:
            'Los datos personales serán tratados con fines de identificación del usuario, acceso a la plataforma, personalización de la experiencia, apoyo a procesos formativos y académicos, control institucional, seguimiento de actividades, mejora de servicios y garantía de la seguridad y operación de la aplicación.',
      ),
      _SeccionLegal(
        titulo: '4. Base legal, confidencialidad y uso institucional',
        texto:
            'El tratamiento de la información se fundamenta en la relación educativa y administrativa del usuario con el SENA, así como en las obligaciones legales, técnicas y operativas de la entidad. La información será manejada con reserva, confidencialidad y protección de acuerdo con la normativa aplicable y solo podrá ser compartida cuando exista una obligación legal, una necesidad técnica o una autorización institucional válida.',
      ),
      _SeccionLegal(
        titulo: '5. Medidas de seguridad',
        texto:
            'El SENA adoptará medidas razonables y proporcionales para proteger la información personal, incluyendo controles de acceso, autenticación segura, gestión de credenciales, protección en tránsito y almacenamiento, y monitorización de la seguridad de la plataforma. No obstante, ningún sistema es completamente invulnerable, por lo que la entidad no puede garantizar la imposibilidad absoluta de accesos no autorizados.',
      ),
      _SeccionLegal(
        titulo: '6. Derechos de los usuarios',
        texto:
            'Los usuarios podrán ejercer sus derechos de acceso, actualización, corrección, supresión, limitación o oposición al tratamiento de sus datos personales, de conformidad con la normatividad vigente y la política interna de la entidad. Para ello, podrán dirigirse a la dependencia responsable de la aplicación o a la coordinación institucional encargada del manejo de la información.',
      ),
      _SeccionLegal(
        titulo: '7. Conservación de la información',
        texto:
            'La información será conservada durante el tiempo necesario para cumplir con la finalidad para la cual fue recolectada, así como con las exigencias legales, académicas y administrativas del SENA. Cuando deje de ser necesaria, será eliminada o archivada de acuerdo con los procedimientos institucionales.',
      ),
      _SeccionLegal(
        titulo: '8. Modificaciones y actualización de la política',
        texto:
            'El SENA puede actualizar esta política de privacidad en razón de cambios normativos, del funcionamiento de la aplicación o de ajustes internos de la entidad. Las modificaciones serán informadas a los usuarios mediante la propia aplicación o por los canales institucionales correspondientes.',
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
          'Política de privacidad',
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
                              Icons.shield_outlined,
                              color: accent,
                              size: (ancho * 0.055).clamp(18.0, 28.0),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Aviso institucional para protección de datos',
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
