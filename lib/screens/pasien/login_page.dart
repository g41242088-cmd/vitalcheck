import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard_pasien.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = true;
  bool isLoading = false; // untuk nampilin loading saat manggil API

  // Controller buat "membaca" apa yang diketik user di kolom email & password
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
    // Wajib dibersihkan biar tidak bocor memori
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------
  // FUNGSI LOGIN — dipanggil saat tombol "Masuk" ditekan
  // ---------------------------------------------------------
  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password wajib diisi')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      setState(() => isLoading = false);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPasien()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);
      if (!mounted) return;

      // Terjemahkan pesan error Firebase ke Bahasa Indonesia yang mudah dipahami
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'Email belum terdaftar';
          break;
        case 'wrong-password':
        case 'invalid-credential':
          message = 'Email atau password salah';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid';
          break;
        default:
          message = 'Login gagal: ${e.message}';
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
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 30,
          ),

          child: Column(
            children: [

              const SizedBox(height: 45),

              // LOGO
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [
                      coral,
                      peach,
                    ],
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
                'VitalCheck',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: ink,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Pantau kesehatanmu dengan mudah\nkapan saja dan di mana saja.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: muted,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 38),

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
                controller: emailController, // <-- ditambahkan
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Masukkan email kamu',
                  prefixIcon: const Icon(
                    Icons.mail_outline_rounded,
                    color: muted,
                  ),

                  filled: true,
                  fillColor: Colors.white,

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: line,
                      width: 1.5,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: coralDeep,
                      width: 1.8,
                    ),
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 15,
                  ),
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
                controller: passwordController, // <-- ditambahkan
                obscureText: obscurePassword,

                decoration: InputDecoration(
                  hintText: 'Masukkan password',

                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: muted,
                  ),

                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: muted,
                    ),

                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),

                  filled: true,
                  fillColor: Colors.white,

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: line,
                      width: 1.5,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: coralDeep,
                      width: 1.8,
                    ),
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 15,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,

                child: TextButton(
                  onPressed: () {},

                  child: const Text(
                    'Lupa password?',
                    style: TextStyle(
                      color: coralDeep,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // BUTTON LOGIN
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  // Kalau lagi loading, tombol dinonaktifkan (null) biar tidak dobel klik
                  onPressed: isLoading ? null : _handleLogin,

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
                          'Masuk',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 25),

              // REGISTER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Text(
                    'Belum punya akun? ',
                    style: TextStyle(
                      fontSize: 13,
                      color: muted,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                    },

                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: coralDeep,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // TRUST INFORMATION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: const [

                  Column(
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFF1FA495),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Aman',
                        style: TextStyle(
                          fontSize: 10,
                          color: muted,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xFF1FA495),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Privat',
                        style: TextStyle(
                          fontSize: 10,
                          color: muted,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Icon(
                        Icons.favorite_border_rounded,
                        color: Color(0xFF1FA495),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Terpercaya',
                        style: TextStyle(
                          fontSize: 10,
                          color: muted,
                        ),
                      ),
                    ],
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