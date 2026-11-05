import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:text_field_aula/main.dart';

Future<void> preencher(WidgetTester tester,
    {required String alcool, required String gasolina}) async {
  await tester.enterText(
      find.widgetWithText(TextField, 'Valor do etanol'), alcool);
  await tester.enterText(
      find.widgetWithText(TextField, 'Valor da gasolina'), gasolina);
}

void main() {
  testWidgets('resultado só aparece ao clicar em Calcular',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await preencher(tester, alcool: '4,00', gasolina: '6,00');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(find.textContaining('Abastecer'), findsNothing);

    await tester.tap(find.text('Calcular'));
    await tester.pump();
    expect(find.text('Abastecer com Álcool'), findsOneWidget);
  });

  testWidgets('álcool só compensa abaixo de 70% da gasolina',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await preencher(tester, alcool: '4,19', gasolina: '6,00'); // 69,8%
    await tester.tap(find.text('Calcular'));
    await tester.pump();
    expect(find.text('Abastecer com Álcool'), findsOneWidget);

    await preencher(tester, alcool: '4,20', gasolina: '6,00'); // 70,0%
    await tester.tap(find.text('Calcular'));
    await tester.pump();
    expect(find.text('Abastecer com Gasolina'), findsOneWidget);
  });
}
