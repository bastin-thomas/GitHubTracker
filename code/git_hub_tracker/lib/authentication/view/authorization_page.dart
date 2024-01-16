
import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Core/constants/secret_consts.dart';
import 'package:git_hub_tracker/authentication/logic/github_authenticator.dart';
import 'package:git_hub_tracker/authentication/logic/github_oauth_http_client.dart';
import 'package:git_hub_tracker/core/logic/routing/routes.dart';
import 'package:oauth2/oauth2.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';

class AuthorizationPage extends StatefulWidget {

  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {

  late AuthorizationCodeGrant grant;
  late Uri authorizationUrl;

  @override
  void initState() {
    WebViewCookieManager().clearCookies();

    grant = AuthorizationCodeGrant(
      SecretConsts.clientId,
      SecretConsts.authEndPoint,
      SecretConsts.tokenEndPoint,
      secret: SecretConsts.clientSecret,
      httpClient: GitHubOAuthHttpClient(),
    );

    authorizationUrl = grant.getAuthorizationUrl(SecretConsts.redirectUrl, scopes: SecretConsts.scopes);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final WebViewController controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..clearCache()
        ..clearLocalStorage()
        ..setBackgroundColor(kMainBackgroundColor)
        ..loadRequest(authorizationUrl)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {},
            onPageFinished: (String url) {

            },
            onWebResourceError: (WebResourceError error) {},

            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith(SecretConsts.redirectUrl.toString())) {

                Future(() async {
                  await authenticator.signIn(grant, Uri.parse(request.url).queryParameters);
                }).then((value){
                  Navigator.pushNamed(context, kAuthRoute);
                });
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        );

    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
      );
  }
}
