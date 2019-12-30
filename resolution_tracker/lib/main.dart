import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/models/auth_notifier.dart';
import 'package:resolution_tracker/models/resolutions_notifier.dart';
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


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AuthenticationNotifier>(
        builder: (context, authNotifier, child) {
          if (authNotifier.user == null)
            return WelcomePage();
          else
            return HomePage();
        }
      ),
    );
  }
}
