import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/models/auth_notifier.dart';
import 'package:resolution_tracker/models/resolutions_notifier.dart';
import 'package:resolution_tracker/res/colors.dart';
import 'package:resolution_tracker/ui/homepage.dart';
import 'package:resolution_tracker/ui/welcome.dart';


void main() {
  print("RUN");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationNotifier()),
        ChangeNotifierProvider(create: (context) => ResolutionsNotifier())
      ],
      child: MyApp()),
    );
} 


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: ColorsApp.primaryColor,
      ),
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
      children: <Widget>[
          Text("Please wait, we checked your profile."),
          LinearProgressIndicator(value: null,),
        ],
      ),
    );
  }
}