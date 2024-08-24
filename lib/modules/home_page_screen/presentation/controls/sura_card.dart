import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class SurahItemCard extends StatelessWidget {
  SurahItemCard({
    super.key,
    required this.surah,
    this.onTapItemCard,
    this.onTapFavouriteCard,
  });

  Map<String, dynamic> surah;
  GestureTapCallback? onTapItemCard, onTapFavouriteCard;

  @override
  Widget build(BuildContext context) {
    ThemeData th = Theme.of(context);
    S languages = S.of(context);
    return Padding(
      padding: EdgeInsets.all(4.sp),
      child: Card(
        color: th.primaryColorLight,
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
                      Localizations.localeOf(context).toString() == "ar"
                          ? "${languages.page}  ${ArabicNumbers().convert(surah["surah_page"])}"
                          : "${languages.page}  ${surah["surah_page"]}",
                      style: th.textTheme.titleSmall,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      Localizations.localeOf(context).toString() == "ar"
                          ? "${languages.sorahNumber}  ${ArabicNumbers().convert(surah["number"])}"
                          : "${languages.sorahNumber}  ${surah["number"]}",
                      style: th.textTheme.titleSmall,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          Localizations.localeOf(context).toString() == "ar"
                              ? surah["surah_name"]!
                              : surah["surahEnglishName"]!,
                          style: th.textTheme.titleLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Localizations.localeOf(context).toString() == "ar"
                              ? "${languages.ayahsNmuber}  ${ArabicNumbers().convert(surah["numberOfAyahs"])}"
                              : "${languages.ayahsNmuber}  ${surah["numberOfAyahs"]}",
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
                              surah["is_favourited"] == "true"
                                  ? Icons.star_outlined
                                  : Icons.star_border,
                              size: 30.w,
                              color: Colors.amber,
                            ),
                          ),
                          Image(
                            image: surah["revelationType"] == "Meccan"
                                ? const AssetImage(Assets.imagesKaba)
                                : const AssetImage(Assets.imagesMosqe),
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
