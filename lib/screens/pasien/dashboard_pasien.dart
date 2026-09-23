import 'package:flutter/material.dart';
import 'edukasi_pasien_page.dart';
import 'fasyankes_pasien_page.dart';
import 'profil_pasien_page.dart';
import 'riwayat_pasien_page.dart';
import 'skrining_pasien_page.dart';
import 'konsultasi_pengajuan_page.dart';

class DashboardPasien extends StatefulWidget {
  final int initialIndex;
  const DashboardPasien({super.key, this.initialIndex = 0});

  @override
  State<DashboardPasien> createState() => _DashboardPasienState();
}

class _DashboardPasienState extends State<DashboardPasien> {
  late int selectedIndex;

  final Color pink = const Color(0xFFF64F78);
  final Color purple = const Color(0xFF6257C7);

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (selectedIndex == 3 || selectedIndex == 4)
          ? const Color(0xFFFAF6F0)
          : const Color(0xFFF8F5F1),
      body: _buildBody(),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 72,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xFFEDE9E5),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _bottomItem(Icons.home_outlined, 'Beranda', 0),
              _bottomItem(Icons.fact_check_outlined, 'Skrining', 1),
              _bottomItem(Icons.more_horiz, 'Konsultasi', 2),
              _bottomItem(Icons.menu_book_outlined, 'Edukasi', 3),
              _bottomItem(Icons.person_outline, 'Profil', 4),
            ],
          ),
        ),
      ),
    );
  }

 Widget _buildBody() {
  switch (selectedIndex) {
    case 0:
      return _buildDashboardContent();

      case 1:
  return const SkriningPasienPage();
      
       case 2:
      return _buildKonsultasiContent();

    case 3:
      return const EdukasiPasienPage(isEmbedded: true);

    case 4:
      return const ProfilPasienPage(isEmbedded: true);

    default:
      return _buildPlaceholder();
  }
}


  Widget _buildPlaceholder() {
    final titles = ['Beranda', 'Skrining', 'Konsultasi', 'Edukasi', 'Profil'];
    final title = (selectedIndex >= 0 && selectedIndex < titles.length)
        ? titles[selectedIndex]
        : 'Halaman';
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction_rounded,
                size: 52,
                color: pink.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 16),
              Text(
                'Fitur $title Segera Hadir',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF343443),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Halaman ini sedang dalam proses pengembangan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF7B7C89),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: pink,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Kembali ke Beranda',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              decoration: BoxDecoration(
                color: pink,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SELAMAT SIANG',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Halo, Dinda 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 4;
                          });
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            'D',
                            style: TextStyle(
                              color: purple,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // STATUS SKRINING
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white54,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'STATUS SKRINING TERAKHIR',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Risiko Rendah · 18 Agu 2026',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F5EC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Aman',
                            style: TextStyle(
                              color: Color(0xFF469A72),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

           // ================= MENU =================
Transform.translate(
  offset: const Offset(0, -12),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _menuItem(
          icon: Icons.fact_check_outlined,
          title: 'Skrining',
          color: const Color(0xFFF4C7D2),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SkriningPasienPage(),
              ),
            );
          },
        ),

        _menuItem(
          icon: Icons.history,
          title: 'Riwayat',
          color: const Color(0xFFD8D6F2),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RiwayatPasienPage(),
              ),
            );
          },
        ),

        _menuItem(
          icon: Icons.location_on_outlined,
          title: 'Fasyankes',
          color: const Color(0xFFCDE8E7),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FasyankesPasienPage(),
              ),
            );
          },
        ),

        _menuItem(
          icon: Icons.more_horiz,
          title: 'Konsultasi',
          color: const Color(0xFFF4E5C8),
          onTap: () {
            setState(() {
              selectedIndex = 2;
            });
          },
        ),
      ],
    ),
  ),
),

            // ================= KONTEN =================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BANNER SKRINING
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SkriningPasienPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 136,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7770D4),
                          Color(0xFF5C52BA),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -25,
                          top: -35,
                          child: Container(
                            width: 105,
                            height: 105,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.10),
                            ),
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '15 PERTANYAAN · 3 MENIT',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              'Yuk, cek risikomu hari\nini',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                height: 1.15,
                              ),
                            ),

                            const Spacer(),

                            const Text(
                              'Cepat, privat, dan hasilnya langsung\nkeluar',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                  // ================= DOKTER =================
                 _sectionTitle(
  'Dokter tersedia',
  onSeeAll: () {
    setState(() {
      selectedIndex = 2;
    });
  },
),

                  const SizedBox(height: 12),

                  _doctorCard(
                    initials: 'AR',
                    initialsColor: const Color(0xFF9BD6D0),
                    name: 'dr. Amira Ramadhani,\nSp.PD',
                    info: '⭐ 4.9 · Online sekarang',
                    status: 'Siap',
                    statusColor: const Color(0xFFDDF1E7),
                  ),

                  const SizedBox(height: 10),

                  _doctorCard(
                    initials: 'FH',
                    initialsColor: const Color(0xFFB5AFE8),
                    name: 'dr. Farah Hutagalung',
                    info: '⭐ 4.8 · Spesialis VCT',
                    status: '14:30',
                    statusColor: const Color(0xFFE4E2F4),
                  ),

                  const SizedBox(height: 20),

                  // ================= EDUKASI =================
                  _sectionTitle(
                    'Edukasi pilihan',
                    onSeeAll: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 120,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 3;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3CDD5),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Color(0xFFF45C7B),
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 3;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFCDE5E5),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.menu_book_outlined,
                                  color: Color(0xFF559A9B),
                                  size: 32,
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
          ],
        ),
      ),
    );
  }
