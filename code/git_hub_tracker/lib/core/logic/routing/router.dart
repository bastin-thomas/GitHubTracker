import 'package:flutter/material.dart';
import 'package:git_hub_tracker/authentication/view/authorization_page.dart';

import 'package:git_hub_tracker/core/logic/routing/routes.dart';

import 'package:git_hub_tracker/authentication/view/sign_in_page.dart';
import 'package:git_hub_tracker/core/View/splash_page.dart';
import 'package:git_hub_tracker/feeds/view/feed_page.dart';


Map<String, WidgetBuilder> router = {
  kLoginRoute: (context) =>  const SignInPage(),
  kHomeRoute:  (context) =>  const FeedPage(),
  kAuthRoute: (context) => const SplashPage(),
  kWebAuthPage: (context) => const AuthorizationPage(),
};



final routeObserver = MyRouteObserver();

class MyRouteObserver extends NavigatorObserver {
  final Set<RouteAware> _listeners = <RouteAware>{};

  void subscribe(RouteAware routeAware) {
    _listeners.add(routeAware);
  }

  void unsubscribe(RouteAware routeAware) {
    _listeners.remove(routeAware);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    for (var listener in _listeners) {
      if(kAuthRoute == route.toString()){
        listener.didPop();
      }
    }
  }
}