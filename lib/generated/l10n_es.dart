// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settings => 'Configuraciones';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get profile => 'Perfil';

  @override
  String get editProfile => 'Editar nombre y foto';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get configureAlerts => 'Configurar alertas';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión 1.0.0';

  @override
  String get logout => 'Salir';

  @override
  String get reports => 'Informes';

  @override
  String get workDate => 'Fecha de Trabajo';

  @override
  String get selectDate => 'Seleccione una fecha';

  @override
  String get serviceDescription => 'Descripción del Servicio';

  @override
  String get enterDescription => 'Ingrese una descripción';

  @override
  String get issuesFoundOptional => 'Problemas Encontrados (opcional)';

  @override
  String get enterEmail => 'Por favor, introduce tu correo electrónico';

  @override
  String get invalidEmail => 'Por favor, introduce un correo electrónico válido';

  @override
  String get enterPassword => 'Por favor, introduce tu contraseña';

  @override
  String get passwordTooShort => 'La contraseña debe tener al menos 6 caracteres';

  @override
  String get loginFailed => 'Fallo en el inicio de sesión';

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get noAccountRegister => '¿No tienes cuenta? Regístrate';

  @override
  String get status => 'Estado';

  @override
  String get completed => 'Completado';

  @override
  String get pending => 'Pendiente';

  @override
  String get inProgress => 'En Progreso';

  @override
  String get selectStatus => 'Seleccione un estado';

  @override
  String get submitReport => 'Enviar Informe';

  @override
  String get reportSubmittedSuccess => '¡Informe enviado con éxito!';

  @override
  String get reportSubmissionError => 'Error al enviar el informe';

  @override
  String get register => 'Registrarse';

  @override
  String get name => 'Nombre';

  @override
  String get enterName => 'Ingrese un nombre';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get registerButton => 'Registrar';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get registrationSuccess => '¡Registro exitoso! Por favor, inicia sesión.';

  @override
  String get registrationFailed => 'Fallo en el registro';

  @override
  String get viewItems => 'Ver Artículos';

  @override
  String get calendar => 'Calendario';

  @override
  String get add => 'Añadir';

  @override
  String get manageItems => 'Gestionar Artículos';

  @override
  String scheduleFor(Object date) {
    return 'Programar para $date';
  }

  @override
  String get personName => 'Nombre de la Persona';

  @override
  String get cancel => 'Cancelar';

  @override
  String get scheduleToday => 'Programación de Hoy';

  @override
  String scheduleNotificationMessage(Object person) {
    return '¡Hola, $person! Estás programado(a) hoy.';
  }

  @override
  String scheduledFor(Object date) {
    return 'Programado para $date';
  }

  @override
  String get addItems => 'Añadir Artículos';

  @override
  String get title => 'Título';

  @override
  String get enterTitle => 'Ingrese un título';

  @override
  String get subtitle => 'Subtítulo';

  @override
  String get enterSubtitle => 'Ingrese un subtítulo';

  @override
  String get price => 'Precio (R\$)';

  @override
  String get enterPrice => 'Ingrese un precio';

  @override
  String get enterValidPrice => 'Ingrese un valor válido';

  @override
  String get imageUrlOptional => 'URL de la Imagen (opcional)';

  @override
  String get linkOptional => 'Enlace (opcional)';

  @override
  String get urgency => 'Urgencia';

  @override
  String get high => 'Alta';

  @override
  String get medium => 'Media';

  @override
  String get low => 'Baja';

  @override
  String get selectUrgency => 'Seleccione la urgencia';

  @override
  String get mostUrgent => 'Más Urgente';

  @override
  String get addEquipment => 'Añadir Equipo';

  @override
  String get equipmentAddedSuccess => '¡Equipo añadido con éxito!';

  @override
  String equipmentAddError(Object error) {
    return 'Error al añadir equipo: $error';
  }

  @override
  String get login => 'Inicio de Sesión';
}
