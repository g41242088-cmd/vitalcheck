import 'package:flutter/material.dart';

class PrivasiKeamananPasienPage extends StatefulWidget {
  const PrivasiKeamananPasienPage({super.key});

  @override
  State<PrivasiKeamananPasienPage> createState() =>
      _PrivasiKeamananPasienPageState();
}

class _PrivasiKeamananPasienPageState
    extends State<PrivasiKeamananPasienPage> {
  static const Color pink = Color(0xFFF64F78);
  static const Color purple = Color(0xFF8676F3);
  static const Color bgCream = Color(0xFFFAF6F0);
  static const Color textDark = Color(0xFF272134);
  static const Color textMuted = Color(0xFF8C8698);

  bool kunciAplikasi = true;
  bool biometrik = true;
  bool sembunyikanNotifikasi = true;
  bool bagikanData = false;
  bool hapusOtomatis = false;

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _ubahKunciAplikasi(bool value) {
    setState(() {
      kunciAplikasi = value;
    });

    _tampilkanPesan(
      value
          ? 'Kunci aplikasi diaktifkan'
          : 'Kunci aplikasi dinonaktifkan',
    );
  }

  void _ubahBiometrik(bool value) {
    setState(() {
      biometrik = value;
    });

    _tampilkanPesan(
      value
          ? 'Autentikasi biometrik diaktifkan'
          : 'Autentikasi biometrik dinonaktifkan',
    );
  }

  void _ubahNotifikasi(bool value) {
    setState(() {
      sembunyikanNotifikasi = value;
    });

    _tampilkanPesan(
      value
          ? 'Notifikasi sensitif akan disembunyikan'
          : 'Notifikasi sensitif ditampilkan',
    );
  }

  void _ubahBagikanData(bool value) {
    setState(() {
      bagikanData = value;
    });

    _tampilkanPesan(
      value
          ? 'Izin berbagi data diaktifkan'
          : 'Izin berbagi data dinonaktifkan',
    );
  }

  void _ubahHapusOtomatis(bool value) {
    setState(() {
      hapusOtomatis = value;
    });

    _tampilkanPesan(
      value
          ? 'Penghapusan otomatis setelah 12 bulan diaktifkan'
          : 'Penghapusan otomatis dinonaktifkan',
    );
  }

  void _unduhData() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Unduh Salinan Data',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          content: const Text(
            'Data profil dan riwayat skrining kamu akan disiapkan '
            'untuk diunduh.',
            style: TextStyle(
              color: textMuted,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Batal',
                style: TextStyle(color: textMuted),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _tampilkanPesan(
                  'Permintaan salinan data sedang diproses',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: pink,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Lanjutkan'),
            ),
          ],
        );
      },
    );
  }

  void _hapusAkun() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Hapus Akun?',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          content: const Text(
            'Tindakan ini akan menghapus akun dan data pengguna '
            'setelah proses konfirmasi. Tindakan ini tidak dapat '
            'dibatalkan.',
            style: TextStyle(
              color: textMuted,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Batal',
                style: TextStyle(color: textMuted),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _tampilkanPesan(
                  'Konfirmasi penghapusan akun diperlukan',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: pink,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Hapus Akun'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCream,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSecurityInfo(),

                    const SizedBox(height: 22),

                    _sectionTitle('KEAMANAN AKUN'),

                    const SizedBox(height: 10),

                    _buildSettingGroup([
                      _buildSwitchTile(
                        icon: Icons.lock_outline_rounded,
                        iconBackground: const Color(0xFFFFDDE6),
                        iconColor: pink,
                        title: 'Kunci Aplikasi',
                        subtitle: 'Wajib PIN saat membuka VitalCheck',
                        value: kunciAplikasi,
                        onChanged: _ubahKunciAplikasi,
                      ),
                      _buildSwitchTile(
                        icon: Icons.fingerprint_rounded,
                        iconBackground: const Color(0xFFD9F3EE),
                        iconColor: const Color(0xFF37A998),
                        title: 'Autentikasi Biometrik',
                        subtitle: 'Gunakan sidik jari atau Face ID',
                        value: biometrik,
                        onChanged: _ubahBiometrik,
                      ),
                    ]),

                    const SizedBox(height: 22),

                    _sectionTitle('PRIVASI DATA'),

                    const SizedBox(height: 10),

                    _buildSettingGroup([
                      _buildSwitchTile(
                        icon: Icons.notifications_none_rounded,
                        iconBackground: const Color(0xFFE8E0FF),
                        iconColor: purple,
                        title: 'Sembunyikan dari Notifikasi',
                        subtitle: 'Nama aplikasi tidak tampil di layar kunci',
                        value: sembunyikanNotifikasi,
                        onChanged: _ubahNotifikasi,
                      ),
                      _buildSwitchTile(
                        icon: Icons.location_on_outlined,
                        iconBackground: const Color(0xFFFFF0D2),
                        iconColor: const Color(0xFFC68A16),
                        title: 'Bagikan Data ke Fasyankes',
                        subtitle: 'Hanya saat kamu meminta rujukan',
                        value: bagikanData,
                        onChanged: _ubahBagikanData,
                      ),
                      _buildSwitchTile(
                        icon: Icons.delete_outline_rounded,
                        iconBackground: const Color(0xFFFFDDE6),
                        iconColor: pink,
                        title: 'Hapus Otomatis Setelah 12 Bulan',
                        subtitle: 'Riwayat lama akan terhapus permanen',
                        value: hapusOtomatis,
                        onChanged: _ubahHapusOtomatis,
                      ),
                    ]),

                    const SizedBox(height: 22),

                    _sectionTitle('LAINNYA'),

                    const SizedBox(height: 10),

                    _buildSettingGroup([
                      _buildActionTile(
                        icon: Icons.download_outlined,
                        iconBackground: const Color(0xFFFCEFE3),
                        iconColor: const Color(0xFF8D6B4A),
                        title: 'Unduh Salinan Data Saya',
                        onTap: _unduhData,
                      ),
                      _buildActionTile(
                        icon: Icons.delete_outline_rounded,
                        iconBackground: const Color(0xFFFFDDE6),
                        iconColor: pink,
                        title: 'Hapus Akun',
                        titleColor: pink,
                        onTap: _hapusAkun,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.04),
    blurRadius: 10,
    offset: const Offset(0, 3),
  ),
],
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: textDark,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privasi & Keamanan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Atur siapa yang bisa melihat datamu',
                  style: TextStyle(
                    fontSize: 12,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAE2FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            color: textDark,
            size: 21,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Semua data skrining dan percakapanmu terenkripsi '
              'end-to-end dan tidak pernah dibagikan tanpa izinmu.',
              style: TextStyle(
                fontSize: 12,
                color: textDark,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: textMuted,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSettingGroup(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: pink,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE9DFD5),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    Color titleColor = textDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                icon,
                size: 20,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: textDark,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}