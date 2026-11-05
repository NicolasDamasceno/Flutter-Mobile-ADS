import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:listview_checkbox/main.dart';

bool marcado(WidgetTester tester, String nome) =>
    tester.widget<CheckboxListTile>(find.byKey(Key(nome))).value!;

void main() {
  testWidgets('pressionar um item alterna apenas o checkbox dele',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(marcado(tester, 'Arroz'), isTrue);
    expect(marcado(tester, 'Feijao'), isTrue);

    await tester.tap(find.text('Arroz'));
    await tester.pump();
    expect(marcado(tester, 'Arroz'), isFalse);
    expect(marcado(tester, 'Feijao'), isTrue);

    await tester.tap(find.text('Arroz'));
    await tester.pump();
    expect(marcado(tester, 'Arroz'), isTrue);
  });
}
