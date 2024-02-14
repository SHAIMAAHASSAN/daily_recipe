import 'package:daily_recipe/pages/filter.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:flutter/material.dart';

class SearchBarEX extends StatefulWidget {
  const SearchBarEX({super.key, required this.hintText});
  final String hintText;

  @override
  State<SearchBarEX> createState() => _SearchBarEXState();
}

class _SearchBarEXState extends State<SearchBarEX> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: InkWell(
                  onTap: () => NavigationUtils.push(
                      context: context, page: const FilterPage()),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          const SizedBox(
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
              child: InkWell(
                  onTap: () => NavigationUtils.push(
                      context: context, page: const FilterPage()),
                  child: const Icon(Icons.tune_sharp)),
            ),
          )
        ],
      ),
    );
  }
}
