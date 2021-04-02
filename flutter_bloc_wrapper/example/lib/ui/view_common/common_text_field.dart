import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final double borderRadius;
  final Color borderColor;
  final int maxLength;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassWordType;
  final TextEditingController controller;
  final bool enabled;
  final EdgeInsets margin;
  final double height;
  final ValueChanged<String> onChanged;

  const AppTextFieldWidget(
      {this.borderRadius = 4,
      this.borderColor = const Color(0xffB8B8B8),
      this.maxLength = 100,
      this.hintText = '',
      this.keyboardType = TextInputType.text,
      this.isPassWordType = false,
      this.enabled = true,
      this.controller,
      this.margin = EdgeInsets.zero,
      this.onChanged,
      this.height = 48});

  @override
  Widget build(BuildContext context) {
    final _border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      borderSide: BorderSide(color: borderColor),
    );
    return Container(
      margin: margin,
      height: height,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        obscureText: isPassWordType,
        style: const TextStyle(fontSize: 14),
        onChanged: onChanged,
        decoration: InputDecoration(
            counterText: "",
            errorStyle: const TextStyle(fontSize: 8, color: Colors.black),
            contentPadding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            enabledBorder: _border,
            focusedBorder: _border,
            disabledBorder: _border),
      ),
    );
  }
}
