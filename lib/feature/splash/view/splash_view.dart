import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/routes/navigation.dart';

import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/utils/app_assets.dart';
import 'package:notes_app/feature/auth/view/login_page.dart';
import 'package:notes_app/feature/main/view/main_page.dart';
import 'package:notes_app/feature/splash/logic/is_logged_in/is_logged_in_cubit.dart';
import 'package:notes_app/main.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      context.read<IsLoggedInCubit>().isLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorScheme(context).background,
      body: BlocListener<IsLoggedInCubit, IsLoggedInState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            Navigation.pushReplacement(MainPage(), MainPage.routeSettings);
          }
          if (state.status == AuthStatus.unauthenticated) {
            Navigation.pushReplacement(LoginPage(), LoginPage.routeSettings);
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  '${AppAssets.imagesPath}splash_image.png',
                  scale: 4,
                ),
                SizedBox(height: 40),
                Text(
                  'Jot down anything you want to achieve, remember or take note of.',
                  style: appTextTheme(
                    context,
                  ).headlineMedium!.copyWith(color: AppColor.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
