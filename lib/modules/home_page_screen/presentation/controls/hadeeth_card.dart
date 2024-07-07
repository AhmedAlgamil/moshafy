import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HadeethItemCard extends StatelessWidget {
  const HadeethItemCard({
    super.key,
    this.onTapItemCard,
    this.iconButtonAction,
    this.hadeethText = "",
    this.isFavaouraited = false,
  });

  final GestureTapCallback? onTapItemCard, iconButtonAction;
  final String? hadeethText;
  final bool isFavaouraited;

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(4.sp),
      child: Directionality(
        textDirection: TextDirection.rtl,
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
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        // textDirection: TextDirection.rtl,
                        hadeethText!,
                        style: th.textTheme.titleMedium,
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
      ),
    );
  }
}
