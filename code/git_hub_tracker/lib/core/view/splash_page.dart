

import 'package:flutter/material.dart';
import 'package:git_hub_tracker/authentication/logic/github_authenticator.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/github_api.dart';
import 'package:git_hub_tracker/core/logic/routing/router.dart';
import 'package:git_hub_tracker/authentication/view/partials/form_header.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/routing/routes.dart';
import 'package:oauth2/oauth2.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with RouteAware{
  @override
  void initState() {
    routeObserver.subscribe(this);
    super.initState();
    authStateNotifier(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: FormHeader(),
              ),
              SizedBox(
                height: kVerticalSpacer * 2,
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        authStateNotifier(context);
      },
    );
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

  @override
  void didPopNext() {
    authStateNotifier(context);
  }

  @override
  void didPush() {
    authStateNotifier(context);
  }

  @override
  void didPop() {
    authStateNotifier(context);
  }

  @override
  void didPushNext() {
    authStateNotifier(context);
  }
}
