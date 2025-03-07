import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/settings/logic/get_current_user/get_current_user_cubit.dart';
import 'package:notes_app/feature/settings/logic/logout/logout_cubit.dart';
import 'package:notes_app/feature/settings/repository/setting_repository.dart';
import 'package:notes_app/feature/settings/view/settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/settings');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LogoutCubit(SettingRepositoryImpl.create()),
        ),
        BlocProvider(
          create: (_) => GetCurrentUserCubit(SettingRepositoryImpl.create()),
        ),
      ],
      child: SettingsView(),
    );
  }
}
