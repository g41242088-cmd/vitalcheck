import 'dart:math' as math;
import 'package:flutter/material.dart';
class SkriningPasienPage extends StatefulWidget {
  const SkriningPasienPage({super.key});
  @override
State<SkriningPasienPage> createState() => _SkriningPasienPageState();
}
class _SkriningPasienPageState extends State<SkriningPasienPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
int currentQuestion = 0;
bool hasStarted = false;
  late final AnimationController _introAnimationController;
// Jawaban pengguna
  final Map<int, dynamic> answers = {};
// Controller untuk input angka
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController cd8Controller = TextEditingController();
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Berapa usia Anda saat ini?',
      'type': 'number',
      'hint': 'Contoh: 25',
    },
    {
      'question': 'Berapa berat badan Anda saat ini?',
      'type': 'number',
      'hint': 'Dalam kg, contoh: 60',
    },
    {
      'question':
          'Bagaimana kondisi fisik dan kemampuan Anda dalam melakukan aktivitas sehari-hari?',
      'type': 'choice',
      'options': [
        'Sangat Baik',
        'Cukup Baik',
        'Terbatas',
      ],
    },
    {
      'question':
          'Apakah Anda sedang merasakan gejala kesehatan tertentu saat ini?',
      'description':
          'Contohnya demam berkepanjangan, penurunan berat badan drastis, atau diare kronis.',
      'type': 'choice',
      'options': [
        'Ya, saya merasakan gejala tersebut.',
        'Tidak ada gejala yang dirasakan.',
      ],
    },
    {
      'question':
          'Apakah Anda pernah atau sedang menjalani pengobatan antiretroviral (ARV) sebelum skrining ini?',
      'type': 'choice',
      'options': [
        'Belum pernah sama sekali.',
        'Sudah pernah / sedang menjalani pengobatan ARV.',
      ],
    },
    {
      'question':
          'Apakah dalam 30 hari terakhir Anda rutin mengonsumsi obat antiretroviral (ARV) sesuai petunjuk dokter?',
      'type': 'choice',
      'options': [
        'Ya, rutin mengonsumsi.',
        'Tidak / Kadang-kadang saja.',
        'Belum pernah menerima resep obat.',
      ],
    },
    {
      'question':
          'Berapa jumlah sel CD4 Anda pada hasil pemeriksaan laboratorium awal/terakhir?',
      'type': 'choice',
      'options': [
        'Kurang dari 200 cells/µL',
        '200 – 499 cells/µL',
        '500 cells/µL atau lebih',
        'Saya tidak tahu / Belum pernah tes CD4',
      ],
    },
    {
      'question':
          'Berapa jumlah sel CD8 Anda pada hasil pemeriksaan laboratorium terakhir?',
      'type': 'number_or_unknown',
      'hint': 'Dalam cells/µL',
    },
    {
      'question':
          'Apakah Anda memiliki riwayat hubungan seksual dengan sesama jenis (khusus Laki-Laki / LSL)?',
      'type': 'choice',
      'options': [
        'Ya',
        'Tidak',
        'Lebih memilih untuk tidak menjawab',
      ],
    },
    {
      'question':
          'Apakah Anda memiliki riwayat penggunaan jarum suntik secara bergantian atau riwayat konsumsi NAPZA suntik?',
      'type': 'choice',
      'options': [
        'Ya',
        'Tidak',
      ],
    },
  ];
  @override
  void initState() {
    super.initState();
    _introAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
  }
  @override
  void dispose() {
    _introAnimationController.dispose();
    _pageController.dispose();
    ageController.dispose();
    weightController.dispose();
    cd8Controller.dispose();
    super.dispose();
  }
  void startScreening() {
setState(() {
      hasStarted = true;
    });
  }
  void nextQuestion() {
    if (!_isCurrentAnswerValid()) {
ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan isi jawaban terlebih dahulu.'),
        ),
      );
      return;
    }
    if (currentQuestion < questions.length - 1) {
setState(() {
        currentQuestion++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
_showResultPreview();
    }
  }
  void previousQuestion() {
    if (currentQuestion > 0) {
setState(() {
        currentQuestion--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
setState(() {
        hasStarted = false;
      });
    }
  }
bool _isCurrentAnswerValid() {
    if (questions[currentQuestion]['type'] == 'number') {
      if (currentQuestion == 0) {
        return ageController.text.trim().isNotEmpty;
      }
      if (currentQuestion == 1) {
        return weightController.text.trim().isNotEmpty;
      }
    }
    if (questions[currentQuestion]['type'] == 'number_or_unknown') {
      return answers[currentQuestion] != null;
    }
    return answers[currentQuestion] != null;
  }
  void _showResultPreview() {
showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Skrining selesai'),
          content: const Text(
            'Semua pertanyaan sudah dijawab. '
            'Selanjutnya hasil jawaban akan diproses menggunakan model Decision Tree.',
          ),
          actions: [
TextButton(
              onPressed: () {
Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
// ============================================================
// HALAMAN PEMBUKA SKRINING
// ============================================================
Widget _floatingMedicalIcon({
  required IconData icon,
  required Color color,
  required Color glowColor,
  required double size,
  required double dx,
  required double dy,
  required double phase,
}) {
  return AnimatedBuilder(
    animation: _introAnimationController,
    builder: (context, child) {
      final t = (_introAnimationController.value + phase) % 1.0;
      final wave = math.sin(t * math.pi * 2);
      final movement = wave * 8;
      final scale = 0.97 + ((wave + 1) / 2) * 0.04;

      return Transform.translate(
        offset: Offset(dx, dy + movement),
        child: Transform.scale(
          scale: scale,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  glowColor.withValues(alpha: 0.22),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.92),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.28),
                  blurRadius: 28,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                size: size * 0.47,
                color: color,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _floatingSparkle({
  required double size,
  required Color color,
  required double dx,
  required double dy,
  required double phase,
}) {
  return AnimatedBuilder(
    animation: _introAnimationController,
    builder: (context, child) {
      final t = (_introAnimationController.value + phase) % 1.0;
      final wave = math.sin(t * math.pi * 2);
      final opacity = 0.35 + ((wave + 1) / 2) * 0.65;

      return Transform.translate(
        offset: Offset(dx, dy + wave * 11),
        child: Transform.rotate(
          angle: wave * 0.18,
          child: Opacity(
            opacity: opacity,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: size,
              color: color,
            ),
          ),
        ),
      );
    },
  );
}

Widget _pulseRing({
  required double size,
  required Color color,
}) {
  return AnimatedBuilder(
    animation: _introAnimationController,
    builder: (context, child) {
      final value = _introAnimationController.value;
      final scale = 0.90 + (value * 0.16);
      final opacity = 0.08 + ((1 - value) * 0.10);

      return Transform.scale(
        scale: scale,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: opacity),
              width: 2,
            ),
          ),
        ),
      );
    },
  );
}

Widget _introArtwork() {
  return SizedBox(
    height: 205,
    width: double.infinity,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Cahaya utama teal.
        AnimatedBuilder(
          animation: _introAnimationController,
          builder: (context, child) {
            final value = _introAnimationController.value;
            return Container(
              width: 178 + (value * 10),
              height: 178 + (value * 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF8DE8DC).withValues(alpha: 0.34),
                    const Color(0xFF8DE8DC).withValues(alpha: 0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            );
          },
        ),

        // Lingkaran pulse.
        Positioned(
          child: _pulseRing(
            size: 164,
            color: const Color(0xFF12AFA1),
          ),
        ),
        Positioned(
          child: _pulseRing(
            size: 132,
            color: const Color(0xFFF64F78),
          ),
        ),

        // Bentuk dekoratif teal.
        Positioned(
          right: 18,
          top: 20,
          child: Transform.rotate(
            angle: -0.16,
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFD4F6F0),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF12AFA1).withValues(alpha: 0.16),
                    blurRadius: 18,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 34,
                color: Color(0xFF0D9C90),
              ),
            ),
          ),
        ),

        // Heart utama.
        Positioned(
          left: 48,
          top: 45,
          child: _floatingMedicalIcon(
            icon: Icons.favorite_rounded,
            color: const Color(0xFFF64F78),
            glowColor: const Color(0xFFFF91AB),
            size: 96,
            dx: 0,
            dy: 0,
            phase: 0.0,
          ),
        ),

        // Shield kesehatan.
        Positioned(
          right: 54,
          bottom: 30,
          child: _floatingMedicalIcon(
            icon: Icons.health_and_safety_rounded,
            color: const Color(0xFF0E9D91),
            glowColor: const Color(0xFF65D8CC),
            size: 66,
            dx: 0,
            dy: 0,
            phase: 0.33,
          ),
        ),

        // Stethoscope kecil.
        Positioned(
          left: 12,
          bottom: 27,
          child: _floatingMedicalIcon(
            icon: Icons.medical_services_rounded,
            color: const Color(0xFF6257C7),
            glowColor: const Color(0xFFB3AAF1),
            size: 53,
            dx: 0,
            dy: 0,
            phase: 0.62,
          ),
        ),

        // Sparkles.
        Positioned(
          left: 27,
          top: 23,
          child: _floatingSparkle(
            size: 21,
            color: const Color(0xFFF3B53F),
            dx: 0,
            dy: 0,
            phase: 0.52,
          ),
        ),
        Positioned(
          right: 22,
          top: 92,
          child: _floatingSparkle(
            size: 18,
            color: const Color(0xFFF64F78),
            dx: 0,
            dy: 0,
            phase: 0.18,
          ),
        ),
        Positioned(
          left: 88,
          bottom: 11,
          child: _floatingSparkle(
            size: 15,
            color: const Color(0xFF12AFA1),
            dx: 0,
            dy: 0,
            phase: 0.78,
          ),
        ),
      ],
    ),
  );
}

