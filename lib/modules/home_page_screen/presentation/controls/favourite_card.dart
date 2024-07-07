import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteItem extends StatelessWidget {
  FavouriteItem({
    super.key,
    this.onTapItemCard,
    this.favouriteModel,
  });

  GestureTapCallback? onTapItemCard, iconButtonAction;
  Map<String, dynamic>? favouriteModel;
  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(4.sp),
      child: Card(
        color: th.primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Ink(
          height: 120.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.sp,
            ),
          ),
          child: InkWell(
            onTap: onTapItemCard,
            borderRadius: BorderRadius.circular(10.sp),
            child: Padding(
              padding: EdgeInsets.all(4.sp),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      favouriteModel!['favourite_text'].toString(),
                      style: th.textTheme.titleLarge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      maxLines: 4,
                      textDirection: TextDirection.rtl,
                      favouriteModel!['type_text'].toString(),
                      style: th.textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
