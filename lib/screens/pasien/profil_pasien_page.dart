import 'package:flutter/material.dart';

import 'login_page.dart';
import 'data_diri_pasien_page.dart';
import 'riwayat_pasien_page.dart';
import '../privasi_keamanan_pasien_page.dart';

class ProfilPasienPage extends StatefulWidget {
  final bool isEmbedded;

  const ProfilPasienPage({super.key, this.isEmbedded = true});

  @override
  State<ProfilPasienPage> createState() => _ProfilPasienPageState();
}

class _ProfilPasienPageState extends State<ProfilPasienPage> {
  static const Color pink = Color(0xFFF64F78);
  static const Color purpleStart = Color(0xFFB8AEF9);
  static const Color purpleEnd = Color(0xFF8676F3);
  static const Color bgCream = Color(0xFFFAF6F0);
  static const Color textDark = Color(0xFF272134);
  static const Color textMuted = Color(0xFF8C8698);
  static const Color iconBg = Color(0xFFFDF0EC);
  static const Color dividerColor = Color(0xFFF5EFEB);

  String selectedLanguage = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      color: bgCream,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 22),

              // ================= AVATAR =================
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: const LinearGradient(
                    colors: [
                      purpleStart,
                      purpleEnd,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: purpleEnd.withValues(alpha: 0.28),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'D',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ================= NAMA & EMAIL =================
              const Text(
                'Dinda Putri',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'dinda.putri@email.com',
                style: TextStyle(
                  fontSize: 13,
                  color: textMuted,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 24),

              // ================= KARTU STATISTIK =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _statCard(
                      value: '4',
                      label: 'SKRINING',
                    ),
                    const SizedBox(width: 10),
                    _statCard(
                      value: '2',
                      label: 'KONSULTASI',
                    ),
                    const SizedBox(width: 10),
                    _statCard(
                      value: '18%',
                      label: 'RISIKO TERKINI',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ================= MENU UTAMA =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
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
                    children: [
                      // DATA DIRI
                      _menuTile(
                        icon: Icons.person_outline_rounded,
                        title: 'Data Diri',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DataDiriPasienPage(),
                            ),
                          );
                        },
                      ),

                      _menuDivider(),

                      // RIWAYAT SKRINING
                      _menuTile(
                        icon: Icons.history_rounded,
                        title: 'Riwayat Skrining',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RiwayatPasienPage(),
                            ),
                          );
                        },
                      ),

                      _menuDivider(),

                      // PRIVASI & KEAMANAN
                      _menuTile(
                        icon: Icons.shield_outlined,
                        title: 'Privasi & Keamanan',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PrivasiKeamananPasienPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ================= MENU BAHASA =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
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
                  child: _menuTile(
                    icon: Icons.language_rounded,
                    title: 'Bahasa',
                    trailing: Text(
                      selectedLanguage,
                      style: const TextStyle(
                        fontSize: 13,
                        color: textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () => _showLanguagePicker(context),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ================= MENU KELUAR =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
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
                  child: _menuTile(
                    icon: Icons.logout_rounded,
                    title: 'Keluar',
                    iconBoxColor: const Color(0xFFFDF0EC),
                    iconColor: pink,
                    textColor: pink,
                    trailing: const SizedBox.shrink(),
                    onTap: () => _showLogoutDialog(context),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ================= FOOTER VERSI =================
              const Center(
                child: Text(
                  'VitalCheck v1.4.0',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFFAFA7B8),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ),

              const SizedBox(height: 28),
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

  // ================= STAT CARD =================
  Widget _statCard({
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: pink,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: textMuted,
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= MENU TILE =================
  Widget _menuTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    Color iconBoxColor = iconBg,
    Color iconColor = const Color(0xFF383144),
    Color textColor = textDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBoxColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),

              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9E98A8),
                    size: 22,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= DIVIDER =================
  Widget _menuDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        thickness: 1,
        color: dividerColor,
      ),
    );
  }

  // ================= LANGUAGE =================
  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Bahasa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),

                const SizedBox(height: 16),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.language,
                    color: textDark,
                  ),
                  title: const Text('Indonesia'),
                  trailing: selectedLanguage == 'Indonesia'
                      ? const Icon(
                          Icons.check,
                          color: pink,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'Indonesia';
                    });

                    Navigator.pop(sheetContext);
                  },
                ),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.language,
                    color: textDark,
                  ),
                  title: const Text('English'),
                  trailing: selectedLanguage == 'English'
                      ? const Icon(
                          Icons.check,
                          color: pink,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'English';
                    });

                    Navigator.pop(sheetContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= LOGOUT =================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Konfirmasi Keluar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          content: const Text(
            'Apakah Anda yakin ingin keluar dari akun Anda?',
            style: TextStyle(
              fontSize: 14,
              color: textMuted,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            16,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pink,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                'Keluar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}