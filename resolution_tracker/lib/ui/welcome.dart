import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resolution_tracker/repositories/fb_authentication_repository.dart';
import 'package:resolution_tracker/res/colors.dart';
import 'package:resolution_tracker/res/dimens.dart';
import 'package:resolution_tracker/res/strings.dart';
import 'package:resolution_tracker/main.dart';


/// Welcome page, display to authenticate the user.
/// 
/// Tree :
///   - Welcome title
///   - App presentation
///   - Auth area
/// 
/// Note : navigation to the homepage when the user is logged
/// is handled directly by the root widget thanks to the provider
/// architecture.
///
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: appTheme.copyWith(
            colorScheme: appColorScheme.copyWith(
              primary: Color(0xFFFFFFFF),
              onPrimary: Color(0xFF000000),
              background: ColorsApp.primaryColor,
              onBackground: Color(0xFFFFFFFF),
            ),
            scaffoldBackgroundColor: ColorsApp.primaryColor,
  
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: Scaffold(
            body: SafeArea( // safe area is here to manage status and navigation bar color
              child: Padding(
                padding: Dimens.SCREEN_MARGIN,
                child: SizedBox.expand(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Text(Strings.WELCOME_TITLE, style: Theme.of(context).textTheme.title),
                      ),
                      SizedBox(height: Dimens.WELCOME_BLOCK_PADDING,),
                      AppPresentationWidget(),
                      Expanded(child: SizedBox()),
                      GoogleSignInButton(onPressed: handleGoogleSignIn)
                    ],
                  ),
                ),
              )
            ),
          ),
        )
    );
  }


  handleGoogleSignIn() {
    FirebaseAuthenticationRepository().signInWithGoogle()
      .then((_) => {})
      .catchError((e) => {});
  }
}

class AppPresentationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(Strings.WELCOME_INTRO1, style: Theme.of(context).textTheme.body1),
        SizedBox(height: Dimens.NORMAL_PADDING,),
        SvgPicture.asset(
          "assets/icon.svg",
          semanticsLabel: 'Confetti logo',
          width: 200,
        ),
        SizedBox(height: Dimens.NORMAL_PADDING,),
        Text(Strings.WELCOME_INTRO2, style: Theme.of(context).textTheme.body1),
        Text(Strings.WELCOME_INTRO3, style: Theme.of(context).textTheme.body1),
      ],
    );
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