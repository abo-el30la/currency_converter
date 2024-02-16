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
      itemCount: currencyList.length,
      separatorBuilder: (context, index) {
        return Container(
          height: 1.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
              ],
            ),
          ),
        );
      },
      itemBuilder: (context, index) {
        final currency = currencyList[index];
        return ListTile(
          title: Text(
            currency.name ?? '',
            style: KAppTextStyle.boldTextStyle,
          ),
          subtitle: Text(
            "${currency.code}",
            style: KAppTextStyle.regularTextStyle.copyWith(
              color: KAppColors.color_9E9E9E,
            ),
          ),
          trailing: Text(
            currency.symbol ?? '',
            style: KAppTextStyle.boldTextStyle,
          ),
          leading: CircleAvatar(
            backgroundColor: KAppColors.color_4CAF50,
            child: Text(
              currency.code ?? '',
              style: KAppTextStyle.boldTextStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
