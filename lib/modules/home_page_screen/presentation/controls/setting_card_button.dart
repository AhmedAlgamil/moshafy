import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingCardButton extends StatelessWidget {

  final String? imageName, itemTitleName;
  final GestureTapCallback? onTapAction;
  const SettingCardButton({Key? key,this.itemTitleName="",this.imageName="",this.onTapAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(15.0.sp),
      child: SizedBox(
        height: 135.h,
        child: Card(
          elevation: 10,
          color: th.primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15.sp,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 21.w, right: 21.w),
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
