import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resolution_tracker/main.dart';
import 'package:resolution_tracker/models/models.dart';
import 'package:resolution_tracker/models/resolutions_notifier.dart';
import 'package:resolution_tracker/res/dimens.dart';
import 'package:resolution_tracker/res/strings.dart';
import 'package:resolution_tracker/ui/utils.dart';



class ResolutionEditionWidget extends StatefulWidget {

  final Resolution resolution;

  ResolutionEditionWidget({Key key, this.resolution}) : super(key: key);

  @override
  _ResolutionEditionWidgetState createState() => _ResolutionEditionWidgetState();

  static show(BuildContext context, {Resolution resolution}) {
    showModalBottomSheet(
      context: context, 
      builder: (_) =>  ResolutionEditionWidget(resolution: resolution),
      shape: bottomSheetShape,
    );
  }
}


class _ResolutionEditionWidgetState extends State<ResolutionEditionWidget> {

  final _formKey = GlobalKey<FormState>();

  FrequencyFormController frequencyController;
  TextEditingController titleController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    frequencyController =FrequencyFormController();
    titleController = TextEditingController(text: widget.resolution?.title);
    print(widget.resolution?.title);
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: ScrollConfiguration(
                behavior: BasicScrollWithoutGlow(),
                child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    autofocus: widget.resolution == null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration.collapsed(hintText: Strings.ADD_RESOLUTION_TITLE_LABEL), 
                    style: TextStyle(fontSize: 27, fontWeight: Dimens.FONT_WEIGHT_BOLD),
                    validator: (value) => value.isNotEmpty ? null : Strings.ADD_RESOLUTION_TITLE_EMPTY_ERROR,
                  ),
                  SizedBox(height: Dimens.NORMAL_PADDING,),
                  Text(Strings.ADD_RESOLUTION_FREQUENCY_LABEL, style: Theme.of(context).textTheme.subtitle),
                  SizedBox(height: Dimens.NORMAL_PADDING,),
                  Center(
                    child: FrequencyFormField(controller: frequencyController,)
                  ),
                  SizedBox(height: Dimens.NORMAL_PADDING,),
                  Text(Strings.ADD_RESOLTUION_ICON_LABEL, style: Theme.of(context).textTheme.subtitle),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              textColor: Theme.of(context).colorScheme.primary,
              child: Text(
                isLoading ? "Loading ..." : Strings.ADD_RESOLUTION_SUBMIT, 
                style: TextStyle(fontWeight: Dimens.FONT_WEIGHT_BOLD),
              ), 
              onPressed: isLoading ? null : submit,
            )
          )
        ]
      ),
    );
  }

  submit() {
    if (!isLoading && _formKey.currentState.validate()) {
      setState(() => isLoading = true);
      Resolution resolution = Resolution.create(titleController.text, null, frequencyController.values);
      Provider.of<ResolutionsNotifier>(context, listen: false).addResolution(resolution)
        .then((_) {
          Navigator.pop(context);
          // SnackbarFactory.showSuccessSnackbar(context: scaffoldKey.currentContext, content: Text(Strings.ADD_RESOLUTION_SUCCESS(titleController.text)));
        })
        .catchError((e) {
          print("errore" + e.toString());
          // SnackbarFactory.showErrorSnackbar(context: context, content: Text(Strings.ADD_RESOLUTION_ERROR));
        })
        .whenComplete(() => setState(() => isLoading = false));
    }
  }
}




class FrequencyFormField extends FormField<List<DaysEnum>> {

  final FrequencyFormController controller;
  
  FrequencyFormField({@required this.controller}) : super(
    builder: (state) => Wrap(
      children: DaysEnum.values().map((d) => 
          SelectableDay(
            day: d,
            onSelected: () { 
              (state as _FrequencyFormFieldState).add(d); 
              FocusScope.of(state.context).requestFocus(FocusNode());
            },
            onDeselected: () {
              (state as _FrequencyFormFieldState).remove(d);
              FocusScope.of(state.context).requestFocus(FocusNode());
            },
          )
        ).toList(),
    )
  );

  @override
  FormFieldState<List<DaysEnum>> createState() {
    return _FrequencyFormFieldState();
  }
}


class SelectableDay extends StatefulWidget {

  final DaysEnum day;
  final Function onSelected;
  final Function onDeselected;
  final bool initialSelected;


  SelectableDay({this.day, this.onSelected, this.onDeselected, this.initialSelected = false});

  @override
  _SelectableDayState createState() => _SelectableDayState(initialSelected);
}


class _SelectableDayState extends State<SelectableDay> {

  bool selected;

  _SelectableDayState(this.selected);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme.fromButtonThemeData(
      data: Theme.of(context).buttonTheme.copyWith(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(12)
      ),
      child: FlatButton(
        child: Text(widget.day.value.substring(0,2), 
            style: TextStyle(
              fontSize: 16, 
              fontWeight: Dimens.FONT_WEIGHT_BOLD, 
              color: selected ? Theme.of(context).colorScheme.secondary : Colors.grey,
            )
          ),
          onPressed: () {
            setState(() => this.selected = ! this.selected);
            if (this.selected) widget.onSelected();
            else widget.onDeselected();
          },
      ),
    );
  }
}


class _FrequencyFormFieldState extends FormFieldState<List<DaysEnum>> {

  @override
  FrequencyFormField get widget => super.widget;

  add(DaysEnum d) {
    widget.controller.values.add(d);
  }

  remove(DaysEnum d) {
    widget.controller.values.remove(d);
  }
}


class FrequencyFormController {
  Set<DaysEnum> values;

  FrequencyFormController({List<DaysEnum> selectedValues}) : values = selectedValues??{};
}