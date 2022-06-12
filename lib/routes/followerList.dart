import 'package:flutter/material.dart';
import 'package:flutterui/models/follower1.dart';
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
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                snapshot.data?.profileImage ??
                                            "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                            ),
                          ),
                          SizedBox(
                            width: 75,
                          ),
                          Text("${snapshot.data?.username}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))
                        ],
                      ),
                    );
                  }
                });
          },
          itemCount: followers!.length),
    );
  }
}