Widget _buildScreeningIntro() {
  return Scaffold(
    backgroundColor: const Color(0xFFFFF8F2),
    body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 720;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol kembali.
                Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  elevation: 0,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    customBorder: const CircleBorder(),
                    child: const SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 17,
                        color: Color(0xFF343443),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Hero card.
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    wide ? 30 : 24,
                    27,
                    wide ? 30 : 24,
                    22,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFD9F8F2),
                        Color(0xFFEAF9F4),
                        Color(0xFFFFF2F6),
                        Color(0xFFFFF8F1),
                      ],
                      stops: [0.0, 0.40, 0.78, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.9),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF11AFA1).withValues(alpha: 0.10),
                        blurRadius: 30,
                        offset: const Offset(0, 14),
                      ),
                      BoxShadow(
                        color: const Color(0xFFF64F78).withValues(alpha: 0.07),
                        blurRadius: 26,
                        offset: const Offset(12, 8),
                      ),
                    ],
                  ),
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 6,
                              child: _introCopy(),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              flex: 4,
                              child: _introArtwork(),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _introCopy(),
                            const SizedBox(height: 4),
                            _introArtwork(),
                          ],
                        ),
                ),
                const SizedBox(height: 18),

                // Statistik dengan warna yang lebih hidup.
                Row(
                  children: [
                    Expanded(
                      child: _introStat(
                        icon: Icons.assignment_rounded,
                        value: '10',
                        label: 'PERTANYAAN',
                        color: const Color(0xFFF64F78),
                        background: const Color(0xFFFFE9EF),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _introStat(
                        icon: Icons.schedule_rounded,
                        value: '±3',
                        label: 'MENIT',
                        color: const Color(0xFF0E9D91),
                        background: const Color(0xFFE0F8F3),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _introStat(
                        icon: Icons.lock_rounded,
                        value: '100%',
                        label: 'RAHASIA',
                        color: const Color(0xFF6257C7),
                        background: const Color(0xFFECE9FF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                _introInfoItem(
                  icon: Icons.verified_rounded,
                  title: 'Berbasis panduan skrining',
                  description:
                      'Mengacu pada faktor yang digunakan untuk membantu menilai kondisi pengguna.',
                  color: const Color(0xFF0E9D91),
                  background: const Color(0xFFE1F8F3),
                ),
                const SizedBox(height: 12),
                _introInfoItem(
                  icon: Icons.favorite_rounded,
                  title: 'Bukan diagnosis',
                  description:
                      'Hasil merupakan informasi pendukung dan tetap memerlukan pemeriksaan tenaga kesehatan.',
                  color: const Color(0xFFF64F78),
                  background: const Color(0xFFFFEAF0),
                ),
                const SizedBox(height: 12),
                _introInfoItem(
                  icon: Icons.arrow_forward_rounded,
                  title: 'Membantu menentukan langkah lanjutan',
                  description:
                      'Hasil dapat menjadi informasi awal untuk pemantauan kondisi dan konsultasi lebih lanjut.',
                  color: const Color(0xFF6257C7),
                  background: const Color(0xFFECE9FF),
                ),
                const SizedBox(height: 15),

                // Privasi.
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE5FBF6),
                        Color(0xFFF0ECFF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shield_rounded,
                          color: Color(0xFF6257C7),
                          size: 21,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.45,
                              color: Color(0xFF51467D),
                            ),
                            children: [
                              TextSpan(
                                text: 'Jawabanmu bersifat pribadi. ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    'Data skrining digunakan untuk membantu proses penilaian kondisi pada aplikasi.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol utama.
                AnimatedBuilder(
                  animation: _introAnimationController,
                  builder: (context, child) {
                    final wave = math.sin(
                      _introAnimationController.value * math.pi * 2,
                    );
                    final glow = 0.14 + ((wave + 1) / 2) * 0.12;

                    return Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF64F78)
                                .withValues(alpha: glow),
                            blurRadius: 24,
                            spreadRadius: 1,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: startScreening,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF64F78),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Mulai Skrining',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(width: 9),
                            Transform.translate(
                              offset: Offset(4 + (wave * 2), 0),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

Widget _introCopy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF12AFA1).withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF12AFA1).withValues(alpha: 0.20),
          ),
        ),
        child: const Text(
          'SKRINING MANDIRI',
          style: TextStyle(
            color: Color(0xFF087F79),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.35,
          ),
        ),
      ),
      const SizedBox(height: 14),
      Text.rich(
        TextSpan(
          style: const TextStyle(
            fontSize: 28,
            height: 1.13,
            fontWeight: FontWeight.w800,
            color: Color(0xFF302344),
          ),
          children: [
            const TextSpan(text: 'Kenali kondisi '),
            const TextSpan(
              text: 'AIDS',
              style: TextStyle(color: Color(0xFFF64F78)),
            ),
            const TextSpan(
              text: '-mu,\nlangkah pertama untuk\npemantauan yang lebih baik',
            ),
          ],
        ),
      ),
      const SizedBox(height: 15),
      const Text(
        'Jawab 10 pertanyaan singkat seputar kondisi kesehatan, riwayat pengobatan, dan hasil pemeriksaan laboratorium.',
        style: TextStyle(
          fontSize: 14,
          height: 1.55,
          color: Color(0xFF625A73),
        ),
      ),
    ],
  );
}

Widget _introStat({
  required IconData icon,
  required String value,
  required String label,
  required Color color,
  required Color background,
}) {
  return Container(
    height: 94,
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: background,
        width: 1.3,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.08),
          blurRadius: 18,
          offset: const Offset(0, 7),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 17,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color,
            fontSize: 19,
            height: 1,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF85808E),
            fontSize: 8,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.25,
          ),
        ),
      ],
    ),
  );
}

