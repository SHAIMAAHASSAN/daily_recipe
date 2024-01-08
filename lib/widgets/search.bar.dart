import 'package:flutter/material.dart';
class SearchBarEX extends StatelessWidget {
  const SearchBarEX({super.key, required this.hintText});
 final String hintText;
  @override
  Widget build(BuildContext context) {
    return   Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                    BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.tune_sharp),
            ),
          )
        ],
      ),
    );
  }
}
