import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/res/colors.dart';
import '../../../data/model/response_models/get_currencies.dart';
import '../../../utils/app_text_styles.dart';

class CurrencyListWidget extends StatelessWidget {
  const CurrencyListWidget({super.key, required this.currencyList});

  final List<Currency> currencyList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: currencyList.length,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
      ),
      separatorBuilder: (context, index) {
        return Container(
          height: 1.h,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                KAppColors.color_4CAF50,
                KAppColors.color_FFF59D,
              ],
            ),
          ),
        );
      },
      itemBuilder: (context, index) {
        final currency = currencyList[index];
        return Container(
            decoration: BoxDecoration(
              //color: KAppColors.color_FFF59D,
              borderRadius: BorderRadius.circular(15.r),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 5.h,
              horizontal: 5.w,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: KAppColors.color_4CAF50,
                  child: Text(
                    currency.code ?? '',
                    style: KAppTextStyle.regularTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currency.name ?? '',
                      style: KAppTextStyle.regularTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currency.code ?? '',
                      style: KAppTextStyle.regularTextStyle.copyWith(
                        color: KAppColors.color_9E9E9E,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  currency.symbol ?? '',
                  style: KAppTextStyle.regularTextStyle,
                ),
              ],
            ));
      },
    );
  }
}