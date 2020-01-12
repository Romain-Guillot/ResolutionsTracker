
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/main.dart';
import 'package:resolution_tracker/models/auth_notifier.dart';
import 'package:resolution_tracker/models/models.dart';
import 'package:resolution_tracker/res/assets.dart';
import 'package:resolution_tracker/res/dimens.dart';
import 'package:resolution_tracker/res/strings.dart';



class ProfileButtonWidget extends StatefulWidget {
  final User user;

  ProfileButtonWidget({Key key, @required this.user}) : super(key: key);

  @override
  _ProfileButtonWidgetState createState() => _ProfileButtonWidgetState();
}


class _ProfileButtonWidgetState extends State<ProfileButtonWidget> {

  bool deleteAccountSwitchState = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99),
      child: Row(
        children: <Widget>[
          if (widget.user.profileURL == null)
            Icon(Icons.account_circle, size: 25),
          if (widget.user.profileURL != null)
            ClipOval(
              child: Image.network(
                widget.user.profileURL,
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              )
            ),
          SizedBox(width: Dimens.SMALL_PADDING,),
          Text(widget.user.name.toUpperCase(), style: TextStyle(fontWeight: Dimens.FONT_WEIGHT_BOLD, fontSize: 13),)
        ],
      ),
      onTap: () => onClick(context),
    );
  }

  onClick(context) {
    showModalBottomSheet(context: context, builder: (context) =>
      Wrap(
        children: <Widget>[
          ListTile(
            title: Text("Buy me a coffee"),
            leading: SvgPicture.asset(Assets.COFFEE, height: Dimens.MENU_ICON_SIZE),
          ),
          ListTile(
            title: Text("Log out"), 
            leading: Icon(Icons.exit_to_app, size: Dimens.MENU_ICON_SIZE),
            onTap: onLogOut,
          ),
          ListTile(
            title: Text("Delete my account permanently"), 
            leading: Icon(Icons.delete_forever, size: Dimens.MENU_ICON_SIZE),
            onTap: onDeleteAccount,
          ),
        ],
      ),
      shape: bottomSheetShape
    );
  }

  onLogOut() {
    Provider.of<AuthenticationNotifier>(context, listen: false).logout(); // TODO : handle errors
    Navigator.pop(context);
  }

  onDeleteAccount() {
    Navigator.pop(context);
    showDialog(context: context, builder: (context) => AlertDialog(
      shape: largeShape,
      title: Text(Strings.DELETE_ACCOUNT_TITLE),
      titleTextStyle: Theme.of(context).textTheme.headline,
      contentTextStyle: Theme.of(context).textTheme.body1,
      content: Text(Strings.DELETE_ACCOUNT_INFO),
      actions: <Widget>[
        RaisedButton(
          child: Text("Cancel"), 
          onPressed: () => Navigator.pop(context),),
        RaisedButton(
          child: Text("Yes !"), 
          onPressed: () async {
            await Provider.of<AuthenticationNotifier>(context, listen: false).delete();
            Navigator.pop(context);
            
          }),
      ],
    ));
  }
}