
import 'package:flutter/material.dart';
class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key,required this.title,required this.titleLeft});
  final String title;
  final String titleLeft;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title
            ,
            style:
            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
              onTap: () {},
              child:  Text(titleLeft
              ,
                style: TextStyle(color: Colors.deepOrange, fontSize: 18),
              )),
        ],
      ),


    );
  }
}
