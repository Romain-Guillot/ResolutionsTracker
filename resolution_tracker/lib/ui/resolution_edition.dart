
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resolution_tracker/models/models.dart';
import 'package:resolution_tracker/res/dimens.dart';

class ResolutionEditionWidget extends StatelessWidget {

  final FrequencyFormController frequencyController = FrequencyFormController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(decoration: InputDecoration.collapsed(hintText: "Resolution title"), style: TextStyle(fontSize: 27),),
          SizedBox(height: Dimens.NORMAL_PADDING,),
          Text("Frequency"),
          SizedBox(height: Dimens.NORMAL_PADDING,),
          Center(
            child: FrequencyFormField(controller: frequencyController,)
          ),
          SizedBox(height: Dimens.NORMAL_PADDING,),
          Text("Add an icon"),
          Expanded(child: Container(),),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(child: Text("Save my resolution", style: TextStyle(fontWeight: Dimens.FONT_WEIGHT_BOLD, color: Theme.of(context).colorScheme.primary),), onPressed: () => print(frequencyController.values.length),),
          )
          
        ],
      ),
    );
  }
}




class FrequencyFormField extends FormField<List<DaysEnum>> {

  final FrequencyFormController controller;
  
  FrequencyFormField({@required this.controller}) : super(
    builder: (state) => Wrap(
      spacing: 3,
      children: DaysEnum.values().map((d) => 
          SelectableDay(
            day: d,
            onSelected: () => (state as _FrequencyFormFieldState).add(d),
            onDeselected: () => (state as _FrequencyFormFieldState).remove(d),
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
    return ButtonTheme(
        minWidth: 0,
        padding: EdgeInsets.all(10),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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