Widget _introInfoItem({
  required IconData icon,
  required String title,
  required String description,
  required Color color,
  required Color background,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      horizontal: 13,
      vertical: 12,
    ),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.78),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: background.withValues(alpha: 0.95),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 35,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: color,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF343443),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 11.5,
                  height: 1.4,
                  color: Color(0xFF858592),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HALAMAN PERTANYAAN
// ============================================================
Widget _buildQuestion(int index) {
    final question = questions[index];
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
// Kartu pertanyaan
Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD9E2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '${index + 1}'.padLeft(2, '0'),
                    style: const TextStyle(
                      color: Color(0xFFF64F78),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
Text(
                  question['question'],
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF343443),
                  ),
                ),
                if (question['description'] != null) ...[
                  const SizedBox(height: 8),
Text(
                    question['description'],
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: Color(0xFF898A95),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
_buildAnswerArea(index, question),
        ],
      ),
    );
  }
Widget _buildAnswerArea(
int index,
Map<String, dynamic> question,
  ) {
    final type = question['type'];
    if (type == 'number') {
      final controller =
          index == 0 ? ageController : weightController;
      return TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          answers[index] = value;
        },
        decoration: InputDecoration(
          hintText: question['hint'],
          filled: true,
          fillColor: Colors.white,
          suffixText: index == 1 ? 'kg' : 'tahun',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(
              color: Color(0xFFE8E2DD),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(
              color: Color(0xFFE8E2DD),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(
              color: Color(0xFFF64F78),
              width: 1.5,
            ),
          ),
        ),
      );
    }
    if (type == 'number_or_unknown') {
      return Column(
        children: [
TextField(
            controller: cd8Controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.trim().isNotEmpty) {
                answers[index] = value;
              }
            },
            decoration: InputDecoration(
              hintText: question['hint'],
              suffixText: 'cells/µL',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(
                  color: Color(0xFFE8E2DD),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(
                  color: Color(0xFFE8E2DD),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: const BorderSide(
                  color: Color(0xFFF64F78),
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
_buildChoice(
            index,
            'Saya tidak tahu / Belum pernah tes CD8',
            'unknown',
          ),
        ],
      );
    }
    final options = question['options'] as List<String>;
    return Column(
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 11),
          child: _buildChoice(
            index,
            option,
            option,
          ),
        );
      }).toList(),
    );
  }
