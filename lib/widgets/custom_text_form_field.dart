import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.validator,
    required this.obscureText,
    required this.suffix,
    required this.prefixIcon,
    required this.keyboardType,
    this.maxLine,
    this.labelText,
    this.hintText,
  });

  final TextEditingController? controller;
  final String? Function(String? val) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? hintText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final int? maxLine;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      maxLines: maxLine ?? 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: Theme
          .of(context)
          .textTheme
          .titleMedium,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffix: suffix,
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle:const TextStyle(fontWeight: FontWeight.w400),
        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.borderColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.borderColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.appColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.errorColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.errorColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: Theme
            .of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: AppColor.errorColor, fontSize: 12),
      ),
      validator: validator,
    );
  }
}
