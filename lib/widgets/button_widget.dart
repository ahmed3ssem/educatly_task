import 'package:flutter/material.dart';
import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:educatly_task/core/utils/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTap;
  final String name;

  const ButtonWidget({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
        minimumSize: Size(width.w, height.h),
        backgroundColor: AppColors.primaryColor,
        textStyle: const TextStyle(color: AppColors.whiteColor,
        ),
      ),
      onPressed: onTap,
      child: Text(
        name,
        style: TextStyle(fontSize: 16.fSize , fontWeight: FontWeight.bold),
      ),
    );
  }
}