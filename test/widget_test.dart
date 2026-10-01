// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bank/main.dart';

void main() {
  testWidgets('creates and lists a game purchase', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LojaDeGamesApp());

    expect(find.text('Loja de Games'), findsOneWidget);

    // Registros iniciais em memória
    expect(find.byIcon(Icons.sports_esports), findsNWidgets(2));
    expect(find.text('Pedido nº 1'), findsOneWidget);
    expect(find.text('Pedido nº 2'), findsOneWidget);
    expect(find.textContaining('R\$'), findsNWidgets(2));
    expect(find.textContaining('59,90'), findsOneWidget);
    expect(find.textContaining('199,90'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Nova Compra'), findsOneWidget);

    // Dados inválidos não criam a compra
    await tester.enterText(find.byType(TextField).at(0), 'abc');
    await tester.enterText(find.byType(TextField).at(1), 'xyz');
    await tester.tap(find.text('Registrar Compra'));
    await tester.pumpAndSettle();

    expect(find.text('Nova Compra'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '1234');
    await tester.enterText(find.byType(TextField).at(1), '349.90');
    await tester.tap(find.text('Registrar Compra'));
    await tester.pumpAndSettle();

    // A compra só entra na lista depois do Future.delayed de 1 segundo
    expect(find.text('Pedido nº 1234'), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Pedido nº 1234'), findsOneWidget);
    expect(find.textContaining('349,90'), findsOneWidget);
  });
}
