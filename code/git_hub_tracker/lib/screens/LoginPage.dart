import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Routes/routes.dart';
import 'package:git_hub_tracker/partials/button.dart';
import 'package:git_hub_tracker/styles/constants.dart';
import 'package:git_hub_tracker/partials/form_header.dart';
import 'package:github/github.dart';
import 'package:github/hooks.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:git_hub_tracker/UtilityLib/API_Exchange_Code.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _loginFormKey = GlobalKey<FormState>();
  String? _errorMessage;

  late Auth0 auth0 = Auth0(Auth0_Domain, Auth0_ClientId);

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

                        try {
                          final Credentials credentials = await auth0.webAuthentication(scheme: appScheme).login();
                          //accessToken = await exchangeAuthCodeForAccessToken(credentials.accessToken);

                          GitHub github = GitHub(auth: Authentication.withToken(credentials.accessToken));
                          github.users.getCurrentUser();
                          CurrentUser user = await github.users.getCurrentUser();
                          print(user.url);

                        } on Exception catch (e, s) {
                          debugPrint('login error: $e - stack: $s');
                          _errorMessage = e.toString();
                        }
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
