class Equipment {
  final int? id; // Opcional, gerado pelo backend
  final String title; // Obrigatório
  final String? subtitle;
  final double price; // Obrigatório
  final String? link;
  final String? image;
  final String? urgency;
  final String? local; // Adicionado para alinhar com o backend
  final bool? mostUrgent; // Opcional, específico do frontend

  Equipment({
    this.id,
    required this.title, // Tornando obrigatório
    this.subtitle,
    required this.price, // Tornando obrigatório
    this.link,
    this.image,
    this.urgency,
    this.local,
    this.mostUrgent,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] as int?,
      title: json['title'] as String? ?? '', // Default para vazio se null
      subtitle: json['subtitle'] as String?,
      price:
          (json['price'] as num?)?.toDouble() ??
          0.0, // Default para 0.0 se null
      link: json['link'] as String?,
      image: json['image'] as String?,
      urgency: json['urgency'] as String?,
      local: json['local'] as String?,
      mostUrgent: json['mostUrgent'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'price': price,
      'link': link,
      'image': image,
      'urgency': urgency,
      'local': local,
      // 'mostUrgent' não é enviado ao backend, pois não existe lá
    };
  }
}
