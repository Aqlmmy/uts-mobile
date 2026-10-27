import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Alasan Desain:
// Memilih font Poppins dari Google Fonts karena memiliki karakteristik geometris sans-serif
// yang modern, bersih, dan sangat mudah dibaca pada layar perangkat mobile.
// Dipadukan dengan fleksibilitas pengaturan ukuran, ketebalan, dan warna font agar informasi menu
// dapat tersaji secara hierarkis dan nyaman dilihat oleh pengguna aplikasi kantin.
class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
