import 'package:example_flutter_bloc_wrapper/ui/app/translation.dart';
import 'package:example_flutter_bloc_wrapper/ui/view_common/common_text_field.dart';
import 'package:flutter/material.dart';

class TextFieldWarning extends StatelessWidget {
  final double borderRadius;
  final Color borderColor;
  final int maxLength;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassWordType;
  final TextEditingController controller;
  final bool enabled;
  final EdgeInsets margin;
  final String errorCode;
  final ValueChanged<String> onChanged;

  const TextFieldWarning(
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
      this.errorCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        children: [
          AppTextFieldWidget(
            borderColor: borderColor,
            borderRadius: borderRadius,
            maxLength: maxLength,
            hintText: hintText,
            keyboardType: keyboardType,
            isPassWordType: isPassWordType,
            controller: controller,
            enabled: enabled,
            onChanged: onChanged,
          ),
          if (errorCode != null && errorCode.isNotEmpty)
            Container(
                height: 20,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  Translations.of(context).text(errorCode),
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ))
        ],
      ),
    );
  }
}
