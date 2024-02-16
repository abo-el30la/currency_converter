import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/extension/context_extensions.dart';
import '../res/assets.dart';
Future showKBottomSheet({
  required BuildContext context,
  required Widget childContent,
  bool isDismissible = true,
  bool hasShape = true,
  Alignment alignment = Alignment.bottomCenter,
  EdgeInsets dialogPadding = EdgeInsets.zero,
  Function(bool)? isDialogShown,
}) async {
  isDialogShown?.call(true);
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: hasShape
            ? Dialog(
                insetPadding: dialogPadding,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40).r,
                  topRight: const Radius.circular(40).r,
                )),
                alignment: alignment,
                child: BottomSheetWidget(
                  childContent: childContent,
                ),
              )
            : Material(
                color: Colors.transparent,
                type: MaterialType.card,
                clipBehavior: Clip.none,
                child: BottomSheetWidget(
                  childContent: childContent,
                ),
              ),
      );
    },
  ).whenComplete(
    () {
      isDialogShown?.call(false);
    },
  ).onError(
    (error, stackTrace) {
      isDialogShown?.call(false);
      return isDialogShown;
    },
  );
}

class BottomSheetWidget extends StatelessWidget {
  final Widget childContent;

  const BottomSheetWidget({
    super.key,
    required this.childContent,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          childContent,
          PositionedDirectional(
            top: 18.r,
            end: 18.r,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.pop();
              },
              child: SizedBox(
                height: 33.r,
                width: 33.r,
                child: SvgPicture.asset(KAppSvgs.closeIcon),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
