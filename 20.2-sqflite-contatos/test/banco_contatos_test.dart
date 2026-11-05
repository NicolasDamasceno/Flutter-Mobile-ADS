import 'package:contatos_sqflite/banco_contatos.dart';
import 'package:contatos_sqflite/contato.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late BancoContatos banco;

  setUp(() => banco = BancoContatos(caminho: inMemoryDatabasePath));
  tearDown(() => banco.fechar());

  test('salva, consulta, altera e exclui contatos', () async {
    final idAna =
        await banco.salvar(const Contato(nome: 'Ana', email: 'ana@email.com'));
    final idBruno = await banco
        .salvar(const Contato(nome: 'bruno', email: 'bruno@email.com'));
    expect(idBruno, isNot(idAna));

    // Ordem alfabética sem diferenciar maiúsculas
    var contatos = await banco.consultar();
    expect(contatos.map((c) => c.nome), ['Ana', 'bruno']);

    await banco.alterar(
        Contato(id: idAna, nome: 'Ana Maria', email: 'anamaria@email.com'));
    contatos = await banco.consultar();
    expect(contatos.first.id, idAna);
    expect(contatos.first.nome, 'Ana Maria');
    expect(contatos.first.email, 'anamaria@email.com');
    expect(contatos.last.nome, 'bruno', reason: 'outros contatos intactos');

    await banco.excluir(idAna);
    contatos = await banco.consultar();
    expect(contatos.map((c) => c.id), [idBruno]);
  });

  test('consulta filtra por nome ou email', () async {
    await banco.salvar(const Contato(nome: 'Ana', email: 'ana@ifpi.edu.br'));
    await banco.salvar(const Contato(nome: 'Carlos', email: 'carlos@gmail.com'));

    expect((await banco.consultar(filtro: 'carl')).map((c) => c.nome),
        ['Carlos']);
    expect((await banco.consultar(filtro: 'ifpi')).map((c) => c.nome),
        ['Ana']);
    expect(await banco.consultar(filtro: 'zzz'), isEmpty);
    expect(await banco.consultar(filtro: '  '), hasLength(2));
  });
}
