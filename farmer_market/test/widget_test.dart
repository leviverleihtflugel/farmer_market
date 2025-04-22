import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:farmer_market/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Bu test uygulamanda sayacın olup olmamasına göre çalışabilir ya da başarısız olabilir.
    // Sayacın olmadığı bir uygulamadaysan, aşağıdaki testler anlamsızdır ve silinebilir.

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
