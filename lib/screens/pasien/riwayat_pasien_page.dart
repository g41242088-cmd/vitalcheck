import 'package:flutter/material.dart';

class RiwayatPasienPage extends StatelessWidget {
  const RiwayatPasienPage({super.key});

  static const Color bgCream = Color(0xFFFAF6F0);
  static const Color textDark = Color(0xFF272134);
  static const Color textMuted = Color(0xFF8C8698);

  final List<Map<String, dynamic>> riwayatList = const [
    {
      'day': '12',
      'month': 'AGU',
      'title': 'Skrining Mandiri',
      'risiko': 'Rendah',
      'skor': '18%',
      'isRendah': true,
    },
    {
      'day': '02',
      'month': 'MEI',
      'title': 'Skrining Mandiri',
      'risiko': 'Sedang',
      'skor': '46%',
      'isRendah': false,
    },
    {
      'day': '19',
      'month': 'JAN',
      'title': 'Skrining Mandiri',
      'risiko': 'Rendah',
      'skor': '12%',
      'isRendah': true,
    },
    {
      'day': '30',
      'month': 'SEP',
      'title': 'Skrining Mandiri',
      'risiko': 'Rendah',
      'skor': '15%',
      'isRendah': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCream,
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
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
                        'Riwayat Skrining',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '4 hasil tersimpan',
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

            const SizedBox(height: 8),

            // ================= LIST KARTU =================
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                itemCount: riwayatList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = riwayatList[index];
                  return _buildCard(context, item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> item) {
    final bool isRendah = item['isRendah'] as bool;
    final Color badgeBg =
        isRendah ? const Color(0xFFE3F5EC) : const Color(0xFFFFF1D6);
    final Color badgeText =
        isRendah ? const Color(0xFF469A72) : const Color(0xFFD9822B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Tanggal
          SizedBox(
            width: 38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item['day'],
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                    height: 1.1,
                  ),
                ),
                Text(
                  item['month'],
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: textMuted,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Info Skrining
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Risiko ${item['risiko']} · Skor ${item['skor']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Badge Risiko
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              item['risiko'],
              style: TextStyle(
                color: badgeText,
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Tombol Download
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Mengunduh hasil skrining ${item['day']} ${item['month']}...',
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F2ED),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.file_download_outlined,
                size: 19,
                color: Color(0xFF383144),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

