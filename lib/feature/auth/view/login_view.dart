import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/components/app_button.dart';
import 'package:notes_app/core/components/app_text_field.dart';
import 'package:notes_app/core/components/app_top_snackbar.dart';
import 'package:notes_app/core/routes/navigation.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/utils/global_state.dart';
import 'package:notes_app/feature/auth/logic/login/login_cubit.dart';
import 'package:notes_app/feature/main/view/main_page.dart';
import 'package:notes_app/main.dart';

import 'register_page.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isObsecure = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Let\'s Login', style: appTextTheme(context).displayLarge),
          SizedBox(height: 10),
          Text(
            'Add notes your ideas',
            style: appTextTheme(
              context,
            ).titleMedium!.copyWith(color: AppColor.neutral[500]),
          ),
        ],
      );
    }

    Widget emailForm() {
      return AppValidatorTextField(
        hintText: 'Input your email Address',
        controller: _emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email cannot be empty';
          }
          return null;
        },
        labelText: 'Email Address',
      );
    }

    Widget passForm() {
      return StatefulBuilder(
        builder: (context, setState) {
          return AppValidatorTextField(
            hintText: 'Input your password',
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password cannot be empty';
              }
              return null;
            },
            isObscure: _isObsecure,
            suffixWidget: IconButton(
              onPressed: () {
                setState(() {
                  _isObsecure = !_isObsecure;
                });
              },
              icon: Icon(
                _isObsecure ? Icons.visibility : Icons.visibility_off,
                color: AppColor.neutral[500],
              ),
            ),
            labelText: 'Password',
          );
        },
      );
    }

    Widget buttonSubmit() {
      return BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return DefaultButton(
            title: 'Login',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginCubit>().login(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              }
            },
            backgroundColor: appColorScheme(context).primary,
            titleColor: appColorScheme(context).onSecondary,
            borderColor: appColorScheme(context).primary,
          );
        },
        listener: (context, state) {
          if (state.status.isFailed) {
            AppTopSnackBar(context).showDanger(state.message);
          }

          if (state.status.isLoaded) {
            AppTopSnackBar(context).showSuccess("Login Success");
            Navigation.pushReplacement(MainPage(), MainPage.routeSettings);
          }
        },
      );
    }

    Widget buttonRegister() {
      return Center(
        child: TextButton(
          onPressed: () {
            Navigation.push(RegisterPage(), RegisterPage.routeSettings);
          },
          child: Text(
            'Don\'t have any account? Register here',
            style: appTextTheme(
              context,
            ).titleSmall!.copyWith(color: AppColor.neutral),
          ),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              header(),
              emailForm(),
              passForm(),
              buttonSubmit(),
              buttonRegister(),
            ],
          ),
        ),
      ),
    );
  }
}
