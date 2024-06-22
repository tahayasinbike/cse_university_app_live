import 'package:cse_university_app/custom_gpt/widgets/text_widget.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomChatWidget extends StatelessWidget {
  const CustomChatWidget({
    Key? key,
    required this.msg,
  }) : super(key: key);
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: CustomColors.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/chat_logo.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: TextWidget(label: msg)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
