import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:git_hub_tracker/authentication/logic/github_authenticator.dart';
import 'package:git_hub_tracker/authentication/view/partials/form_header.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/github_api/github_api.dart';
import 'package:git_hub_tracker/core/logic/routing/routes.dart';
import 'package:oauth2/oauth2.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child:
    Scaffold(
      body: SafeArea(
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
                height: kVerticalSpacer,
              ),
              Container(
                margin: const EdgeInsets.only(right: 75.0, left: 75.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      Future(() async {
                        await authenticator.isSignedIn().then((value){
                          if(value){
                            Navigator.of(context).pushNamed(kAuthRoute);
                          }
                        });
                      });

                      Navigator.pushNamed(context, kWebAuthPage);
                    },
                    child: const Text('Sign In')
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    onWillPop: () async {
      SystemNavigator.pop();
      return false;
    });
  }
  /// Function to manage Authentification Rooting
  void authStateNotifier(context) {
    Future(() async {
      Credentials? cred = await authenticator.getSignedInCredentials();

      print("GitHubAPIKey: ${cred == null ? null : cred.toJson().toString()}");

      if (await authenticator.isSignedIn()) {
        try {
          GitHubApiSingleTon.api = GitHubApi(cred!.accessToken);
        } catch (e) {
          print("Error Loading GithubAPI: " + e.toString());
        }

        Navigator.pushNamed(context, kHomeRoute);
      }
      else {
        Navigator.pushNamed(context, kLoginRoute);
      }
    });
  }
}




