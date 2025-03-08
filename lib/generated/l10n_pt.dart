// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

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
  String get status => 'Status';

  @override
  String get completed => 'Concluído';

  @override
  String get pending => 'Pendente';

  @override
  String get inProgress => 'Em Andamento';

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
  String get email => 'Email';

  @override
  String get enterEmail => 'Insira um email';

  @override
  String get password => 'Senha';

  @override
  String get enterPassword => 'Insira uma senha';

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
  String equipmentAddError(Object error) {
    return 'Erro ao adicionar equipamento: $error';
  }

  @override
  String get login => 'Login';

  @override
  String get loginButton => 'Entrar';

  @override
  String get noAccountRegister => 'Não tem conta? Registre-se';

  @override
  String get loginFailed => 'Falha no login';
}
