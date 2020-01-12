import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/models/auth_notifier.dart';
import 'package:resolution_tracker/models/models.dart';
import 'package:resolution_tracker/models/resolutions_notifier.dart';
import 'package:resolution_tracker/res/colors.dart';
import 'package:resolution_tracker/res/dimens.dart';
import 'package:resolution_tracker/res/strings.dart';
import 'package:resolution_tracker/ui/resolution_edition.dart';
import 'package:resolution_tracker/ui/user_widget.dart';
import 'package:resolution_tracker/ui/utils.dart';


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
              ScrollConfiguration(
                behavior: BasicScrollWithoutGlow(), // to remove glow effect when srolling
                child: ListView.builder(
                  itemCount: resolutionsProvider.length,
                  itemBuilder: (context, position) => 
                    ResolutionItem(
                      resolution: resolutionsProvider.resolutions.elementAt(position),
                      background: position % 2 == 0 ? Colors.transparent : Colors.grey[200],
                    )
                ),
              ),
          )
        ),
      )
    );
  }


  handleNewResolutionButton(context) {
    ResolutionEditionWidget.show(context);
  }
}


class ResolutionItem extends StatelessWidget {

  final Resolution resolution;
  final Color background;

  ResolutionItem({@required this.resolution, this.background});

  @override
  Widget build(BuildContext context) {
    return ListItemMenu(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit, color: ColorsApp.editIconColor),
          onPressed: () => onEdit(context),
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          onPressed: () => onDelete(context),
        )
      ],
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.SCREEN_MARGIN_X, vertical: Dimens.NORMAL_PADDING),
        child: Text(resolution.title, style: Theme.of(context).textTheme.display1,),
      ),
      background: background,
    );      
  }

  onEdit(context) {
    ResolutionEditionWidget.show(context, resolution: resolution);
  }

  onDelete(context) {
    AlertDialogFactory.show(
      context: context,
      title: Text(Strings.DELETE_RESOLUTION_TITLE),
      content: Text(Strings.DELETE_RESOLUTION_INFO),
      onYes: () async {
        await Provider.of<ResolutionsNotifier>(context, listen: false).deleteResolution(resolution.id);
        Navigator.pop(context);
      }
    );
  }


}





