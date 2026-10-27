import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_text.dart';

class MenuDetailPage extends StatelessWidget {
  final Map<String, dynamic> menu;

  const MenuDetailPage({super.key, required this.menu});

  String _formatCurrency(dynamic price) {
    if (price == null) return 'Rp 0';
    final number = price.toString();
    final reversed = number.split('').reversed.join('');
    final formattedReversed = reversed.replaceAllMapped(
      RegExp(r'.{1,3}'),
      (match) => '${match.group(0)}.',
    );
    var result = formattedReversed.split('').reversed.join('');
    if (result.startsWith('.')) {
      result = result.substring(1);
    }
    return 'Rp $result';
  }

  IconData _getHeroIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('nasi')) return Icons.rice_bowl_rounded;
    if (lower.contains('ayam') || lower.contains('geprek')) return Icons.lunch_dining_rounded;
    if (lower.contains('mie') || lower.contains('bakso')) return Icons.ramen_dining_rounded;
    if (lower.contains('soto') || lower.contains('sop')) return Icons.soup_kitchen_rounded;
    if (lower.contains('teh') || lower.contains('kopi')) return Icons.local_cafe_rounded;
    if (lower.contains('jus') || lower.contains('es')) return Icons.local_bar_rounded;
    return Icons.restaurant_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final name = menu['name']?.toString() ?? '-';
    final price = menu['price'];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const CustomText(
          'Detail Menu Kantin',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Card dengan ilustrasi visual menarik
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF16A34A), Color(0xFF22C55E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4016A34A),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: const Color(0x38FFFFFF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0x66FFFFFF),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _getHeroIcon(name),
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    name,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CustomText(
                      _formatCurrency(price),
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF16A34A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Card Informasi Pelengkap
            Card(
              elevation: 2,
              shadowColor: const Color(0x10000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFF1F5F9), width: 1.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      'Informasi Menu',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBadge(
                          Icons.storefront_rounded,
                          'Lokasi',
                          'Kantin FT',
                          Colors.blue.shade600,
                        ),
                        _buildBadge(
                          Icons.check_circle_rounded,
                          'Ketersediaan',
                          'Tersedia',
                          const Color(0xFF10B981),
                        ),
                        _buildBadge(
                          Icons.access_time_filled_rounded,
                          'Waktu Masak',
                          '± 10 Menit',
                          Colors.amber.shade800,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: Color(0xFFF1F5F9)),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          color: Color(0xFF10B981),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomText(
                            'Menu higienis, halal, dan disajikan segar setiap hari.',
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Kembali
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_rounded, size: 20),
              label: const CustomText(
                'Kembali ke Daftar Menu',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: const Color(0x6616A34A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String title, String value, Color iconColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(height: 8),
        CustomText(
          title,
          fontSize: 12,
          color: const Color(0xFF64748B),
        ),
        const SizedBox(height: 2),
        CustomText(
          value,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
        ),
      ],
    );
  }
}
