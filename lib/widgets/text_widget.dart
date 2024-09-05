
import 'package:flutter/material.dart';
import 'package:educatly_task/core/utils/size_utils.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;

  const TextWidget({
    required this.text,
    required this.fontSize,
    this.fontColor,
    this.fontWeight
});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ,
      style: TextStyle(
        fontSize: fontSize.fSize ,
        color: fontColor,
        fontWeight: fontWeight
      ),
    );
  }
}
