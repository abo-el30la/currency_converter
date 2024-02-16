import 'package:currency_converter/config/routing/k_routes.dart';
import 'package:currency_converter/core/extension/context_extensions.dart';
import 'package:currency_converter/core/res/assets.dart';
import 'package:currency_converter/core/widgets/customs/copy_right.dart';
import 'package:currency_converter/screens/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()
        ..navigateToHomeScreen(
          onNavigate: () {
            context.navReplaceNamedTo(KAppRoutes.homeScreen);
          },
        ),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Center(
                  child: SvgPicture.asset(
                    KAppSvgs.currencyConverter,
                    height: 200.h,
                  ),
                ),
                const Spacer(),
                const CopyRightWidget(
                  appName: 'Currency Converter',
                  bottomMargin: 32,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
