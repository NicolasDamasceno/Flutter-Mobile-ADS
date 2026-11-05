import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'contato.dart';

/// Acesso à tabela `contatos` (id, nome, email) com SqFlite.
class BancoContatos {
  /// [caminho] permite usar outro arquivo (ex.: banco em memória nos testes).
  BancoContatos({this.caminho});

  final String? caminho;

  // Abre o banco uma única vez, na primeira operação.
  late final Future<Database> _banco = _abrirBanco();

  Future<Database> _abrirBanco() async {
    final caminho = this.caminho ?? join(await getDatabasesPath(), 'banco.db');
    return openDatabase(
      caminho,
      version: 1,
      onCreate: (db, versaoRecente) async {
        await db.execute(
          'CREATE TABLE contatos ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'nome VARCHAR NOT NULL, '
          'email VARCHAR NOT NULL)',
        );
      },
    );
  }

  /// Armazena um novo contato e retorna o id gerado.
  Future<int> salvar(Contato contato) async {
    final db = await _banco;
    return db.insert('contatos', {'nome': contato.nome, 'email': contato.email});
  }

  /// Consulta os contatos em ordem alfabética, filtrando por nome ou email.
  Future<List<Contato>> consultar({String filtro = ''}) async {
    final db = await _banco;
    final termo = filtro.trim();
    final linhas = await db.query(
      'contatos',
      where: termo.isEmpty ? null : 'nome LIKE ? OR email LIKE ?',
      whereArgs: termo.isEmpty ? null : ['%$termo%', '%$termo%'],
      orderBy: 'nome COLLATE NOCASE',
    );
    return linhas.map(Contato.fromMap).toList();
  }

  /// Altera nome e email do contato com o mesmo id.
  Future<int> alterar(Contato contato) async {
    final db = await _banco;
    return db.update(
      'contatos',
      {'nome': contato.nome, 'email': contato.email},
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  /// Exclui o contato com o id informado.
  Future<int> excluir(int id) async {
    final db = await _banco;
    return db.delete('contatos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> fechar() async => (await _banco).close();
}
