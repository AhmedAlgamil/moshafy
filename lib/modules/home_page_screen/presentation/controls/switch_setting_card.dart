import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';


class SwitchSettingCard extends StatelessWidget {
  SwitchSettingCard({
    Key? key,
    this.switchValue,
    this.onTapItemCard,
    this.onChangeSwitchValue,
  }) : super(
          key: key,
        );

  final String? switchValue;

  final GestureTapCallback? onTapItemCard;
  ValueChanged<bool>? onChangeSwitchValue;

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(10.0.sp),
      child: Card(
        color: th.primaryColorLight,
        elevation: 10.0.sp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.sp,
            ),
          ),
        ),
        child: ListTile(
          selected: true,
          onTap: onTapItemCard,
          title: Text(
            "${th}",
            style: th.textTheme.titleLarge,
            // "الوضع اليلي",
          ),
          // title: Text(
          //   switchValue == "Device" ? "وضع الجهاز" : switchValue == "light" ? "وضع النهار" : "وضع الليل",
          //   style: th.textTheme.titleLarge,
          //   // "الوضع اليلي",
          // ),
          // trailing: Switch(
          //   activeColor: th.primaryColorDark,
          //   activeTrackColor: th.primaryColorDark,
          //   onChanged: (value) {
          //
          //   },
          //   value: switchValue,
          // ),
          trailing: Image(
            height: 50.h,
            width: 50.w,
            image: switchValue == "Device"
                ? const AssetImage(Assets.imagesSwitchDevice)
                : switchValue == "light"
                    ? const AssetImage(Assets.imagesSwitchDark)
                    : const AssetImage(Assets.imagesSwitchWhite),
          ),
        ),
      ),
    );
  }
}
