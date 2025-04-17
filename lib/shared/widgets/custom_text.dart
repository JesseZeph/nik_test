import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NikText extends StatelessWidget {
  const NikText({
    super.key,
    required this.text,
    this.size,
    this.weight,
    this.align,
    this.overflow,
    this.height,
    this.maxlines,
    this.color,
    this.underline = false,
    this.decoColor,
  });

  final String text;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  final TextOverflow? overflow;
  final double? height;
  final int? maxlines;
  final Color? color, decoColor;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Text(
      text,
      textAlign: align ?? TextAlign.center,
      overflow: overflow ?? TextOverflow.clip,
      style: GoogleFonts.montserrat(
        fontSize: size?.spMin ?? 12.spMin,
        fontWeight: weight ?? FontWeight.normal,
        color: color ?? theme.bodyMedium?.color,
        height: height,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: decoColor,
      ),
      softWrap: true,
      maxLines: maxlines,
    );
  }
}
