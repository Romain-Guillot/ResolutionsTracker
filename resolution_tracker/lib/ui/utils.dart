
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onLongPress: menuIsShown ? null : showMenu,
          onTap: menuIsShown ? hideMenu : null,
          child: 
            menuIsShown 
            ? SizedBox(
                width: sizePriorMenuIsShown.width,
                height: sizePriorMenuIsShown.height,
                child: Center(
                  child: Wrap(
                    spacing: 20,
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
    final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
    sizePriorMenuIsShown = renderBoxRed.size;
    setState(() => menuIsShown = true);
  }

  hideMenu() {
    setState(() => menuIsShown = false);
  }
}