import 'package:flutter/material.dart';

import '../global/app_colors.dart';
import '../global/app_styles.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextStyle? hintStyle;
  final bool? obsecure;
  final Widget? icon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validating;
  final TextInputType keyboardType;
  final void Function(String)? onSubmit;

  const InputField({
    Key? key,
    required this.hint,
    this.hintStyle = AppStyles.textStyle18,
    required this.controller,
    required this.textCapitalization,
    required this.validating,
    required this.keyboardType,
    this.obsecure,
    this.prefixIcon,
    this.icon,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle!.copyWith(color: Colors.grey),
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.kPrimaryColor,
        suffixIcon: icon,
        suffixIconColor: AppColors.kPrimaryColor,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: buildOutlineInputBorder(Colors.grey, 0),
        focusedBorder: buildOutlineInputBorder(AppColors.kPrimaryColor, 2),
        errorBorder: buildOutlineInputBorder(Colors.red, 2),
      ),
      cursorColor: AppColors.kPrimaryColor,
      style: AppStyles.textStyle20.copyWith(color: AppColors.kPrimaryColor),
      obscureText: obsecure!,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      validator: validating,
      onFieldSubmitted: onSubmit,
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: BorderRadius.circular(15),
    );
  }
}
