import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/app_colors.dart';
class ItemMenuCard extends StatelessWidget {
  ItemMenuCard({super.key,this.imageName = "",this.onTapAction,this.itemTitleName = ""});

  String? imageName,itemTitleName;
  GestureTapCallback? onTapAction;

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Ink(
        decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
        ),
        child: InkWell(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          onTap: onTapAction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image(image: AssetImage(imageName!),width: 150.w,height: 150.h,),
              Text(itemTitleName!,style: th.textTheme.titleMedium,)
            ],
          ),
        ),
      ),
    );
  }
}
