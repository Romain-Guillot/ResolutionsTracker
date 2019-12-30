
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resolution_tracker/main.dart';
import 'package:resolution_tracker/models/models.dart';
import 'package:resolution_tracker/repositories/fb_authentication_repository.dart';
import 'package:resolution_tracker/res/dimens.dart';


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
        child: Row(
          children: <Widget>[
            if (widget.user.profileURL == null)
              Image.network(widget.user.profileURL),
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
            Text(widget.user.name.toUpperCase(), style: TextStyle(fontWeight: Dimens.FONT_WEIGHT_BOLD),)
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
            title: Text("Log out"), 
            leading: Icon(Icons.exit_to_app),
            onTap: onLogOut,
          ),
          ListTile(
            title: Text("Delete my account permanently"), 
            leading: Icon(Icons.delete_forever),
            onTap: () => onDeleteAccount(context),
          ),
        ],
      ),
      shape: bottomSheetShape
    );
  }

  onLogOut() {
    FirebaseAuthenticationRepository().logout(); // TODO : handle errors
    Navigator.pop(context);
  }

  onDeleteAccount(context) {
    Navigator.pop(context);
    showDialog(context: context, builder: (context) => AlertDialog(
      shape: largeShape,
      title: Text("Are you sure ?"),
      content: Text("Blah blah blah"),
      actions: <Widget>[
        RaisedButton(
          child: Text("Cancel"), 
          onPressed: () => Navigator.pop(context),),
        RaisedButton(
          child: Text("Yes !"), 
          onPressed: () async {
            await FirebaseAuthenticationRepository().delete();
            Navigator.pop(context);
            
          }),
      ],
    ));
  }
}