import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../app.dart';
import 'bloc_obs.dart';
import 'config/k_app_const.dart';
import 'data/model/response_models/get_currencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(CurrencyAdapter());

  runApp(
    ScreenUtilInit(
      designSize: Size(KAppConst.designScreenW, KAppConst.designScreenH),
      minTextAdapt: false,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return const App();
      },
    ),
  );
}
