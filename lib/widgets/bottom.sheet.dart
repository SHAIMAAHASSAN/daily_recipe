import 'package:flutter/material.dart';
class BuildBottomSheet extends StatelessWidget {
  const BuildBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height:300,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Directions',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
              Text("Crack 4 large eggs into a large bowl."),
              Text(" jkkkkkkkkvckxcccccccccccccccccccccccccccccccccccccccccccccccccccccjhhhhhhxx"
                  "cm,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
                  "mc,nnmcnvvvvvvvvvvvvvvvvvvvvvvvvvvvvvkddddddddddddddd"
     ),
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
