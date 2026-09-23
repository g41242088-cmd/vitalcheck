
// =========================================================
// auth_service.dart
// Service untuk memanggil API register & login PHP
// =========================================================
//
// Tambahkan dulu di pubspec.yaml:
//   dependencies:
//     http: ^1.2.0
// lalu jalankan: flutter pub get
 
import 'dart:convert';
import 'package:http/http.dart' as http;
 
class AuthService {
  // GANTI sesuai kondisi kamu:
  // - Emulator Android      -> http://10.0.2.2/vitalcheck/api
  // - HP fisik / real device -> http://IP_KOMPUTER_KAMU/vitalcheck/api (mis. http://192.168.1.5/vitalcheck/api)
  // - Web / Windows desktop  -> http://localhost/vitalcheck/api
static const String baseUrl = "http://10.125.173.115/vitalcheck/api";
 
  // ---------------------------------------------------------
  // REGISTER
  // ---------------------------------------------------------
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/register.php");
 
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );
 
    return jsonDecode(response.body);
  }
 
  // ---------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/login.php");
 
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
 
    return jsonDecode(response.body);
  }
}
 
// =========================================================
// Contoh pemakaian di halaman Flutter kamu:
// =========================================================
//
// final result = await AuthService.register(
//   name: namaController.text,
//   email: emailController.text,
//   password: passwordController.text,
// );
//
// if (result["success"] == true) {
//   print("Berhasil daftar, user_id: ${result['user_id']}");
// } else {
//   print("Gagal: ${result['message']}");
// }
 