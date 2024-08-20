import 'package:flutter/widgets.dart';

class TextRIchWidget extends StatelessWidget {
  const TextRIchWidget({
    super.key,
    required this.data,
    required this.fontSize,
    required this.fontWeight,
    required this.overflow,
    required this.textAlign,
    required this.maxLines,
  });

  final dynamic data;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.data,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
  });

  final dynamic data;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          color: textColor, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
