import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/assets.dart';

class SearchCardItem extends StatelessWidget {
  SearchCardItem({
    super.key,
    this.onTapItemCard,
    this.text,
    this.id,
  });

  GestureTapCallback? onTapItemCard;
  String? id = "", text = "";

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    return Ink(
      child: InkWell(
        onTap: onTapItemCard,
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text!,
              textDirection: TextDirection.rtl,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: th.primaryColorDark,
                fontSize: th.textTheme.titleLarge?.fontSize,
              ),
            ),
            Divider(
              color: th.primaryColorDark,
              height: 20.h,
              thickness: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
