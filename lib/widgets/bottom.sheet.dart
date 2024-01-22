import 'package:flutter/material.dart';

class BuildBottomSheet extends StatelessWidget {
  BuildBottomSheet(
      {super.key,
      required this.directions /*,required this.scrollController*/});
  Map<String, dynamic>? directions;
  //final ScrollController scrollController ;
  @override
  Widget build(BuildContext context) {
    print(
        "%%%%%%%%%%%%%%%%%%%%%%%%%%Directions=$directions%%%%%%%%%%%%%%%%%%%%%%%%%");
    return /*LayoutBuilder(
      builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double targetHeight = maxHeight / 2;
        double offset = scrollController.offset;
        double adjustedHeight = targetHeight - offset;
        return*/
        Container(
            // height: adjustedHeight > 0 ? adjustedHeight : 0,

            width: MediaQuery.of(context).size.width,
            // Your widget content
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Directions",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  //SizedBox(height: 10,),
                  Column(
                    children: directions!.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${entry.key}:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              " ${entry.value}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close'),
                  )
                ],
              ),
            ));
  }

  // )
  // ;
}

//}
