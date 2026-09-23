import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FasyankesPasienPage extends StatefulWidget {
  const FasyankesPasienPage({super.key});

  @override
  State<FasyankesPasienPage> createState() => _FasyankesPasienPageState();
}

class _FasyankesItem {
  final String name;
  final String distance;
  final String address;
  final String badge;
  final String category;
  final Color iconBg;
  final Color iconColor;
  final Color badgeBg;
  final Color badgeColor;
  final String phone;

  const _FasyankesItem({
    required this.name,
    required this.distance,
    required this.address,
    required this.badge,
    required this.category,
    required this.iconBg,
    required this.iconColor,
    required this.badgeBg,
    required this.badgeColor,
    required this.phone,
  });
}

class _FasyankesPasienPageState extends State<FasyankesPasienPage> {
  static const Color bgCream = Color(0xFFFAF6F0);
  static const Color textDark = Color(0xFF272134);
  static const Color textMuted = Color(0xFF8C8698);
  static const Color pink = Color(0xFFF64F78);

  String selectedFilter = 'Semua';

  final List<String> filters = const [
    'Semua',
    'Puskesmas',
    'Rumah Sakit',
    'Klinik',
  ];

  final List<_FasyankesItem> fasyankesList = const [
    _FasyankesItem(
      name: 'Puskesmas Sumbersari',
      distance: '1.2 km',
      address: 'Jl. Jawa No. 12, Jember',
      badge: 'Layanan VCT Gratis',
      category: 'Puskesmas',
      iconBg: Color(0xFFE2F6F3),
      iconColor: Color(0xFF33AC9E),
      badgeBg: Color(0xFFE2F6F3),
      badgeColor: Color(0xFF1FA495),
      phone: '08123456789',
    ),
    _FasyankesItem(
      name: 'RSUD dr. Soebandi',
      distance: '2.8 km',
      address: 'Jl. dr. Soebandi, Jember',
      badge: 'Klinik VCT & ARV',
      category: 'Rumah Sakit',
      iconBg: Color(0xFFFDECEF),
      iconColor: Color(0xFFF64F78),
      badgeBg: Color(0xFFECEAFC),
      badgeColor: Color(0xFF6257C7),
      phone: '08123456789',
    ),
    _FasyankesItem(
      name: 'Klinik Kasih Sahabat',
      distance: '3.5 km',
      address: 'Jl. Kalimantan, Sumbersari',
      badge: 'Konseling Anonim',
      category: 'Klinik',
      iconBg: Color(0xFFE8E7FA),
      iconColor: Color(0xFF6257C7),
      badgeBg: Color(0xFFFEF3D6),
      badgeColor: Color(0xFFC97A1E),
      phone: '08123456789',
    ),
  ];

  List<_FasyankesItem> get filteredList {
    if (selectedFilter == 'Semua') {
      return fasyankesList;
    }
    return fasyankesList.where((item) => item.category == selectedFilter).toList();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak dapat membuka panggilan telepon: $phoneNumber')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Menghubungi: $phoneNumber')),
      );
    }
  }

  Future<void> _openMapRoute(String name, String address) async {
    final String query = '$name, $address';
    final Uri mapUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}',
    );
    try {
      if (await canLaunchUrl(mapUri)) {
        await launchUrl(mapUri, mode: LaunchMode.externalApplication);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Membuka rute ke $name')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Membuka rute ke $name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCream,
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 42,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                          color: textDark,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Fasyankes Terdekat',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Layanan tes & konseling HIV',
                        style: TextStyle(
                          fontSize: 12,
                          color: textMuted,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // ================= BANNER LOKASI =================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFD6EFE9),
                              Color(0xFFDFDCF7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Ilustrasi garis gelombang
                              CustomPaint(
                                size: const Size(double.infinity, 140),
                                painter: _WaveLinesPainter(),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: pink.withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.location_on_rounded,
                                      color: pink,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.85),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.2,
                                      ),
                                    ),
                                    child: const Text(
                                      'Lokasimu • Jember, Jawa Timur',
                                      style: TextStyle(
                                        color: Color(0xFF1E6F65),
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ================= CHOICE CHIPS FILTER =================
                    SizedBox(
                      height: 44,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filters.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final filter = filters[index];
                          final bool isSelected = selectedFilter == filter;

                          return ChoiceChip(
                            label: Text(filter),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              if (selected) {
                                setState(() {
                                  selectedFilter = filter;
                                });
                              }
                            },
                            selectedColor: textDark,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF524860),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? Colors.transparent
                                    : const Color(0xFFEDE5DC),
                                width: 1.2,
                              ),
                            ),
                            showCheckmark: false,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ================= LIST KARTU FASYANKES =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: filteredList
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: _buildFasyankesCard(item),
                                ))
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFasyankesCard(_FasyankesItem item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: item.iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 22,
                  color: item.iconColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '📍 ${item.distance} · ${item.address}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: textMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: item.badgeBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item.badge,
                        style: TextStyle(
                          color: item.badgeColor,
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

          const SizedBox(height: 16),

          // Tombol Rute & Telepon
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: OutlinedButton(
                    onPressed: () => _openMapRoute(item.name, item.address),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFE5DDD5),
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Rute',
                      style: TextStyle(
                        color: textDark,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () => _makePhoneCall(item.phone),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pink,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Telepon',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= PAINTER GELOMBANG LOKASI =================
class _WaveLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF6257C7).withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final paint2 = Paint()
      ..color = const Color(0xFF33AC9E).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.35);
    path1.cubicTo(
      size.width * 0.35,
      size.height * 0.15,
      size.width * 0.65,
      size.height * 0.60,
      size.width,
      size.height * 0.30,
    );

    final path2 = Path();
    path2.moveTo(0, size.height * 0.55);
    path2.cubicTo(
      size.width * 0.3,
      size.height * 0.70,
      size.width * 0.7,
      size.height * 0.40,
      size.width,
      size.height * 0.65,
    );

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

