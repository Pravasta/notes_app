import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/components/app_button.dart';
import 'package:notes_app/core/components/app_top_snackbar.dart';
import 'package:notes_app/core/routes/navigation.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/utils/global_state.dart';
import 'package:notes_app/feature/auth/view/login_page.dart';
import 'package:notes_app/feature/settings/logic/get_current_user/get_current_user_cubit.dart';
import 'package:notes_app/feature/settings/logic/logout/logout_cubit.dart';
import 'package:notes_app/main.dart';

import '../../../core/utils/app_assets.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    context.read<GetCurrentUserCubit>().getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonLogout() {
      return BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state.status.isFailed) {
            AppTopSnackBar(context).showDanger('Logout failed');
          }

          if (state.status.isLoaded) {
            AppTopSnackBar(context).showSuccess('Logout success');
            Navigation.pushReplacement(LoginPage(), LoginPage.routeSettings);
          }
        },
        builder: (context, state) {
          if (state.status.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return DefaultButton(
            title: 'Logout',
            onTap: () {
              context.read<LogoutCubit>().logout();
            },
            backgroundColor: AppColor.redColor,
            borderColor: AppColor.redColor,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: appTextTheme(context).headlineSmall),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: BlocBuilder<GetCurrentUserCubit, GetCurrentUserState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.status.isFailed) {
              return Center(child: Text(state.message));
            }

            if (state.status.isLoaded) {
              final dataUser = state.user;

              return Column(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        '${AppAssets.iconsPath}profile.png',
                        scale: 2,
                      ),
                      SizedBox(height: 20),
                      Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            dataUser?.name ?? '',
                            style: appTextTheme(context).headlineMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mail_outline_outlined,
                                size: 20,
                                color: AppColor.neutral[500],
                              ),
                              SizedBox(width: 5),
                              Text(
                                dataUser?.email ?? '',
                                style: appTextTheme(
                                  context,
                                ).titleMedium!.copyWith(
                                  color: appColorScheme(context).onSurface,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Text(
                            'id: ${dataUser?.uid}',
                            style: appTextTheme(context).titleMedium!.copyWith(
                              color: appColorScheme(context).onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  buttonLogout(),
                ],
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
