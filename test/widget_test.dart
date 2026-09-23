import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vitalcheck/main.dart';
import 'package:vitalcheck/screens/pasien/riwayat_pasien_page.dart';
import 'package:vitalcheck/screens/pasien/fasyankes_pasien_page.dart';

void main() {
  testWidgets('VitalCheck navigation and profil smoke test', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const VitalCheckApp());

    // Beranda is initially shown
    expect(find.text('Halo, Dinda 👋'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);

    // Tap on Profil tab
    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();

    // Verify Profil content is displayed
    expect(find.text('Dinda Putri'), findsOneWidget);
    expect(find.text('dinda.putri@email.com'), findsOneWidget);
    expect(find.text('SKRINING'), findsOneWidget);
    expect(find.text('KONSULTASI'), findsOneWidget);
    expect(find.text('RISIKO TERKINI'), findsOneWidget);
    expect(find.text('Data Diri'), findsOneWidget);
    expect(find.text('Riwayat Skrining'), findsOneWidget);
    expect(find.text('Privasi & Keamanan'), findsOneWidget);
    expect(find.text('Bahasa'), findsOneWidget);
    expect(find.text('Keluar'), findsOneWidget);
    expect(find.text('VitalCheck v1.4.0'), findsOneWidget);
  });

  testWidgets('RiwayatPasienPage displays 4 dummy results correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RiwayatPasienPage(),
      ),
    );

    expect(find.text('Riwayat Skrining'), findsOneWidget);
    expect(find.text('4 hasil tersimpan'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('AGU'), findsOneWidget);
    expect(find.text('02'), findsOneWidget);
    expect(find.text('MEI'), findsOneWidget);
    expect(find.text('19'), findsOneWidget);
    expect(find.text('JAN'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('SEP'), findsOneWidget);
    expect(find.text('Skrining Mandiri'), findsNWidgets(4));
    expect(find.text('Rendah'), findsNWidgets(3));
    expect(find.text('Sedang'), findsOneWidget);
    expect(find.text('Risiko Rendah · Skor 18%'), findsOneWidget);
    expect(find.text('Risiko Sedang · Skor 46%'), findsOneWidget);
  });

  testWidgets('FasyankesPasienPage displays banner, filter chips, and clinic cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FasyankesPasienPage(),
      ),
    );

    expect(find.text('Fasyankes Terdekat'), findsOneWidget);
    expect(find.text('Lokasimu • Jember, Jawa Timur'), findsOneWidget);
    expect(find.text('Semua'), findsOneWidget);
    expect(find.text('Puskesmas'), findsOneWidget);
    expect(find.text('Rumah Sakit'), findsOneWidget);
    expect(find.text('Klinik'), findsOneWidget);

    // Initial shows all 3 cards
    expect(find.text('Puskesmas Sumbersari'), findsOneWidget);
    expect(find.text('RSUD dr. Soebandi'), findsOneWidget);
    expect(find.text('Klinik Kasih Sahabat'), findsOneWidget);

    // Tap on 'Puskesmas' filter chip
    await tester.tap(find.text('Puskesmas'));
    await tester.pumpAndSettle();

    expect(find.text('Puskesmas Sumbersari'), findsOneWidget);
    expect(find.text('RSUD dr. Soebandi'), findsNothing);
    expect(find.text('Klinik Kasih Sahabat'), findsNothing);

    // Tap on 'Rumah Sakit' filter chip
    await tester.tap(find.text('Rumah Sakit'));
    await tester.pumpAndSettle();

    expect(find.text('RSUD dr. Soebandi'), findsOneWidget);
    expect(find.text('Puskesmas Sumbersari'), findsNothing);
  });

  testWidgets('Dashboard navigation to Riwayat and Fasyankes works properly', (WidgetTester tester) async {
    await tester.pumpWidget(const VitalCheckApp());
    await tester.pumpAndSettle();

    // Tap 'Riwayat' shortcut
    await tester.tap(find.text('Riwayat'));
    await tester.pumpAndSettle();

    expect(find.text('Riwayat Skrining'), findsOneWidget);
    expect(find.text('4 hasil tersimpan'), findsOneWidget);

    // Tap back button
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    // Back to dashboard
    expect(find.text('Halo, Dinda 👋'), findsOneWidget);

    // Tap 'Fasyankes' shortcut
    await tester.tap(find.text('Fasyankes'));
    await tester.pumpAndSettle();

    expect(find.text('Fasyankes Terdekat'), findsOneWidget);

    // Tap back button
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    // Back to dashboard
    expect(find.text('Halo, Dinda 👋'), findsOneWidget);
  });
}
