import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Routes/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:git_hub_tracker/screens/FeedPage.dart';
import 'package:git_hub_tracker/screens/LoginPage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: router,
      title: 'GitHub Tracker',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          surface: Colors.black,
          onSurface: Colors.white,

          // Colors that are not relevant to AppBar in DARK mode:
          primary: Colors.grey,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          secondary: Colors.grey,
          background: Colors.grey,
          onBackground: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
        ),

        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),

        dividerTheme: const DividerThemeData(
          space: 10,
          thickness: 1,
          color: Colors.pink,
          indent: 0,
          endIndent: 0,
        ),
      ),
    );
  }
}


// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (FirebaseAuth.instance.currentUser?.uid != null) {
//       return const FeedPage();
//     }
//     return LoginPage();
//   }
// }