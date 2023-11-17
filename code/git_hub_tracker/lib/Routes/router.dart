import 'package:flutter/foundation.dart';
import 'package:git_hub_tracker/Routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:git_hub_tracker/screens/FeedPage.dart';
import 'package:git_hub_tracker/screens/LoginPage.dart';
import 'package:git_hub_tracker/screens/WaitingPage.dart';

Map<String, WidgetBuilder> router = {
  kLoginRoute: (context) =>  LoginPage(),
  kHomeRoute:  (context) =>  const FeedPage(),
  kWaitingRoute: (context) => WaitingPage(),
};