import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/models/auth_notifier.dart';
import 'package:resolution_tracker/models/models.dart';
import 'package:resolution_tracker/models/resolutions_notifier.dart';
import 'package:resolution_tracker/res/dimens.dart';
import 'package:resolution_tracker/ui/resolution_edition.dart';
import 'package:resolution_tracker/main.dart';
import 'package:resolution_tracker/ui/user_widget.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.SCREEN_MARGIN_X),
            child: Row(
              children: <Widget>[
                ProfileButtonWidget(user: Provider.of<AuthenticationNotifier>(context).user,),
                Expanded(child: SizedBox(),),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.add),
                  onPressed: () => handleNewResolutionButton(context),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea( // safe area is here to manage status and navigation bar color
          child: Consumer<ResolutionsNotifier>(
            builder: (context, resolutionsProvider, child) =>
              ListView.builder(
                itemCount: resolutionsProvider.length,
                itemBuilder: (context, position) => 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.SCREEN_MARGIN_X, vertical: Dimens.NORMAL_PADDING),
                    color: position % 2 == 0 ? Colors.transparent : Colors.grey[200], 
                    child: ResolutionItem(resolutionsProvider.resolutions.elementAt(position))
                  ),
              ),
          )
        ),
      )
    );
  }


  handleNewResolutionButton(context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) =>  ResolutionEditionWidget(),
      shape: bottomSheetShape 
    );
  }
}

class ResolutionItem extends StatelessWidget {

  final Resolution resolution;

  ResolutionItem(this.resolution);

  @override
  Widget build(BuildContext context) {
    return Text(resolution.title);
  }
}





