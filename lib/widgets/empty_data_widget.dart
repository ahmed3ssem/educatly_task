import 'package:flutter/material.dart';
import 'package:educatly_task/core/utils/assets_manager.dart';
import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:get/get.dart';

import '../core/utils/app_colors.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsManager.noDataImage , width: 80.w,height: 80.h,),
          Text('noData'.tr , style: TextStyle(fontSize: 20.fSize , color: AppColors.grey , fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
