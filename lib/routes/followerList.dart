import 'package:flutter/material.dart';
import 'package:flutterui/models/Follower.dart';
import 'package:flutterui/services/analytics.dart';
import 'package:flutterui/services/databaseRead.dart';
import 'package:flutterui/models/user1.dart';

class FollowerList extends StatelessWidget {
  static const String routeName = '/login';
  final List<Follower?>? followers;
  final title;
  const FollowerList({this.followers, required this.title});

  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Add_Post_Page", <String, dynamic>{});
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: GestureDetector(
          onTap: () {},
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            String input = title == "Followings"
                ? followers![index]!.followed
                : followers![index]!.user;
            return FutureBuilder<User1?>(
                future: readUserWithId(input),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong.');
                  }
                  if (snapshot.hasData && snapshot.data == null) {
                    return Text("Document does not exist");
                  } else {
                    return Row(
                      children: [
                        Image.network(snapshot.data!.profileImage,
                            height: 100, width: 100),
                        Text(snapshot.data!.username,
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    );
                  }
                });
          },
          itemCount: followers!.length),
    );
  }
}
