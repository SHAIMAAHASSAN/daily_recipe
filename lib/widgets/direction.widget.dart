import 'package:daily_recipe/widgets/animated.text.widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DirectionWidget extends StatelessWidget {
 const DirectionWidget({super.key, required this.directions});
   final Map<String, dynamic>? directions;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
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
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20))
                  .tr(),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: directions!.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //  Text("Step ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),).tr(),
                            const AnimatedTextWidget(
                                text: "Step",
                                fontWeight: FontWeight.w600,
                                size: 18),
                            AnimatedTextWidget(
                                text: "${entry.key}:",
                                fontWeight: FontWeight.w600,
                                size: 18),
                            /* Text(
                                  "${entry.key}:",
                                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                                ).tr(),*/
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          tr("${entry.value}"),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        // AnimatedTextWidget(text: tr("${entry.value}"), fontWeight:FontWeight.w400, size: 16),
                        const SizedBox(
                          height: 5,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 15.0, left: 15),
                          child: Divider(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close').tr(),
              )
            ],
          ),
        ));
  }
}
