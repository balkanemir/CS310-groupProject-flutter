import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/routes/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/routes/notificationPage.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/followerList.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/routes/signup.dart';
import 'package:flutterui/routes/addpost.dart';
import 'package:flutterui/routes/walkthrough.dart';
import 'package:flutterui/routes/welcome.dart';
import 'package:flutterui/routes/wrapper.dart';
import 'package:flutterui/services/auth.dart';
import 'package:flutterui/services/block_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'package:provider/provider.dart';

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
    final user = Provider.of<User1?>(context);
    return StreamProvider<User1?>.value(
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
    final user = Provider.of<User1?>(context);
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

Stream<List<User1>> readUsers() =>
    FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User1.fromJson(doc.data())).toList());

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
  final docUser = FirebaseFirestore.instance.collection('users');

  final user = User1(
    userID: id,
    email: email,
    profileImage: profile_image,
    bio: bio,
    followers: followers,
    following: following,
    name: name,
    surname: surname,
    username: username,
    MBTI: MBTI_type,
    isPrivate: false,
  );
  final json = user.toJson();

  await docUser.doc(id).set(json);

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
        "isPrivate": false,
      };

  User1 fromJson(Map<String, dynamic> json) => User1(
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
        isPrivate: json["isPrivate"],
      );
}

Future<User1?> readUser() async {
  final FirebaseAuth auth = await FirebaseAuth.instance;
  var uid = await auth.currentUser!.uid;
  User1 user = User1(
      MBTI: "",
      profileImage: "",
      followers: 0,
      following: 0,
      userID: "",
      name: "",
      surname: "",
      email: "",
      username: "",
      isPrivate: false);
  await FirebaseFirestore.instance
      .collection('users')
      .where("userID", isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      user.profileImage = doc["profileImage"];
      user.userID = doc["userID"];
      user.username = doc["username"];
      user.name = doc["name"];
      user.surname = doc["surname"];
      user.MBTI = doc["MBTI"];
      user.followers = doc["followers"];
      user.following = doc["following"];
      user.email = doc["email"];
      user.isPrivate = doc["isPrivate"];
    });
  });
  return user;
}
