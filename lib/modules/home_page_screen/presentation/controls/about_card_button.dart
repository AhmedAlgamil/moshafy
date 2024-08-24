import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutCardButton extends StatelessWidget {
  final String leadingText;
  final Widget? widget;

  const AboutCardButton({Key? key,this.leadingText="",this.widget}) : super(key: key);

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
          onTap: () {},
          title: Text(
            leadingText,
            style: th.textTheme.titleLarge,
          ),
          trailing: widget,
        ),
      ),
    );
  }
}
