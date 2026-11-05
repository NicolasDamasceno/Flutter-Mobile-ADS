import 'package:flutter_test/flutter_test.dart';

import 'package:tabbar/main.dart';

void main() {
  testWidgets('cada aba mostra o conteúdo da sua classe',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Está nublado aqui'), findsOneWidget);

    await tester.tap(find.text('Chuvoso'));
    await tester.pumpAndSettle();
    expect(find.text('Está chovendo aqui'), findsOneWidget);
    expect(find.text('Está nublado aqui'), findsNothing);

    await tester.tap(find.text('Ensolarado'));
    await tester.pumpAndSettle();
    expect(find.text('Está ensolarado aqui'), findsOneWidget);
    expect(find.text('Está chovendo aqui'), findsNothing);
  });
}
