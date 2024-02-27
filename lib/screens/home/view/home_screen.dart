import 'package:currency_converter/config/routing/k_routes.dart';
import 'package:currency_converter/core/extension/context_extensions.dart';
import 'package:currency_converter/core/res/assets.dart';
import 'package:currency_converter/core/widgets/customs/loading_widget.dart';
import 'package:currency_converter/data/repository/repository.dart';
import 'package:currency_converter/screens/home/cubit/home_cubit.dart';
import 'package:currency_converter/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/currency_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        remoteRepository: Repository.instance,
      )..getCurrencyList(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // switch (state) {
          //   case HomeInitial():
          //   case GetCurrencyListLoading():
          //   case GetCurrencyListSuccess():
          //   case GetCurrencyListError():
          // }
        },
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    context.navNamedTo(KAppRoutes.converterScreen);
                  },
                  icon: SvgPicture.asset(
                    KAppSvgs.currencyConverter,
                    height: 32.r,
                    width: 32.r,
                  ),
                ),
              ],
              title: Text(
                'Currency Converter',
                style: KAppTextStyle.boldTextStyle.copyWith(
                  fontSize: 20.sp,
                ),
              ),
            ),
            body: cubit.isGetCurrencyListLoading
                ? const LoadingWidget()
                : CurrencyListWidget(
                    currencyList: cubit.currencyList,
                  ),
          );
        },
      ),
    );
  }
}
