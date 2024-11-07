class Estado {
  final int id_estado;
  final String tipo;
  DateTime created_at;
  

  Estado({required this.id_estado, required this.tipo, required this.created_at});

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      id_estado: json['id_estado'],
      tipo: json['tipo'],
      created_at: DateTime.parse(json['created_at'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_estado': id_estado,
      'tipo': tipo,
      'created_at': created_at.toIso8601String(),
    };
  }
}
