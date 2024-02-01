import 'package:flutter/material.dart';


class ChipWidget extends StatelessWidget {
  final String mealType;
  final Map<String, dynamic> selectedUserValue;
  final Function(Map<String, dynamic>) onSelect;

  ChipWidget({
    Key? key,
    required this.mealType,
    required this.selectedUserValue,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Create a new map with the selected meal type
        Map<String, dynamic> newSelectedUserValue = Map.from(selectedUserValue);
        newSelectedUserValue['meal_type'] = mealType;
        onSelect(newSelectedUserValue); // Update the selected value
      },
      child: Chip(
        label: Text(
          mealType,
          style: TextStyle(
            color: selectedUserValue['meal_type'] == mealType ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: selectedUserValue['meal_type'] == mealType ? Colors.deepOrange : Colors.grey[200],
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    );
  }
}

/*
class ChipWidget extends StatefulWidget {
   ChipWidget({super.key,required this.mealType,required this.selectedUserValue});
   String mealType;
   var selectedUserValue = {};

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  //var selectedUserValue = {};
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        widget.selectedUserValue['meal_type'] =widget.mealType ;
        setState(() {});
      },
      child: Chip(
        label: Text(widget.mealType,style: TextStyle(color:widget.selectedUserValue['meal_type'] == widget.mealType
            ? Colors.white
            : Colors.black, ),),
        backgroundColor: widget.selectedUserValue['meal_type'] == widget.mealType
            ? Colors.deepOrange
            : Colors.grey[200],
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    );
  }
}
*/
