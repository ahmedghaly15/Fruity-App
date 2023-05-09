import 'package:flutter/material.dart';

import '../global/app_colors.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.textStyle = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: AppColors.kPrimaryColor,
    ),
  });

  final void Function()? onPressed;
  final String title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(title, style: textStyle),
    );
  }
}
