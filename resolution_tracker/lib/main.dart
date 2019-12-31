import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/models/auth_notifier.dart';
import 'package:resolution_tracker/res/colors.dart';
import 'package:resolution_tracker/res/dimens.dart';
import 'package:resolution_tracker/res/strings.dart';
import 'package:resolution_tracker/ui/homepage.dart';
import 'package:resolution_tracker/ui/welcome.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthenticationNotifier(),
      child: MyApp()
    ),
  );
} 



ShapeBorder bottomSheetShape = RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimens.SHAPE_LARGE_COMPONENT), topRight: Radius.circular(Dimens.SHAPE_LARGE_COMPONENT)));
ShapeBorder largeShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.SHAPE_LARGE_COMPONENT));

TextTheme appTextTheme = TextTheme(
  title: TextStyle(fontSize: 45.0, fontWeight: Dimens.FONT_WEIGHT_BOLD),
  headline: TextStyle(fontSize: 30, fontWeight: Dimens.FONT_WEIGHT_BOLD),
);


ColorScheme appColorScheme = ColorScheme(
  primary: ColorsApp.primaryColor,
  secondary: ColorsApp.secondaryColor,
  primaryVariant: ColorsApp.primaryColor,
  secondaryVariant: ColorsApp.secondaryColor,
  surface: Color(0xFFFFFFFF),
  background: Color(0xFFFFFFFF),
  error: ColorsApp.secondaryColor,
  onPrimary: Color(0xFF000000),
  onSecondary: Color(0xFF000000),
  onError: Color(0xFF000000),
  onSurface: Color(0xFF000000),
  onBackground: Color(0xFF000000),
  brightness: Brightness.light,
);

ThemeData appTheme = ThemeData(
  primaryColor: ColorsApp.primaryColor,

  colorScheme: appColorScheme,

  // Shape theming (small, medium large)
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.SHAPE_SMALL_CORNER_RADIUS))
  ),
  // inputDecorationTheme: ,
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.SHAPE_MEDIUM_CORNER_RADIUS))
  ),

  textTheme: appTextTheme,

);

///
///
/// Uses Material theming as follow :
/// * Type : 
/// * Shape :
///     - small component (e.g. btn) : rounded
/// 
/// Note : see this video of the Flutter Interact '19 -> https://www.youtube.com/watch?v=stoJpMeS5aY
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuthenticationRepository().logout(); // TODO : remove

    return MaterialApp(
      title: Strings.APP_NAME,
      theme: appTheme,
      home: Consumer<AuthenticationNotifier>(
          builder: (context, authNotifier, child) {
            if (!authNotifier.isInit)
              return LoadingWidget();
            if (authNotifier.user == null)
              return WelcomePage();
            else
              return HomePage();
          }
        ),
      
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          Text(Strings.LOADING_PAGE_INDICATOR),
          LinearProgressIndicator(value: null,),
        ],
      ),
    );
  }
}