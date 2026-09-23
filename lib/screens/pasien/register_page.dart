
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_pasien.dart';
 
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
 
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
 
class _RegisterPageState extends State<RegisterPage> {
  bool obscurePassword = true;
  bool isLoading = false;
 
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 
  static const cream = Color(0xFFFFF8F1);
  static const coral = Color(0xFFFF6F91);
  static const coralDeep = Color(0xFFF7476E);
  static const peach = Color(0xFFFF9A6C);
  static const ink = Color(0xFF2B2140);
  static const muted = Color(0xFF8D8299);
  static const line = Color(0xFFF0E4D8);
 
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
 
  // ---------------------------------------------------------
  // FUNGSI REGISTER — dipanggil saat tombol "Daftar" ditekan
  // ---------------------------------------------------------
  Future<void> _handleRegister() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
 
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field wajib diisi')),
      );
      return;
    }
 
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password minimal 6 karakter')),
      );
      return;
    }
 
    setState(() => isLoading = true);
 
    try {
      // 1. Bikin akun di Firebase Authentication
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
 
      // 2. Simpan data tambahan (nama, dll) ke Firestore,
      //    pakai uid dari Firebase Auth sebagai id dokumennya
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'created_at': FieldValue.serverTimestamp(),
      });
 
      setState(() => isLoading = false);
      if (!mounted) return;
 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil!')),
      );
 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPasien()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);
      if (!mounted) return;
 
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email sudah terdaftar';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid';
          break;
        case 'weak-password':
          message = 'Password terlalu lemah';
          break;
        default:
          message = 'Registrasi gagal: ${e.message}';
      }
 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      setState(() => isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan. Cek koneksi internet kamu.')),
      );
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 30),
 
              // LOGO
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [coral, peach],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x55F7476E),
                      blurRadius: 26,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.white,
                  size: 42,
                ),
              ),
 
              const SizedBox(height: 18),
 
              const Text(
                'Buat Akun Baru',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ink,
                ),
              ),
 
              const SizedBox(height: 8),
 
              const Text(
                'Daftar untuk mulai memantau\nkesehatanmu bersama VitalCheck.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: muted, height: 1.5),
              ),
 
              const SizedBox(height: 32),
 
              // NAMA
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nama Lengkap',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF564A6B),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan nama kamu',
                  prefixIcon: const Icon(Icons.person_outline_rounded, color: muted),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: line, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: coralDeep, width: 1.8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                ),
              ),
 
              const SizedBox(height: 18),
 
              // EMAIL
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF564A6B),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Masukkan email kamu',
                  prefixIcon: const Icon(Icons.mail_outline_rounded, color: muted),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: line, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: coralDeep, width: 1.8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                ),
              ),
 
              const SizedBox(height: 18),
 
              // PASSWORD
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF564A6B),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Minimal 6 karakter',
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: muted),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: muted,
                    ),
                    onPressed: () {
                      setState(() => obscurePassword = !obscurePassword);
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: line, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: coralDeep, width: 1.8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                ),
              ),
 
              const SizedBox(height: 26),
 
              // BUTTON DAFTAR
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: coralDeep,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
 
              const SizedBox(height: 25),
 
              // KEMBALI KE LOGIN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah punya akun? ',
                    style: TextStyle(fontSize: 13, color: muted),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // balik ke halaman Login
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: coralDeep,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}