class Contato {
  const Contato({this.id, required this.nome, required this.email});

  /// Nulo enquanto o contato ainda não foi salvo no banco.
  final int? id;
  final String nome;
  final String email;

  Map<String, Object?> toMap() => {'id': id, 'nome': nome, 'email': email};

  factory Contato.fromMap(Map<String, Object?> map) => Contato(
        id: map['id'] as int,
        nome: map['nome'] as String,
        email: map['email'] as String,
      );
}
