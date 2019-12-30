import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/models/auth_notifier.dart';
import 'package:resolution_tracker/models/resolutions_notifier.dart';
import 'package:resolution_tracker/res/colors.dart';
import 'package:resolution_tracker/res/dimen.dart';
import 'package:resolution_tracker/res/strings.dart';
import 'package:resolution_tracker/ui/homepage.dart';
import 'package:resolution_tracker/ui/welcome.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationNotifier()),
        ChangeNotifierProvider(create: (context) => ResolutionsNotifier())
      ],
      child: MyApp()),
    );
} 


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
  // cardTheme: ,

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
    return MaterialApp(
      title: Strings.APP_NAME,
      theme: appTheme,
      home: SafeArea(
          child: Consumer<AuthenticationNotifier>(
          builder: (context, authNotifier, child) {
            if (!authNotifier.isInit)
              return LoadingWidget();
            if (authNotifier.user == null)
              return WelcomePage();
            else
              return HomePage();
          }
        ),
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