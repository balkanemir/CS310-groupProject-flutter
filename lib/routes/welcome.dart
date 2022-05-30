import 'package:flutter/material.dart';
import 'package:flutterui/routes/signup.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/utils/styles.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: Dimension.regularPadding,
                child: RichText(
                  text: TextSpan(
                    text: "Welcome to ",
                    //style: kHeadingTextStyle,
                    children: const <TextSpan>[
                      TextSpan(
                        text: "Soulmate",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                          decorationThickness: 2.0,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Image.network('https://images-na.ssl-images-amazon.com/images/I/417MahKs6fL.png'),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Signup',
                          //style: kButtonLightTextStyle,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: secondaryPink800,
                      ),
                    ),
                  ),

                  SizedBox(width: 8.0,),

                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Login',
                          //style: kButtonDarkTextStyle,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: secondaryPink800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}