import 'package:flutter/material.dart';

class DataDiriPasienPage extends StatefulWidget {
  const DataDiriPasienPage({super.key});

  @override
  State<DataDiriPasienPage> createState() => _DataDiriPasienPageState();
}

class _DataDiriPasienPageState extends State<DataDiriPasienPage> {
  static const Color pink = Color(0xFFF64F78);
  static const Color purpleStart = Color(0xFFB8AEF9);
  static const Color purpleEnd = Color(0xFF8676F3);
  static const Color bgCream = Color(0xFFFAF6F0);
  static const Color textDark = Color(0xFF272134);
  static const Color textMuted = Color(0xFF8C8698);

  final TextEditingController namaController =
      TextEditingController(text: 'Dinda Putri');

  final TextEditingController emailController =
      TextEditingController(text: 'dinda.putri@email.com');

  final TextEditingController hpController =
      TextEditingController(text: '0812-3456-7890');

  final TextEditingController tanggalLahirController =
      TextEditingController(text: '14 Maret 1998');

  String jenisKelamin = 'Perempuan';

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    tanggalLahirController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: textDark,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Diri',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: textDark,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Kelola informasi akunmu',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ================= FOTO / AVATAR =================
              Center(
                child: Column(
                  children: [
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
                            color: purpleEnd.withValues(alpha: 0.22),
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

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDCE5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Ganti Foto',
                        style: TextStyle(
                          color: pink,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================= NAMA =================
              _buildLabel('Nama lengkap'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: namaController,
                keyboardType: TextInputType.name,
              ),

              const SizedBox(height: 16),

              // ================= EMAIL =================
              _buildLabel('Email'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // ================= NOMOR HP =================
              _buildLabel('Nomor HP'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: hpController,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 16),

              // ================= TANGGAL LAHIR =================
              _buildLabel('Tanggal lahir'),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: _pilihTanggalLahir,
                child: AbsorbPointer(
                  child: _buildTextField(
                    controller: tanggalLahirController,
                    suffixIcon: const Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                      color: textMuted,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= JENIS KELAMIN =================
              _buildLabel('Jenis kelamin'),
              const SizedBox(height: 8),

              Container(
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE8DED7),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: jenisKelamin,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: textDark,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: textDark,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Perempuan',
                        child: Text('Perempuan'),
                      ),
                      DropdownMenuItem(
                        value: 'Laki-laki',
                        child: Text('Laki-laki'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          jenisKelamin = value;
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ================= SIMPAN =================
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _simpanPerubahan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pink,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: pink.withValues(alpha: 0.28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= LABEL =================
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: textDark,
      ),
    );
  }

  // ================= TEXT FIELD =================
  Widget _buildTextField({
    required TextEditingController controller,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 14,
        color: textDark,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE8DED7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: pink,
            width: 1.4,
          ),
        ),
      ),
    );
  }

  // ================= DATE PICKER =================
  Future<void> _pilihTanggalLahir() async {
    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(1998, 3, 14),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      final String tanggalFormat =
          '${tanggal.day} ${_namaBulan(tanggal.month)} ${tanggal.year}';

      setState(() {
        tanggalLahirController.text = tanggalFormat;
      });
    }
  }

  String _namaBulan(int bulan) {
    const bulanList = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return bulanList[bulan - 1];
  }

  // ================= SIMPAN =================
  void _simpanPerubahan() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perubahan data berhasil disimpan'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}