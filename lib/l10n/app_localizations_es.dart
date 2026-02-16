// ignore: unused_import

// 📦 Package imports:
import 'package:intl/intl.dart' as intl;

// 🌎 Project imports:
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String byDeveloper(Object developer) {
    return 'por $developer';
  }

  @override
  String get bottomWallSelectorTitle => 'Establecer como fondo de pantalla';

  @override
  String get bottomWallSelectorSubTitle =>
      '¿Quieres poner esta imagen como fondo de pantalla principal, pantalla de bloqueo o ambas pantallas?';

  @override
  String get bottomWallSelectorHS => 'Pantalla principal';

  @override
  String get bottomWallSelectorLS => 'Pantalla de bloqueo';

  @override
  String get bottomWallSelectorBS => 'Pantallas de bloqueo y principal';

  @override
  String get appliedOk => 'Wallpaper aplicado con exito!';

  @override
  String get appliedError => 'Error al aplicar wallpaper :(';

  @override
  String get errorMessage =>
      '¿No es vergonzoso? Parece que no podemos encontrar lo que buscas';

  @override
  String get noFunction => 'Función no disponible por el momento';

  @override
  String get downloadOk => 'Descargado con éxito';

  @override
  String get downloadError => 'Error en la descarga';

  @override
  String get settingsAppBarTitle => 'Configuración';

  @override
  String get donations => 'Ayúdanos a mantener la experiencia sin anuncios';

  @override
  String get donationsNote =>
      'Las donaciones apoyan el desarrollo continuo y código libre de Kreator Frame. El contenido compartido en esta plataforma es propiedad de sus respectivos creadores.';

  @override
  String get donationsButton => 'Contribuir ahora';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsAppearanceLT1 => 'Tema de la aplicación';

  @override
  String get settingsAppearanceLST1 => 'Elige un tema preestablecido';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsAboutLST1 => 'Acerca del Kustom Pack';

  @override
  String get settingsAboutLST2 => 'Acerca del Dashboard';

  @override
  String get aboutDashboard =>
      'Kreator Frame es el dashboard que te da el control total para personalizar el aspecto de tu dispositivo móvil con widgets modernos y personalizados. \n\nCon Kreator Frame, puedes crear una experiencia única adaptada a tus necesidades. Los widgets compatibles con la aplicación Kustom Widget Maker te permiten añadir funciones adicionales a tu dispositivo móvil, como widgets para música, el tiempo, seguimiento de actividad y mucho más. \n\nGracias a su diseño minimalista y moderno, la aplicación se integra perfectamente con el estilo de tu dispositivo móvil. Kreator Frame te ofrece la fluidez y el control que necesitas para personalizar la pantalla de inicio de tu dispositivo móvil de forma sencilla. \n\nEste dashboard es completamente gratuito, sin publicidad y OpenSource. Si encuentras útil esta plataforma y te gustaría apoyar el desarrollo continuo de la misma, considera hacer una donación. Las donaciones que hagas ayudarán a mantener y mejorar el dashboard, pero no afectan el contenido compartido por los creadores de widgets. Agradecemos mucho tu apoyo para mantener esta app disponible para todos.';

  @override
  String aboutPackage(Object developerName, Object packageName) {
    return '$packageName es un pack de skins para Kustom, el motor de fondos de pantalla para android más avanzado. Este pack ha sido creado por $developerName y agradecemos tu apoyo descargando esta app directamente desde Google Play Store. \n\nEn esta aplicación puedes encontrar widgets y fondos de pantalla que puedes añadir a tu pantalla de inicio para darle un aspecto más agradable, recuerda que los widgets pueden ser modificados por ti para una experiencia más agradable y precisa. \n\nSi tienes alguna duda o consejo no dudes en ponerte en contacto conmigo a través de cualquiera de mis redes sociales que aparecen a continuación.';
  }

  @override
  String get settingsLegal => 'Aspectos Legales';

  @override
  String get settingsLegalLT1 => 'Términos y Condiciones';

  @override
  String get settingsLegalLST1 => 'Efectivos a partir de 10/10/2024';

  @override
  String get settingsLegalLT2 => 'Pólitica de Privacidad';

  @override
  String get settingsLegalLST2 => 'Politica efectiva a partir de 10/10/2024';

  @override
  String get settingsLicences => 'Licencias de software';

  @override
  String get settingsLicencesLT1 => 'Licencias (OSS)';

  @override
  String get settingsLicencesLST1 => 'Licencias de código abierto';

  @override
  String get settingsVersions => 'Versiones Actuales';

  @override
  String get themeAppBarTitle => 'Selector de temas';

  @override
  String get themeSelector => 'Selecciona un tema';

  @override
  String get themeColorSelector => 'Selecciona un color para el tema';
}
