import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:resolution_tracker/res/dimens.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        floatingActionButton: Builder(
            builder: (context) => Padding(
            padding: Dimens.SCREEN_MARGIN,
            child: FloatingActionButton(
              
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(Icons.add),
              onPressed: () => handleNewResolutionButton(context),
            ),
          ),
        ),
        body: SafeArea( // safe area is here to manage status and navigation bar color
          child: Text("")
        ),
    ));
  }


  handleNewResolutionButton(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (context) => Text("OK"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimens.SHAPE_LARGE_COMPONENT), topRight: Radius.circular(Dimens.SHAPE_LARGE_COMPONENT)))
    );
  }
}