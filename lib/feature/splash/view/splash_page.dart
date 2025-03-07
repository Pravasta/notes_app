import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/splash/logic/is_logged_in/is_logged_in_cubit.dart';
import 'package:notes_app/feature/splash/repository/splash_repository.dart';
import 'package:notes_app/feature/splash/view/splash_view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/splash');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IsLoggedInCubit(SplashRepositoryImpl.create()),
      child: SplashView(),
    );
  }
}
