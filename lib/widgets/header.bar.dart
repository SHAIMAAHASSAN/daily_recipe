
import 'package:flutter/material.dart';
class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key,required this.title,required this.titleRight});
  final String title;
  final String titleRight;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title
            ,
            style:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          GestureDetector(
              onTap: () {},
              child:  Text(titleRight
              ,
                style: TextStyle(color: Colors.deepOrange, fontSize: 18,fontWeight: FontWeight.w500),
              )),
        ],
      ),


    );
  }
}
