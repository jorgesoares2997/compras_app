class Equipment {
  final int? id; // Opcional, como no TypeScript
  final String? title; // Opcional, alinhado com o carrossel
  final String? subtitle; // Substituindo "description" por "subtitle"
  final double? price; // Mudando para double? (opcional, como no TypeScript)
  final String? link; // Opcional
  final String? image; // Opcional
  final String? urgency; // Opcional
  final bool? mostUrgent; // Adicionando essa propriedade do carrossel

  Equipment({
    this.id,
    this.title,
    this.subtitle,
    this.price,
    this.link,
    this.image,
    this.urgency,
    this.mostUrgent,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] as int?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      price:
          (json['price'] as num?)
              ?.toDouble(), // Converte para double, se existir
      link: json['link'] as String?,
      image: json['image'] as String?,
      urgency: json['urgency'] as String?,
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
      'mostUrgent': mostUrgent,
    };
  }
}
