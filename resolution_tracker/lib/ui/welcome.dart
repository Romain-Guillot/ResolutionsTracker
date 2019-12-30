

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resolution_tracker/repositories/fb_authentication_repository.dart';
import 'package:resolution_tracker/res/colors.dart';
import 'package:resolution_tracker/res/dimen.dart';
import 'package:resolution_tracker/res/strings.dart';
import 'package:resolution_tracker/main.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: appTheme.copyWith(
            colorScheme: appColorScheme.copyWith(
              primary: Color(0xFFFFFFFF),
              onPrimary: Color(0xFF000000),
              onSurface: Color(0xFF000000),
              onBackground: Color(0xFFFFFFFF)
            )
        ),
        child: Scaffold(
        backgroundColor: ColorsApp.primaryColor,
        body: Column(
          children: <Widget>[
            GoogleSignInButton(onPressed: handleGoogleSignIn)
          ],
        )
      ),
    );
  }


  handleGoogleSignIn() {
    FirebaseAuthenticationRepository().signInWithGoogle();
  }
}


class GoogleSignInButton extends StatelessWidget {

  final Function onPressed;

  GoogleSignInButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          text: Strings.PROVIDER_AUTH_BTN,
          children: [TextSpan(
            text: " " + Strings.GOOGLE_PROVIDER,
            style: TextStyle(fontWeight: Dimens.FONT_WEIGHT_BOLD)
          )]
        ),
      ),
      onPressed: onPressed,
    );
  }
}