import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/app_colors.dart';

class GridCardItem extends StatelessWidget {
  GridCardItem({
    super.key,
    this.imageName = "",
    this.onTapAction,
    this.itemTitleName = "",
    this.totalCount = "0",
    this.counter = "0",
  });

  String? imageName, itemTitleName, totalCount, counter;
  GestureTapCallback? onTapAction;

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(15.0.sp),
      child: SizedBox(
        height: 150.h,
        child: Card(
          elevation: 10,
          color: th.primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15.sp,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Ink(
              child: InkWell(
                borderRadius: BorderRadius.circular(15.sp),
                onTap: onTapAction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      height: 100.h,
                      width: 100.w,
                      image: AssetImage(imageName!),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          itemTitleName!,
                          style: th.textTheme.titleMedium,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              counter!,
                              style: th.textTheme.titleMedium,
                              textDirection: TextDirection.rtl,
                            ),Text(
                              totalCount!,
                              style: th.textTheme.titleMedium,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
