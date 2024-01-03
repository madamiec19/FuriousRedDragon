import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

void main() {
  testWidgets('Custom Widgets Test', (WidgetTester tester) async {
    int x = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            BigRedButton(
              onTap: () {
                x++;
              },
              buttonTitle: 'Red',
            ),
            BigRedButton(
              onTap: () {},
              buttonTitle: 'Cźęrwóny',
            ),
            BigWhiteButton(
              onTap: () {},
              buttonTitle: 'Www',
            ),
            SmallButton(onTap: () {}, buttonTitle: 'smol'),
          ],
        ),
      ),
    ));

    expect(find.text('Cźęrwóny'), findsOneWidget);
    expect(find.text('Red'), findsOneWidget);
    expect(find.text('Zielony'), findsNothing);
    expect(find.text('Www'), findsOneWidget);
    expect(find.text('smol'), findsOneWidget);
    await tester.tap(find.text('Red'));
    await tester.pump(const Duration(seconds: 4));
    expect(x == 1, true);
  });
}