Widget _buildKonsultasiContent() {
  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Konsultasi Dokter',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF343443),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '6 dokter tersedia hari ini',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF7B7C89),
            ),
          ),
          const SizedBox(height: 22),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _consultationFilter('Semua', true),
                _consultationFilter('Sp. Penyakit Dalam', false),
                _consultationFilter('Konselor VCT', false),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Dokter tersedia',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF343443),
            ),
          ),

          const SizedBox(height: 12),

          _consultationDoctorCard(
            context: context,
            initials: 'AR',
            name: 'dr. Amira Ramadhani, Sp.PD',
            specialist: 'Spesialis Penyakit Dalam',
            rating: '4.9',
            experience: '8 tahun pengalaman',
            online: true,
          ),

          const SizedBox(height: 12),

          _consultationDoctorCard(
            context: context,
            initials: 'FH',
            name: 'dr. Farah Hutagalung',
            specialist: 'Konselor VCT',
            rating: '4.8',
            experience: '6 tahun pengalaman',
            online: true,
          ),

          const SizedBox(height: 12),

          _consultationDoctorCard(
            context: context,
            initials: 'NA',
            name: 'dr. Nadia Anindita',
            specialist: 'Spesialis Penyakit Dalam',
            rating: '4.8',
            experience: '7 tahun pengalaman',
            online: false,
          ),

          const SizedBox(height: 12),

          _consultationDoctorCard(
            context: context,
            initials: 'RS',
            name: 'dr. Raka Saputra',
            specialist: 'Konselor VCT',
            rating: '4.7',
            experience: '5 tahun pengalaman',
            online: false,
          ),
        ],
      ),
    ),
  );
}

Widget _consultationFilter(String title, bool active) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
    decoration: BoxDecoration(
      color: active ? pink : Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: active
            ? pink
            : const Color(0xFFE4E1DD),
      ),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: active
            ? Colors.white
            : const Color(0xFF656676),
      ),
    ),
  );
}

Widget _consultationDoctorCard({
  required BuildContext context,
  required String initials,
  required String name,
  required String specialist,
  required String rating,
  required String experience,
  required bool online,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(21),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 13,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: online
                    ? const Color(0xFFB5AFE8)
                    : const Color(0xFFCDE5E5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF454657),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    specialist,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF7B7C89),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Text(
                        '★ $rating',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8A7A42),
                        ),
                      ),

                      const SizedBox(width: 7),

                      Text(
                        '• $experience',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF898A95),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 13),

        SizedBox(
  width: double.infinity,
  height: 40,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KonsultasiPengajuanPage(
            doctorName: name,
            doctorSpecialist: specialist,
            doctorInitials: initials,
          ),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: pink,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
    ),
            child: Text(
              online ? 'Ajukan Konsultasi' : 'Lihat Jadwal',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
  // ================= MENU ITEM =================
  Widget _menuItem({
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 76,
        height: 82,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 21,
              color: const Color(0xFF667085),
            ),
          ),

          const SizedBox(height: 7),

          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF555969),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

  // ================= JUDUL SECTION =================
  Widget _sectionTitle(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Color(0xFF343443),
          ),
        ),

        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            'Lihat semua',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: pink,
            ),
          ),
        ),
      ],
    );
  }

  // ================= DOCTOR CARD =================
  Widget _doctorCard({
    required String initials,
    required Color initialsColor,
    required String name,
    required String info,
    required String status,
    required Color statusColor,
  }) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              name.replaceAll('\n', ' '),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF272134),
              ),
            ),
            content: const Text(
              'Hubungi dokter melalui fitur konsultasi.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF554D60),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(
                  'Tutup',
                  style: TextStyle(
                    color: Color(0xFFF64F78),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 13,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 51,
              height: 51,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: initialsColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF454657),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    info,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF7B7C89),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: purple,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= BOTTOM NAV ITEM =================
  Widget _bottomItem(
    IconData icon,
    String title,
    int index,
  ) {
    final bool active = selectedIndex == index;

   return GestureDetector(
  onTap: () {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SkriningPasienPage(),
        ),
      );
      return;
    }

    setState(() {
      selectedIndex = index;
    });
  },

  child: SizedBox(
    width: 65,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 23,
          color: active
              ? pink
              : const Color(0xFF8B8D99),
        ),

        const SizedBox(height: 4),

        Text(
          title,
          style: TextStyle(
            fontSize: 9,
            fontWeight: active
                ? FontWeight.bold
                : FontWeight.w500,
            color: active
                ? pink
                : const Color(0xFF8B8D99),
          ),
        ),

        const SizedBox(height: 3),

              Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active
              ? pink
              : Colors.transparent,
        ),
      ),
    ],
  ),
),
);
  }
}