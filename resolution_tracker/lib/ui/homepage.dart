import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/main.dart';
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
        key: scaffoldKey,
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
                  key: GlobalKey(),
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
          onPressed: onDelete,
        )
      ],
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.SCREEN_MARGIN_X, vertical: Dimens.NORMAL_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(resolution.title, style: Theme.of(context).textTheme.display1),
            SizedBox(height: Dimens.NORMAL_PADDING),
            ResolutionCounters(successCounter: resolution.success, failedCounter: resolution.failed),
            if (true)
              ...[
                SizedBox(height: Dimens.NORMAL_PADDING),
                GestureDetector( // to ignore parent click listeners (open menu for example)
                  onLongPress: () {},
                  onTap: () {},
                  child: ResolutionChecker()
                ),
              ]
            
          ],
        ),
      ),
      background: background,
    );
  }

  onEdit(context) {
    ResolutionEditionWidget.show(context, resolution: resolution);
  }

  onDelete() {
    var context = scaffoldKey.currentContext;
    AlertDialogFactory.show(
      context: scaffoldKey.currentContext,
      title: Text(Strings.DELETE_RESOLUTION_TITLE),
      content: Text(Strings.DELETE_RESOLUTION_INFO),
      onYes: () async {
        await Provider.of<ResolutionsNotifier>(context, listen: false).deleteResolution(resolution.id)
          .then((_) => print("Success"))
          .catchError((e) => print(e))
          .whenComplete(() => Navigator.pop(context));
      }
    );
  }
}

class ResolutionCounters extends StatelessWidget {

  final int successCounter;
  final int failedCounter;

  ResolutionCounters({@required this.successCounter, @required this.failedCounter});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: counterText(context, counter: successCounter, label: "jours tenus !", color: Colors.green)
        ),
        Expanded(
          flex: 1,
          child: counterText(context, counter: failedCounter, label: "jours manqués", color: Theme.of(context).colorScheme.error)
        )
      ],
    );
  }

  Widget counterText(context, {@required num counter, @required String label, @required Color color}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: color, fontSize: 20, fontWeight: Dimens.FONT_WEIGHT_BOLD),
        text: counter.toString(),
        children: [TextSpan(
          text: " " + label, 
          style: Theme.of(context).textTheme.overline
        )]
      ),
    );
  }
}

class ResolutionChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimens.SHAPE_MEDIUM_CORNER_RADIUS),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 5.0, spreadRadius: 1.0, offset: Offset(3, 3),)]
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text("12 janvier".toUpperCase(), style: TextStyle(fontSize: 13, fontWeight: Dimens.FONT_WEIGHT_BOLD),)),
          FlatButton.icon(
            icon: Icon(Icons.check, color: Colors.green,),
            label: Text("J'ai tenu !"),
            textColor: Colors.green,
            onPressed: () {},
          ),
          FlatButton(
            child: Icon(Icons.close, color: Theme.of(context).colorScheme.error),
            textColor: Theme.of(context).colorScheme.error,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}





