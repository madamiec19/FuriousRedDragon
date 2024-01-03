import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furious_red_dragon/presentation/components/input.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:furious_red_dragon/core/main.dart';

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  await Supabase.initialize(
    url: 'https://ubjqvkvameebwmsjujbd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVianF2a3ZhbWVlYndtc2p1amJkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkwNjIwNTUsImV4cCI6MjAxNDYzODA1NX0.C0T-L8L_T5ny_gL2Mm4RAQJ36-DtZDoByAbLAqPcymk',
  );
  group('Testing App', () {
    testWidgets('Navigation Test', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Zaloguj się'), findsOneWidget);
      await tester.tap(find.text('Zaloguj się'));
      await tester.pumpAndSettle();

      expect(find.byType(CustomTextField), findsAtLeast(2));
      expect(find.text('Email'), findsOne);
      expect(find.text('Hasło'), findsOne);

      final email = find.widgetWithText(TextFormField, 'Email');
      final password = find.widgetWithText(TextFormField, 'Hasło');

      //await tester.tap(find.text('Email'));
      const falseEmail = 'testt@gmail.com';
      const falsePass = '333';

      await tester.enterText(email, falseEmail);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump(const Duration(seconds: 2));

      await tester.enterText(password, falsePass);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(find.text('Zaloguj się'));
      await tester.pump(const Duration(seconds: 7));

      expect(find.text('OK'), findsOne);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      final emailN = find.widgetWithText(TextFormField, falseEmail);
      final passwordN = find.widgetWithText(TextFormField, falsePass);

      await tester.enterText(emailN, 'tester@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text('tester@gmail.com'), findsOne);

      await tester.enterText(passwordN, '123');
      await tester.pumpAndSettle();

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump(const Duration(seconds: 5));

      await tester.tap(find.text('Zaloguj się'));
      await tester.pump(const Duration(seconds: 5));

      expect(find.text('Witaj, imię'), findsOne);

      await tester.tap(find.text('Konto'));
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('Dodaj salę'), findsOneWidget);

      await tester.tap(find.text('Historia'));
      await tester.pump(const Duration(seconds: 8));

      //expect(find.text('3/21, Szef'), findsOne);

      await tester.tap(find.text('Baza danych'));
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Baza danych'), findsAtLeast(2));

      await tester.tap(find.text('Skanuj'));
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Wpisz kod ręcznie'), findsExactly(1));

      await tester.tap(find.text('Wpisz kod ręcznie'));
      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(BackButton), findsOne);
      await tester.tap(find.byType(BackButton));
      await tester.pump(const Duration(seconds: 2));

      await tester.tap(find.text('Pomoc'));
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('Pomoc'), findsExactly(2));

      final settings = find.byIcon(Icons.settings);

      await tester.tap(settings);
      await tester.pumpAndSettle();

      final wyloguj = find.text('Wyloguj');
      expect(wyloguj, findsOne);
      await tester.tap(wyloguj);

      await tester.pump(const Duration(seconds: 4));
      expect(find.text('Zaloguj się'), findsOne);

      //expect(find.text('OK'), findsOne);
      //await tester.tap(find.text('OK'));

      //await tester.enterText(find.text('Hasło'), 'test123');
      //tester.pumpAndSettle();
      //await tester.tap(find.text('Zaloguj się'));
      //await tester.pumpAndSettle();
    });
  });
}
