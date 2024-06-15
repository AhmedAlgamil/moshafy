import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/assets.dart';

class SurahItemCard extends StatelessWidget {
  SurahItemCard({
    super.key,
    required this.surah,
    this.onTapItemCard,
    this.onTapFavouriteCard,
  });

  Map<String,dynamic> surah;
  GestureTapCallback? onTapItemCard,onTapFavouriteCard;

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
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.sp,
            ),
          ),
          child: InkWell(
            onTap: onTapItemCard,
            borderRadius: BorderRadius.circular(10.sp),
            child: Padding(
              padding: EdgeInsets.all(3.sp),
              child: Stack(
                textDirection: TextDirection.rtl,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "الصفحة ${surah["surah_page"]}",
                      style: th.textTheme.titleSmall,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "رقم السورة ${surah["number"]}",
                      style: th.textTheme.titleSmall,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          surah["surah_name"]!,
                          style: th.textTheme.titleLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "عدد الايات ${surah["numberOfAyahs"]}",
                          style: th.textTheme.titleMedium,
                        ),
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          IconButton(
                            onPressed: onTapFavouriteCard,
                            splashRadius: 15.sp,
                            icon: Icon(
                              surah["is_favourited"] == "true" ? Icons.star_outlined : Icons.star_border,
                              size: 30.w,
                              color: Colors.amber,
                            ),
                          ),
                          Image(
                            image: surah["revelationType"] == "Meccan"
                                ? AssetImage(Assets.imagesKaba)
                                : AssetImage(Assets.imagesMosqe),
                            width: 30.w,
                            height: 30.h,
                          ),
                        ],
                      ),
                    ],
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
