import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/models/post1.dart';
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
import 'package:flutterui/services/block_observer.dart';
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

  String initRoute = showHome ? '/welcome' : WalkthroughScreen.routeName;
  BlocOverrides.runZoned(
    () => runApp(SoulMate(initRoute: initRoute)),
    blocObserver: AppBlocObserver(),
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
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
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return MaterialApp(
          initialRoute: widget.initRoute,
          home: Wrapper(),
          routes: {
            WalkthroughScreen.routeName: (context) => WalkthroughScreen(),
            Welcome.routeName: (context) => Welcome(),
          });
    } else {
      return MaterialApp(
          initialRoute: widget.initRoute,
          home: Wrapper(),
          routes: {
            Login.routeName: (context) => Login(),
            SignUp.routeName: (context) => SignUp(),
            WalkthroughScreen.routeName: (context) => WalkthroughScreen(),
            Shuffle.routeName: (context) => Shuffle(),
            MainPage.routeName: (context) => MainPage(),
            //Profile.routeName: (context) => Profile(),
            Search.routeName: (context) => Search(),
            NotificationPage.routeName: (context) => NotificationPage(),
            AddPost.routeName: (context) => AddPost(),
          });
    }

    return Container();
  }
}

Stream<List<User>> readUsers() =>
    FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

Future createUser(
    {required String id,
    required String email,
    required String profile_image,
    required int followers,
    required int following,
    required String bio,
    required String name,
    required String username,
    required String surname,
    required String MBTI_type}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();

  final user = User(
    userID: docUser.id,
    email: email,
    profileImage: profile_image,
    bio: bio,
    followers: followers,
    following: following,
    name: name,
    surname: surname,
    username: username,
    MBTI: MBTI_type,
  );
  final json = user.toJson();

  await docUser.set(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'profile_image': profile_image,
        'bio': bio,
        'followers': followers,
        'following': following,
        'name': name,
        'surname': surname,
        'username': username,
        'MBTI_type': MBTI_type,
      };

  User fromJson(Map<String, dynamic> json) => User(
        userID: json['id'],
        email: json['email'],
        profileImage: json['profileImage'],
        bio: json['bio'],
        followers: json['followers'],
        following: json['following'],
        name: json['name'],
        surname: json['surname'],
        username: json['username'],
        MBTI: json['MBTI'],
      );
}

Future<User?> readUser() async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return User.fromJson(snapshot.data()!);
  }
}

