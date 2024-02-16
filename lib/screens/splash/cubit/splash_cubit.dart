import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void navigateToHomeScreen({Function()? onNavigate}) async {
    await Future.delayed(const Duration(seconds: 2));
    onNavigate?.call();
  }
}
