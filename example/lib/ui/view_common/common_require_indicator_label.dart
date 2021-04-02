import 'package:example_flutter_bloc_wrapper/ui/app/translation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class RequireIndicatorLabelWidget extends StatelessWidget {
  final String title;
  final bool isRequired;
  final bool notShowWarning;
  final EdgeInsets margin;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;

  const RequireIndicatorLabelWidget(
      {@required this.title,
      this.isRequired = true,
      this.margin = EdgeInsets.zero,
      this.fontSize = 14,
      this.fontWeight = FontWeight.bold,
      this.notShowWarning = true,
      this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 10)});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: notShowWarning ? const Color(0xffEFEFEF) : const Color(0xffF1D2D2),
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: Colors.grey),
          ),
          if (isRequired)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              alignment: Alignment.center,
              decoration:
                  const BoxDecoration(color: Color(0xffD32D26), borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Text(
                Translations.of(context).text('common_required_label'),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
