
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resolution_tracker/main.dart';
import 'package:resolution_tracker/res/dimens.dart';

class BasicScrollWithoutGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class SnackbarFactory {

  SnackbarFactory._();

  static _showSnackbar(BuildContext context, Widget content, Color background) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: content, 
        backgroundColor: background, 
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.SHAPE_MEDIUM_CORNER_RADIUS)),
      )
    );
  }

  static showSuccessSnackbar({@required BuildContext context, @required Widget content}) {
    _showSnackbar(context, content, Theme.of(context).colorScheme.primary);
  }

  static showErrorSnackbar({@required BuildContext context, @required Widget content}) {
    _showSnackbar(context, content, Theme.of(context).colorScheme.error);
  }
}


class AlertDialogFactory {
  static show({@required BuildContext context, @required Widget title, @required Widget content, @required Function onYes}) {
     showDialog(context: context, builder: (context) => AlertDialog(
      shape: largeShape,
      titleTextStyle: Theme.of(context).textTheme.headline,
      contentTextStyle: Theme.of(context).textTheme.body1,
      title: title,
      content: content,
      actions: <Widget>[
        RaisedButton(
          child: Text("Cancel"), 
          onPressed: () => Navigator.pop(context)),
        RaisedButton(
          child: Text("Yes !"), 
          onPressed: onYes
        )
      ],
    ));
  }
}


class ListItemMenu extends StatefulWidget {
  final Widget content;
  final List<Widget> actions;
  final Color background;

  ListItemMenu({@required this.content, @required this.actions, this.background});

  @override
  _ListItemMenuState createState() => _ListItemMenuState();
}


class _ListItemMenuState extends State<ListItemMenu> {

  GlobalKey _key = GlobalKey();
  bool menuIsShown = false;
  Size sizePriorMenuIsShown;


  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      color: widget.background??Colors.transparent,
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onLongPress: menuIsShown ? null : showMenu,
          onTap: menuIsShown ? hideMenu : null,
          child: 
            menuIsShown 
            ? SizedBox(
                width: sizePriorMenuIsShown?.width??double.infinity,
                height: sizePriorMenuIsShown?.height??50,
                child: Center(
                  child: Wrap(
                    spacing: 40,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: widget.actions
                  )
                ),
              )
            : widget.content
        ),
      ),
    );
  }

  showMenu() {
    // we get the content widget size (to show a menu with the same dimensions)
    final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
    sizePriorMenuIsShown = renderBoxRed.size;
    setState(() => menuIsShown = true);
  }

  hideMenu() {
    setState(() => menuIsShown = false);
  }
}