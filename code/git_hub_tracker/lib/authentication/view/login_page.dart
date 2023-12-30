import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Core/View/partials/button.dart';
import 'package:git_hub_tracker/authentication/view/partials/form_header.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _loginFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalSpacer,
              vertical: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: FormHeader(),
                ),
                const SizedBox(
                  height: kVerticalSpacer * 2,
                ),
                Button(
                    label: "Se connecter",
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        String? accessToken;


                      }
                    }),
                Text(_errorMessage ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
