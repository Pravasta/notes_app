import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/auth/logic/login/login_cubit.dart';
import 'package:notes_app/feature/auth/repository/auth_repository.dart';
import 'package:notes_app/feature/auth/view/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/login');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(AuthRepositoryImpl.create()),
      child: LoginView(),
    );
  }
}
