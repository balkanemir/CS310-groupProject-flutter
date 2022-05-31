import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/routes/notificationPage.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/routes/signup.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/routes/addpost.dart';
import 'package:flutterui/routes/walkthrough.dart';
import 'package:flutterui/routes/welcome.dart';
import 'package:flutterui/routes/wrapper.dart';
import 'package:flutterui/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutterui/models/User.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String initRoute = showHome ? '/login' : '/walkthrough';

  return runApp(SoulMate(initRoute: initRoute));
}

class SoulMate extends StatelessWidget {
  const SoulMate({Key? key, required this.initRoute}) : super(key: key);
  final String initRoute;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return StreamProvider<UserModel?>.value(
        initialData: null,
        value: AuthService().user,
        child: AuthenticationStatus(initRoute: initRoute));
  }
}

class AuthenticationStatus extends StatefulWidget {
  const AuthenticationStatus({Key? key, required this.initRoute})
      : super(key: key);
  final String initRoute;

  @override
  State<AuthenticationStatus> createState() => _AuthenticationStatusState();
}

class _AuthenticationStatusState extends State<AuthenticationStatus> {
  late String initRoute = "/welcome";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return MaterialApp(initialRoute: initRoute, home: Wrapper(), routes: {
        Welcome.routeName: (context) => Welcome(),
      });
    } else {
      return MaterialApp(initialRoute: initRoute, home: Wrapper(), routes: {
        Login.routeName: (context) => Login(),
        SignUp.routeName: (context) => SignUp(),
        WalkthroughScreen.routeName: (context) => const WalkthroughScreen(),
        Shuffle.routeName: (context) => Shuffle(),
        MainPage.routeName: (context) => MainPage(),
        Profile.routeName: (context) => Profile(),
        Search.routeName: (context) => Search(),
        NotificationPage.routeName: (context) => NotificationPage(),
        AddPost.routeName: (context) => AddPost(),
      });
    }

    return Container();
  }
}
