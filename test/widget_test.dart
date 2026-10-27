import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_mobile/main.dart';

void main() {
  testWidgets('Aplikasi Kantin menampilkan daftar menu dan tombol tambah', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Pastikan AppBar dan judul tampil
    expect(find.text('Kantin Teknik Untirta'), findsOneWidget);

    // Pastikan tombol tambah (FloatingActionButton) dengan ikon add ada
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Pastikan salah satu menu awal tampil
    expect(find.text('Nasi Goreng Spesial'), findsOneWidget);
  });
}
