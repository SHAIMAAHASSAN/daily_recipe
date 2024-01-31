import 'package:flutter/material.dart';
class ChipWidget extends StatefulWidget {
  const ChipWidget({super.key,required this.mealType});
   final String mealType;

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  var selectedUserValue = {};
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        selectedUserValue['meal_type'] =widget.mealType ;
        setState(() {});
      },
      child: Chip(
        label: Text(widget.mealType,style: TextStyle(color:selectedUserValue['meal_type'] == widget.mealType
            ? Colors.white
            : Colors.black, ),),
        backgroundColor: selectedUserValue['meal_type'] == widget.mealType
            ? Colors.deepOrange
            : Colors.grey[200],
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    );
  }
}
