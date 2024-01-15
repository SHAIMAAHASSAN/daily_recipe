import 'package:flutter/material.dart';
class BuildBottomSheet extends StatelessWidget {
  const BuildBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
           //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Directions',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
              Text("Crack 4 large eggs into a large bowl."),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
