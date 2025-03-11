import 'package:intl/intl.dart';

class Report {
  final int? id;
  final DateTime date;
  final String description;
  final String? issues;
  final String status;
  final String? nomeVoluntario;
  final DateTime? dataCriacao;
  final int? escalaId;

  Report({
    this.id,
    required this.date,
    required this.description,
    this.issues,
    required this.status,
    this.nomeVoluntario,
    this.dataCriacao,
    this.escalaId,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      date: DateTime.parse(json['dataEscala']),
      description: json['descricao'],
      issues: json['issues'], // Pode ser null
      status: json['status'],
      nomeVoluntario: json['nomeVoluntario'],
      dataCriacao: DateTime.parse(json['dataCriacao']),
      escalaId: json['escalaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataEscala': DateFormat('yyyy-MM-dd').format(date),
      'descricao': description,
      'issues': issues,
      'status': status == 'Concluído' ? 'CONCLUIDO' : status.toUpperCase(),
      'escalaId': escalaId ?? 1, // Valor padrão, ajuste se necessário
    };
  }
}
