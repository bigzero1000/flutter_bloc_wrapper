import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget(
      {@required this.onPressed,
      @required this.title,
      this.color = const Color(0xffed6103),
      this.textColor = Colors.white,
      this.borderColor = const Color(0xffed6103),
      this.fontSize = 16,
      this.height = 44,
      this.cornerRadius = 22,
      this.width = double.infinity,
      this.rightButtonAvailable = false,
      this.rightButtonIcon = const Icon(Icons.chevron_right),
      this.margin = EdgeInsets.zero,
      this.rightButtonPadding = 4,
      this.autoResizeText = false,
      this.leftButtonAvailable = false,
      this.leftButtonIcon = const Icon(Icons.chevron_left),
      this.leftButtonPadding = 4});

  final GestureTapCallback onPressed;
  final String title;
  final double width;
  final double height;
  final double cornerRadius;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final bool rightButtonAvailable;
  final Icon rightButtonIcon;
  final double rightButtonPadding;
  final EdgeInsets margin;
  final bool autoResizeText;
  final bool leftButtonAvailable;
  final Icon leftButtonIcon;
  final double leftButtonPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            side: BorderSide(width: 2, color: (onPressed != null) ? borderColor : const Color(0xffB5B5B5))),
        disabledColor: const Color(0xffB5B5B5),
        color: color,
        textColor: textColor,
        onPressed: onPressed,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (rightButtonAvailable)
              Positioned(
                right: 0,
                top: rightButtonPadding,
                bottom: rightButtonPadding,
                child: SizedBox(
                  height: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: rightButtonIcon,
                  ),
                ),
              ),
            Center(
                child: Padding(
              padding: _getPadding(rightButtonAvailable: rightButtonAvailable, leftButtonAvailable: leftButtonAvailable),
              child: autoResizeText
                  ? AutoSizeText(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      minFontSize: 6,
                      style: TextStyle(color: textColor, fontSize: fontSize),
                    )
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textColor, fontSize: fontSize),
                    ),
            )),
            if (leftButtonAvailable)
              Positioned(
                left: 0,
                top: leftButtonPadding,
                bottom: leftButtonPadding,
                child: SizedBox(
                  height: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: leftButtonIcon,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  EdgeInsets _getPadding({bool rightButtonAvailable, bool leftButtonAvailable}) {
    if (rightButtonAvailable) {
      return const EdgeInsets.only(right: 20);
    } else if (leftButtonAvailable) {
      return const EdgeInsets.only(left: 20);
    } else {
      return EdgeInsets.zero;
    }
  }
}
