import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home_page_screen/data/model/favourite_model.dart';
class FavouriteItem extends StatelessWidget {
  FavouriteItem({
    super.key,
    this.onTapItemCard,
    this.iconButtonAction,
    this.favouriteModel,
    this.isFavaouraited = true,
  });

  GestureTapCallback? onTapItemCard, iconButtonAction;
  FavouriteModel? favouriteModel;
  bool isFavaouraited;

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(4.sp),
      child: Card(
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
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      favouriteModel!.titleFavouted!,
                      style: th.textTheme.titleMedium,
                    ),
                  ),Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      maxLines: 4,
                      textDirection: TextDirection.rtl,
                      favouriteModel!.favType!,
                      style: th.textTheme.titleSmall,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(
                        isFavaouraited ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: iconButtonAction,
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
