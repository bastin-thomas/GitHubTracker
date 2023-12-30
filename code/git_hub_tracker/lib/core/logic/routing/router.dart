import 'package:git_hub_tracker/Core/Logic/Routing/routes.dart';
import 'package:flutter/material.dart';

import 'package:git_hub_tracker/Core/View/waiting_page.dart';
import 'package:git_hub_tracker/authentication/view/login_page.dart';
import 'package:git_hub_tracker/feeds/view/feed_page.dart';

Map<String, WidgetBuilder> router = {
  kLoginRoute: (context) =>  const LoginPage(),
  kHomeRoute:  (context) =>  const FeedPage(),
  kWaitingRoute: (context) => WaitingPage(),
};