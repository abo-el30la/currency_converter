import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routing/k_routes.dart';
import 'core/localization/app_localizations_setup.dart';
import 'core/localization/lang_bloc/local_cubit.dart';

class App extends StatelessWidget {

  const App({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _applySystemChrome();
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (BuildContext context) => LocalCubit()),
      ],
      child: BlocConsumer<LocalCubit, LocalStates>(
        listener: (BuildContext context, LocalStates state) {},
        buildWhen: (LocalStates previousState, LocalStates currentState) => previousState != currentState,
        builder: (_, LocalStates localeState) => MaterialApp(
          title: 'Currency Converter',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizationSetup.localizationsDelegate,
          supportedLocales: AppLocalizationSetup.supportedLocales,
          locale: localeState.locale,
          onGenerateRoute: KAppRoutes.generateRoute,
          initialRoute: KAppRoutes.splash,
        ),
      ),
    );
  }

  _applySystemChrome() async {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
