// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get authenticateWithBiometrics => 'Autentique-se usando sua biometria';

  @override
  String get biometricsNotSupported => 'Seu dispositivo não suporta autenticação biométrica';

  @override
  String get biometricsNotConfigured => 'Nenhuma biometria configurada neste dispositivo';

  @override
  String get biometricsError => 'Erro ao tentar autenticação biométrica';

  @override
  String get biometricsFailed => 'Falha na autenticação biométrica';

  @override
  String get noSavedCredentials => 'Nenhuma credencial salva encontrada. Por favor, faça login manualmente primeiro.';

  @override
  String get loginWithBiometrics => 'Entrar com biometria';

  @override
  String get settings => 'Configurações';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get language => 'Idioma';

  @override
  String get profile => 'Perfil';

  @override
  String get editProfile => 'Editar nome e foto';

  @override
  String get notifications => 'Notificações';

  @override
  String get configureAlerts => 'Configurar alertas';

  @override
  String get about => 'Sobre';

  @override
  String get version => 'Versão 1.0.0';

  @override
  String get logout => 'Sair';

  @override
  String get reports => 'Relatórios';

  @override
  String get workDate => 'Data do Trabalho';

  @override
  String get selectDate => 'Selecione uma data';

  @override
  String get serviceDescription => 'Descrição do Serviço';

  @override
  String get enterDescription => 'Insira uma descrição';

  @override
  String get issuesFoundOptional => 'Problemas Encontrados (opcional)';

  @override
  String get enterEmail => 'Por favor, insira seu e-mail';

  @override
  String get invalidEmail => 'Por favor, insira um e-mail válido';

  @override
  String get enterPassword => 'Por favor, insira sua senha';

  @override
  String get passwordTooShort => 'A senha deve ter pelo menos 6 caracteres';

  @override
  String get loginFailed => 'Falha no login';

  @override
  String get loginButton => 'Entrar';

  @override
  String get noAccountRegister => 'Não tem conta? Registre-se';

  @override
  String get status => 'Status';

  @override
  String get completed => 'Positivo';

  @override
  String get pending => 'Neutral';

  @override
  String get inProgress => 'Negativo';

  @override
  String get selectStatus => 'Selecione um status';

  @override
  String get submitReport => 'Enviar Relatório';

  @override
  String get reportSubmittedSuccess => 'Relatório enviado com sucesso!';

  @override
  String get reportSubmissionError => 'Erro ao enviar relatório';

  @override
  String get register => 'Registre-se';

  @override
  String get name => 'Nome';

  @override
  String get enterName => 'Insira um nome';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get registerButton => 'Registrar';

  @override
  String get alreadyHaveAccount => 'Já tem conta? Faça login';

  @override
  String get registrationSuccess => 'Registro bem-sucedido! Faça login.';

  @override
  String get registrationFailed => 'Falha no registro';

  @override
  String get viewItems => 'Ver Itens';

  @override
  String get calendar => 'Calendário';

  @override
  String get add => 'Adicionar';

  @override
  String get manageItems => 'Gerenciar Itens';

  @override
  String get addItem => 'Adicionar Item';

  @override
  String get noItems => 'Nenhum item encontrado';

  @override
  String get errorLoading => 'Erro ao carregar itens';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get deleteSuccess => 'Item deletado com sucesso';

  @override
  String get deleteError => 'Erro ao deletar item';

  @override
  String scheduleFor(Object date) {
    return 'Escalar para $date';
  }

  @override
  String get personName => 'Nome da Pessoa';

  @override
  String get cancel => 'Cancelar';

  @override
  String get scheduleToday => 'Escala Hoje';

  @override
  String get editItem => 'Editar Item';

  @override
  String get equipmentUpdatedSuccess => 'Equipamento atualizado com sucesso';

  @override
  String get updateEquipment => 'Atualizar Equipamento';

  @override
  String equipmentAddError(Object error) {
    return 'Erro ao adicionar equipamento: $error';
  }

  @override
  String scheduleNotificationMessage(Object person) {
    return 'Olá, $person! Você está escalado(a) hoje.';
  }

  @override
  String scheduledFor(Object date) {
    return 'Escalado para $date';
  }

  @override
  String get addItems => 'Adicionar Itens';

  @override
  String get title => 'Título';

  @override
  String get enterTitle => 'Insira um título';

  @override
  String get subtitle => 'Subtítulo';

  @override
  String get enterSubtitle => 'Insira um subtítulo';

  @override
  String get price => 'Preço (R\$)';

  @override
  String get enterPrice => 'Insira um preço';

  @override
  String get enterValidPrice => 'Insira um valor válido';

  @override
  String get imageUrlOptional => 'URL da Imagem (opcional)';

  @override
  String get linkOptional => 'Link (opcional)';

  @override
  String get urgency => 'Urgência';

  @override
  String get high => 'Alta';

  @override
  String get medium => 'Média';

  @override
  String get low => 'Baixa';

  @override
  String get selectUrgency => 'Selecione a urgência';

  @override
  String get mostUrgent => 'Mais Urgente';

  @override
  String get addEquipment => 'Adicionar Equipamento';

  @override
  String get equipmentAddedSuccess => 'Equipamento adicionado com sucesso!';

  @override
  String get login => 'Login';
}
