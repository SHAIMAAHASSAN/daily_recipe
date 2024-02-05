import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuildBottomSheet extends StatelessWidget {
  BuildBottomSheet(
      {super.key,
      required this.directions /*,required this.scrollController*/});
  Map<String, dynamic>? directions;
  //final ScrollController scrollController ;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> printOrderedMap(Map<String, dynamic> data) {
      var sortedKeys = data.keys.toList()..sort();
      for (var key in sortedKeys) {
        print('$key: ${data[key]}');
      }
      return data;
    }

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
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)).tr(),
                  SizedBox(height: 10,),
                  Column(
                    children: directions!.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Text("Step ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),).tr(),
                                Text(
                                  "${entry.key}:",
                                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                ).tr(),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(tr("${entry.value}"),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 5,),
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0,left: 15),
                              child: Divider(),
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
