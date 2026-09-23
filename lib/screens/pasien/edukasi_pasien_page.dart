import 'package:flutter/material.dart';

class EdukasiPasienPage extends StatefulWidget {
  final bool isEmbedded;
  const EdukasiPasienPage({super.key, this.isEmbedded = true});

  @override
  State<EdukasiPasienPage> createState() => _EdukasiPasienPageState();
}

class _ArticleItem {
  final String title;
  final String category;
  final String readTime;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String content;

  const _ArticleItem({
    required this.title,
    required this.category,
    required this.readTime,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.content,
  });
}

class _EdukasiPasienPageState extends State<EdukasiPasienPage> {
  static const Color bgCream = Color(0xFFFAF6F0);
  static const Color textDark = Color(0xFF272134);
  static const Color textMuted = Color(0xFF8C8698);
  static const Color purpleStart = Color(0xFF7265EE);
  static const Color purpleEnd = Color(0xFF5546CE);
  static const Color pink = Color(0xFFF64F78);

  String selectedCategory = 'Semua';

  final List<String> categories = const [
    'Semua',
    'Pencegahan',
    'Pengobatan',
    'Mitos & Fakta',
  ];

  final List<_ArticleItem> articles = const [
    _ArticleItem(
      title: '7 mitos HIV yang harus kamu tinggalkan',
      category: 'Mitos & Fakta',
      readTime: '4 menit baca',
      icon: Icons.location_on_outlined,
      iconColor: Color(0xFFF64F78),
      iconBgColor: Color(0xFFFDECEF),
      content:
          'Banyak mitos seputar penularan HIV yang masih beredar di masyarakat, seperti penularan melalui gigitan nyamuk, alat makan bersama, atau pelukan. Faktanya, HIV hanya menular melalui cairan tubuh tertentu seperti darah, sperma, cairan vagina, dan ASI. Menghilangkan stigma dimulai dari pemahaman yang benar.',
    ),
    _ArticleItem(
      title: 'Mengenal PrEP untuk pencegahan',
      category: 'Pencegahan',
      readTime: '5 menit baca',
      icon: Icons.article_outlined,
      iconColor: Color(0xFF33AC9E),
      iconBgColor: Color(0xFFE2F6F3),
      content:
          'PrEP (Pre-Exposure Prophylaxis) adalah obat yang dikonsumsi oleh orang berisiko sebelum terpapar HIV untuk mencegah infeksi. Jika diminum secara konsisten setiap hari, PrEP terbukti efektif hingga lebih dari 90% dalam mencegah penularan HIV.',
    ),
    _ArticleItem(
      title: 'ARV: hidup normal bersama HIV',
      category: 'Pengobatan',
      readTime: '6 menit baca',
      icon: Icons.swap_vert_rounded,
      iconColor: Color(0xFF7A6CE5),
      iconBgColor: Color(0xFFECEAFC),
      content:
          'Antiretroviral (ARV) adalah terapi pengobatan yang menekan jumlah virus HIV dalam tubuh hingga tingkat tidak terdeteksi (undetectable = untransmittable / U=U). Dengan kepatuhan minum obat secara rutin, orang dengan HIV dapat hidup sehat, produktif, dan memiliki angka harapan hidup sama seperti orang lainnya.',
    ),
    _ArticleItem(
      title: 'Cara bicara aman dengan pasangan',
      category: 'Pencegahan',
      readTime: '3 menit baca',
      icon: Icons.favorite_border_rounded,
      iconColor: Color(0xFFE3A638),
      iconBgColor: Color(0xFFFDF4E5),
      content:
          'Membicarakan status kesehatan reproduksi dan skrining HIV bersama pasangan memerlukan keterbukaan, rasa saling percaya, dan empati tanpa menghakimi. Lakukan skrining bersama sebagai bentuk kepedulian dan perlindungan satu sama lain.',
    ),
  ];

  List<_ArticleItem> get filteredArticles {
    if (selectedCategory == 'Semua') {
      return articles;
    }
    return articles.where((a) => a.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      color: bgCream,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ================= HEADER =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Edukasi HIV',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pahami, cegah, dan lindungi',
                      style: TextStyle(
                        fontSize: 13,
                        color: textMuted,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ================= BANNER ARTIKEL PILIHAN =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 154,
                  padding: const EdgeInsets.fromLTRB(20, 18, 16, 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        purpleStart,
                        purpleEnd,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: purpleEnd.withValues(alpha: 0.28),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Ilustrasi ECG / Pulse di pojok kanan bawah
                      Positioned(
                        right: 4,
                        bottom: 8,
                        child: CustomPaint(
                          size: const Size(82, 34),
                          painter: _PulseWavePainter(),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ARTIKEL PILIHAN',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Informasi akurat,\ntanpa stigma',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              height: 1.18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Kumpulan bacaan seputar\npencegahan, pengobatan, dan fakta\nHIV/AIDS.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 11.5,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= FILTER CATEGORY CHIPS =================
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final bool isSelected = selectedCategory == category;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? textDark : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? null
                              : Border.all(
                                  color: const Color(0xFFEDE5DC),
                                  width: 1.2,
                                ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.12),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF524860),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ================= LIST ARTIKEL =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: filteredArticles
                      .map((article) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _articleCard(context, article),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );

    if (widget.isEmbedded) {
      return content;
    }

    return Scaffold(
      backgroundColor: bgCream,
      body: content,
    );
  }

  // ================= ARTICLE CARD =================
  Widget _articleCard(BuildContext context, _ArticleItem article) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showArticleDetail(context, article),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.025),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: article.iconBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  article.icon,
                  size: 22,
                  color: article.iconColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${article.category} · ${article.readTime}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: textMuted,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= MODAL DETAIL BACAAN =================
  void _showArticleDetail(BuildContext context, _ArticleItem article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.85,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: article.iconBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          article.category,
                          style: TextStyle(
                            color: article.iconColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article.readTime,
                        style: const TextStyle(
                          color: textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    article.content,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF453E52),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pink,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Tutup',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ================= CUSTOM PAINTER PULSE WAVE =================
class _PulseWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final h = size.height;
    final w = size.width;

    path.moveTo(0, h * 0.55);
    path.lineTo(w * 0.28, h * 0.55);
    path.lineTo(w * 0.38, h * 0.15); // Peak up
    path.lineTo(w * 0.52, h * 0.88); // Peak down
    path.lineTo(w * 0.64, h * 0.35); // Small up
    path.lineTo(w * 0.72, h * 0.55);
    path.lineTo(w, h * 0.55); // Straight line to end

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

