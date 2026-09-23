import 'package:flutter/material.dart';

class KonsultasiPengajuanPage extends StatelessWidget {
  final String doctorName;
  final String doctorSpecialist;
  final String doctorInitials;

  const KonsultasiPengajuanPage({
    super.key,
    required this.doctorName,
    required this.doctorSpecialist,
    required this.doctorInitials,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F2),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8F2),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Color(0xFF33284A),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7AD8CC),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Center(
                      child: Text(
                        doctorInitials,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF33284A),
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: Color(0xFF19B59B),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Menunggu persetujuan dokter',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF19B59B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 25, 18, 30),
                child: Column(
                  children: [
                    // ICON WAITING
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE8ED),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 62,
                          height: 62,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFD5DF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.access_time,
                            color: Color(0xFFF64F78),
                            size: 34,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Menunggu Persetujuan Dokter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF33284A),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Permintaan konsultasimu sudah terkirim ke '
                      '$doctorName. Kamu akan diberi tahu begitu '
                      'dokter menerima permintaan ini.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Color(0xFF675B78),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // STATUS CARD
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _statusRow(
                            'Status',
                            'Menunggu ACC',
                            valueColor: const Color(0xFFF0A12B),
                            valueBackground: const Color(0xFFFFF0D2),
                          ),
                          _statusDivider(),
                          _statusRow(
                            'Diajukan',
                            'Baru saja',
                          ),
                          _statusDivider(),
                          _statusRow(
                            'Terkait hasil skrining',
                            'Risiko Rendah · 18%',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // INFO
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAE3FF),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.shield_outlined,
                            size: 21,
                            color: Color(0xFF6257C7),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.5,
                                  color: Color(0xFF51466D),
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Setelah disetujui, dokter yang akan '
                                        'menghubungimu lebih dulu lewat WhatsApp — '
                                        'kamu tidak perlu mengirim pesan dahulu.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // CANCEL
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0xFFE9DCCF),
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Batalkan Permintaan',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF33284A),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // DEMO BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 68,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Simulasi: Dokter menerima permintaan konsultasi.',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE7DEFF),
                          foregroundColor: const Color(0xFF8172E8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34),
                          ),
                        ),
                        child: const Text(
                          '🔔 Simulasikan: Dokter Menerima\n(demo)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusRow(
    String title,
    String value, {
    Color? valueColor,
    Color? valueBackground,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 15,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF8A7D96),
              ),
            ),
          ),
          if (valueBackground != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: valueBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
              ),
            )
          else
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF33284A),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statusDivider() {
    return const Divider(
      height: 1,
      color: Color(0xFFF0E6DD),
    );
  }
}