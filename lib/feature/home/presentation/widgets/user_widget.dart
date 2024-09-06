import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:educatly_task/widgets/image_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListItem extends StatelessWidget {
  final String image;
  final String email;

  const UserListItem({
    super.key,
    required this.email,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(12.adaptSize),
        leading: ImageLoader(imageUrl: image, height: 50.h, width: 50.w,),
        title: Text(
          email,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.fSize,
          ),
        ),
        subtitle: Text(
          'email'.tr,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
