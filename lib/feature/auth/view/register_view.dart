import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/components/app_top_snackbar.dart';
import 'package:notes_app/core/routes/navigation.dart';
import 'package:notes_app/core/utils/global_state.dart';
import 'package:notes_app/feature/auth/logic/register/register_cubit.dart';
import 'package:notes_app/feature/auth/view/login_page.dart';
import 'package:notes_app/main.dart';

import '../../../core/components/app_button.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/theme/app_color.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _retypePasswordController;

  bool _isObsecure = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _retypePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        title: Text('Back to Login', style: appTextTheme(context).titleMedium),
      );
    }

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Register', style: appTextTheme(context).displayLarge),
          SizedBox(height: 10),
          Text(
            'Add start taking notes',
            style: appTextTheme(
              context,
            ).titleMedium!.copyWith(color: AppColor.neutral[500]),
          ),
        ],
      );
    }

    Widget nameForm() {
      return AppValidatorTextField(
        hintText: 'Input your FullName',
        labelText: 'Full Name',
        controller: _nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Name cannot be empty';
          }
          return null;
        },
      );
    }

    Widget emailForm() {
      return AppValidatorTextField(
        hintText: 'Input your email Address',
        labelText: 'Email Address',
        controller: _emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email cannot be empty';
          }
          return null;
        },
      );
    }

    Widget passForm() {
      return StatefulBuilder(
        builder: (context, setState) {
          return AppValidatorTextField(
            hintText: 'Input your password',
            controller: _passwordController,
            labelText: 'Password',
            isObscure: _isObsecure,
            suffixWidget: IconButton(
              icon: Icon(
                _isObsecure ? Icons.visibility : Icons.visibility_off,
                color: appColorScheme(context).primary,
              ),
              onPressed: () {
                setState(() {
                  _isObsecure = !_isObsecure;
                });
              },
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password cannot be empty';
              }
              return null;
            },
          );
        },
      );
    }

    Widget retypePassword() {
      return StatefulBuilder(
        builder: (context, setState) {
          return AppValidatorTextField(
            hintText: 'Input your password',
            labelText: 'Retype Password',
            controller: _retypePasswordController,
            isObscure: _isObsecure,
            suffixWidget: IconButton(
              icon: Icon(
                _isObsecure ? Icons.visibility : Icons.visibility_off,
                color: appColorScheme(context).primary,
              ),
              onPressed: () {
                setState(() {
                  _isObsecure = !_isObsecure;
                });
              },
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Retype password cannot be empty';
              }
              return null;
            },
          );
        },
      );
    }

    Widget buttonSubmit() {
      return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status.isFailed) {
            AppTopSnackBar(context).showDanger(state.message);
          }

          if (state.status.isLoaded) {
            AppTopSnackBar(context).showSuccess(state.message);
            Navigation.pushReplacement(LoginPage(), LoginPage.routeSettings);
          }
        },
        builder: (context, state) {
          if (state.status.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return DefaultButton(
            title: 'Register',
            backgroundColor: appColorScheme(context).primary,
            titleColor: appColorScheme(context).onSecondary,
            borderColor: appColorScheme(context).primary,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                if (_passwordController.text ==
                    _retypePasswordController.text) {
                  context.read<RegisterCubit>().register(
                    _nameController.text.trim(),
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                } else {
                  AppTopSnackBar(
                    context,
                  ).showInfo('Password and Retype Password must be same');
                }
              }
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 30,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                header(),
                nameForm(),
                emailForm(),
                passForm(),
                retypePassword(),
                buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
