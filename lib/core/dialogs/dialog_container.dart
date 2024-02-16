import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogContainer extends StatelessWidget {
  const DialogContainer({
    Key? key,
    required this.dialogPage,
    this.decoration,
    this.centerText = '',
    this.padding,
  }) : super(key: key);

  final Widget dialogPage;
  final String centerText;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: decoration,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                // child: AppBarIcon(
                //   centerSize: 90.w,
                //   startSize: 90.w,
                //   endSize: 16.w,
                //   // asset: KAppSvgs.close,
                //   asset: '',
                //   centerText: centerText,
                //   onClicked: () {
                //     Navigator.of(context).pop();
                //   },
                // ),
              ),
            ),
            Padding(
              padding: padding ??
                  REdgeInsetsDirectional.only(
                    top: 88.h,
                    start: 42.w,
                    end: 42.w,
                  ),
              child: dialogPage,
            ),
          ],
        ),
      ),
    );
  }
}
