import 'package:flutter/material.dart';

class QuizBlockWidget extends StatelessWidget {
  final String choiceText;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;

  const QuizBlockWidget({
    super.key,
    required this.choiceText,
    this.onTap,
    this.isSelected = false,
    this.isCorrect = false,
    this.showResult = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    Color borderColor = const Color(0xffD9D9D9);
    Color textColor = Colors.black;
    IconData? icon;
    Color? iconColor;

    if (showResult) {
      if (isCorrect) {
        // 정답 스타일
        bgColor = const Color(0xFFFFF6F3); // #FFF6F3
        borderColor = const Color(0xFFFFA782); // #FFA782
        textColor = const Color(0xFFFD6929); // #FD6929
        icon = Icons.check;
        iconColor = textColor;
      } else if (isSelected && !isCorrect) {
        // 오답 스타일
        bgColor = const Color(0xFFF6F6F6); // #F6F6F6
        borderColor = const Color(0xFFDADADA); // #DADADA
        textColor = const Color(0xFF7E7E7E); // #7E7E7E
        icon = Icons.close;
        iconColor = textColor;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1),
        ),
        width: 320,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                choiceText,
                style: TextStyle(fontSize: 14, color: textColor),
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                color: iconColor,
              ),
          ],
        ),
      ),
    );
  }
}
