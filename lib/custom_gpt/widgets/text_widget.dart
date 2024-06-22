import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.label,
    this.fontSize = 18,
    this.color,
    this.fontWeight,
  }) : super(key: key);
  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  List<TextSpan> parseText(String text) {
    final RegExp exp = RegExp(r'\[([^\]]+)\]\((https?:\/\/[^\s\)]+)\)');
    final List<TextSpan> spans = [];

    int lastMatchEnd = 0;

    for (final Match match in exp.allMatches(text)) {
      final String preText = text.substring(lastMatchEnd, match.start);
      if (preText.isNotEmpty) {
        spans.add(TextSpan(text: preText));
      }

      final String linkText = match.group(1)!;
      final String url = match.group(2)!;

      spans.add(TextSpan(
          text: linkText,
          style: TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                print('Could not launch $url');
              }
            }));

      lastMatchEnd = match.end;
    }

    final String postText = text.substring(lastMatchEnd);
    if (postText.isNotEmpty) {
      spans.add(TextSpan(text: postText));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: color ?? CustomColors.white,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
        children: parseText(label),
      ),
    );

    /* SelectableText(
      "$label",
      style: TextStyle(
        color: color ?? CustomColors.white,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    ); */
  }
}
