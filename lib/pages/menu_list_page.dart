import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_text.dart';
import 'add_menu_page.dart';
import 'menu_detail_page.dart';

class MenuListPage extends StatefulWidget {
  const MenuListPage({super.key});

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  // Data menu awal (minimal 5 data) disimpan dalam List biasa di dalam State
  final List<Map<String, dynamic>> _menuList = [
    {'name': 'Nasi Goreng Spesial', 'price': 15000},
    {'name': 'Ayam Geprek Sambal Bawang', 'price': 17000},
    {'name': 'Mie Ayam Bakso Urat', 'price': 14000},
    {'name': 'Soto Ayam Lamongan', 'price': 16000},
    {'name': 'Es Teh Manis Jumbo', 'price': 4000},
    {'name': 'Jus Alpukat Cokelat', 'price': 10000},
  ];

  String _formatPrice(dynamic price) {
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

  IconData _getMenuIcon(String name) {
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
    // Sesuai hierarki widget pada Gambar 1:
    // Scaffold
    //  ├── AppBar -> Text (CustomText)
    //  ├── Column
    //  │     ├── Padding -> Text (CustomText)
    //  │     └── Expanded -> ListView.builder -> Card -> ListTile
    //  │                           ├── leading: Icon
    //  │                           ├── title: Text (CustomText)
    //  │                           ├── subtitle: Text (CustomText)
    //  │                           └── trailing: Icon
    //  └── FloatingActionButton -> Icon
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Kantin Teknik Untirta',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: const CustomText(
              'Makanan Tersedia',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 80, top: 4),
              itemCount: _menuList.length,
              itemBuilder: (context, index) {
                final item = _menuList[index];
                final itemName = item['name']?.toString() ?? '';
                final itemPrice = item['price'];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                  elevation: 2,
                  shadowColor: const Color(0x10000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFFF1F5F9), width: 1.2),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    leading: Icon(
                      _getMenuIcon(itemName),
                      color: const Color(0xFF16A34A),
                      size: 32,
                    ),
                    title: CustomText(
                      itemName,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                    subtitle: CustomText(
                      _formatPrice(itemPrice),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF16A34A),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xFF94A3B8),
                    ),
                    onTap: () {
                      Get.to(() => MenuDetailPage(menu: item));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF16A34A),
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: () async {
          final result = await Get.to(() => const AddMenuPage());
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              _menuList.add(result);
            });
          }
        },
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
    );
  }
}