Widget _buildChoice(
int index,
String title,
dynamic value,
  ) {
    final selected = answers[index] == value;
    return InkWell(
      onTap: () {
setState(() {
          answers[index] = value;
          if (index == 7 && value == 'unknown') {
            cd8Controller.clear();
          }
        });
      },
      borderRadius: BorderRadius.circular(17),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: selected
                ? const Color(0xFFF64F78)
                : const Color(0xFFE8E2DD),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
Container(
              width: 21,
              height: 21,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xFFF64F78)
                      : const Color(0xFFE3DDD8),
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF64F78),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 13),
Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: Color(0xFF39394A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
// ============================================================
// HALAMAN UTAMA
// ============================================================
  @override
Widget build(BuildContext context) {
// Kalau belum menekan "Mulai Skrining",*
// tampilkan halaman pembuka.*
    if (!hasStarted) {
      return _buildScreeningIntro();
    }
    final progress =
        (currentQuestion + 1) / questions.length;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F1),
      body: SafeArea(
        child: Column(
          children: [
// Header*
Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                15,
                20,
                0,
              ),
              child: Column(
                children: [
Row(
                    children: [
InkWell(
                        onTap: previousQuestion,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 42,
                          height: 42,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
Icons.arrow_back_ios_new,
                            size: 17,
                            color: Color(0xFF343443),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
CrossAxisAlignment.start,
                          children: [
Text(
                              'Skrining AIDS',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF343443),
                              ),
                            ),
SizedBox(height: 3),
Text(
                              'Jawab dengan jujur ya',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8A8994),
                              ),
                            ),
                          ],
                        ),
                      ),
TextButton(
                        onPressed: () {},
                        child: const Text(
                          'RIWAYAT TES',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8A8994),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
// Progress bar*
Row(
                    children: [
Expanded(
                        child: ClipRRect(
                          borderRadius:
BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor:
                                const Color(0xFFEDE5DD),
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
Color(0xFFF64F78),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
Row(
                    mainAxisAlignment:
MainAxisAlignment.spaceBetween,
                    children: [
Text(
                        'Pertanyaan ${currentQuestion + 1}/10',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF898A95),
                        ),
                      ),
                      const Text(
                        'SKRINING AIDS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF898A95),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
// Pertanyaan*
Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                onPageChanged: (index) {
setState(() {
                    currentQuestion = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildQuestion(index);
                },
              ),
            ),
// Tombol bawah*
Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                15,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8F1),
              ),
              child: Row(
                children: [
Container(
                    width: 55,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
BorderRadius.circular(17),
                      border: Border.all(
                        color: const Color(0xFFE8E2DD),
                      ),
                    ),
                    child: IconButton(
                      onPressed: previousQuestion,
                      icon: const Icon(
Icons.chevron_left,
                        color: Color(0xFF343443),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFF64F78),
                          elevation: 0,
                          shape:
RoundedRectangleBorder(
                            borderRadius:
BorderRadius.circular(17),
                          ),
                        ),
                        child: Text(
                          currentQuestion ==
                                  questions.length - 1
                              ? 'Selesai'
                              : 'Lanjut',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
