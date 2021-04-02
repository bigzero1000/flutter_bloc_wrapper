import 'package:example_flutter_bloc_wrapper/ui/app/translation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as number;

String formatPrice(int price) {
  final numberFormat = number.NumberFormat("#,##0");
  final String formatted = numberFormat.format(price);
  return formatted;
}

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  if (hexString == null || hexString.isEmpty) return Colors.transparent;

  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

void showAlertDialog(BuildContext context, Widget content, {Widget title, VoidCallback onDismiss}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: title,
            content: content,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  onDismiss?.call();
                },
                child: Text(
                  Translations.of(context).text("dialog_btn_close"),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ));
}



Size textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)..layout();
  return textPainter.size;
}



String cleanText(String inputStr) {
  return inputStr.trim();
}

bool checkEmpty(String inputStr) {
  return cleanText(inputStr).isEmpty;
}

String getErrorBasedOnErrorCode(BuildContext context, String errorCode) {
  return Translations.of(context).text("message_error_$errorCode");
}

void hiddenKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String cleanSpace(String text) {
  return text.replaceAll(" ", "");
}

void scrollToTop(ScrollController scrollController) {
  scrollController.animateTo(
    0.0,
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 300),
  );
}
