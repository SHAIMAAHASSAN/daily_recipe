import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String mealType;
  final Map<String, dynamic> selectedUserValue;
  final Function(Map<String, dynamic>) onSelect;

  const ChipWidget({
    super.key,
    required this.mealType,
    required this.selectedUserValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<String, dynamic> newSelectedUserValue = Map.from(selectedUserValue);
        newSelectedUserValue['meal_type'] = mealType;
        onSelect(newSelectedUserValue);
      },
      child: Chip(
        label: Text(
          mealType,
          style: TextStyle(
            color: selectedUserValue['meal_type'] == mealType
                ? Colors.white
                : Colors.black,
          ),
        ),
        backgroundColor: selectedUserValue['meal_type'] == mealType
            ? Colors.deepOrange
            : Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    );
  }
}
