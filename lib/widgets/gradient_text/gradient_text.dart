import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
        this.textAlign,
        this.overflow,
        this.maxLines,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style,textAlign:textAlign ,overflow:overflow ,maxLines:maxLines ),
    );
  }
}