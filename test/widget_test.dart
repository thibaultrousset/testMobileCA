import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_mobile_ca/views/banks_lists.dart';
import 'package:test_mobile_ca/views/home_screen.dart';
import 'package:test_mobile_ca/widgets/empty_state.dart';

import 'widget_test.mocks.dart';


@GenerateMocks([HomeScreenState])
void main() {


  group('HomeScreen tests', () {

    final modelState = MockHomeScreenState();



    testWidgets('HomeScreen should build correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      final bankListFinder = find.byType(BankList);
      final bottomNavigationBarFinder = find.byType(BottomNavigationBar);

      expect(bankListFinder, findsOneWidget);
      expect(bottomNavigationBarFinder, findsOneWidget);
    });

    testWidgets('BankService.getBanks should be called on initState', (WidgetTester tester) async {
      var banksList  = [
        {
          "accounts": [
            {
              "balance": 843.15,
              "contract_number": "09320939231",
              "holder": "M. et Mme Martin",
              "id": "9892736780987654",
              "label": "Compte joint",
              "operations": [
                {
                  "amount": "-750,00",
                  "category": "housing",
                  "date": "1644179569",
                  "id": "3",
                  "title": "Prélèvement Century 21"
                }
              ],
              "order": 2,
              "product_code": "00007",
              "role": 2
            },
          ],
          "isCA": 1,
          "name": "CA Languedoc"
        },
        {
          "accounts": [
          ],
          "isCA": 0,
          "name": "Banque Pop"
        },
      ];
      when(modelState.getBanks()).thenReturn(banksList);
      expect(modelState.getBanks(), banksList);
      when(modelState.getBanks()).thenReturn([]);
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();
      final emptyStateFinder = find.byType(EmptyState);
      expect(emptyStateFinder, findsNWidgets(2));
    });

    testWidgets('SnackBar should be displayed when BankService.getBanks fails', (WidgetTester tester) async {
      when(modelState.getBanks()).thenThrow("error");
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pumpAndSettle();

      final snackBarFinder = find.byType(SnackBar);
      expect(snackBarFinder, findsOneWidget);
    });});
}