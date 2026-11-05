import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:navigation/main.dart' as app;

void main() {
  for (final botao in ['Abrir com push()', 'Abrir com rota nomeada']) {
    testWidgets('"$botao" abre a segunda página e "Voltar" retorna',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'Primeira Página'), findsOneWidget);

      await tester.tap(find.text(botao));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'Segunda Página'), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Primeira Página'), findsNothing);

      await tester.tap(find.text('Voltar'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'Primeira Página'), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Segunda Página'), findsNothing);
    });
  }
}
