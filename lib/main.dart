import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/pasien/login_page.dart';
 
void main() async {
  // Wajib dipanggil sebelum Firebase.initializeApp()
  WidgetsFlutterBinding.ensureInitialized();
 
  // Nyalakan koneksi ke project Firebase kamu
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  runApp(const VitalCheckApp());
}
 
class VitalCheckApp extends StatelessWidget {
  const VitalCheckApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VitalCheck',
      home: LoginPage(), // halaman pertama yang muncul sekarang login
    );
  }
}