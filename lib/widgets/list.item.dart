import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.page,
  });
  final String title;
  final IconData leadingIcon;
  final Widget page;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isSelected = false;
  ZoomDrawerController controller = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });

        controller.close?.call();
        NavigationUtils.push(context: context, page: widget.page);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: ListTile(
          leading: Icon(widget.leadingIcon,
              color: isSelected ? Colors.deepOrange : Colors.black54),
          title: Text(widget.title,
                  style: TextStyle(
                      color: isSelected ? Colors.deepOrange : Colors.grey,
                      fontSize: 16))
              .tr(),
          focusColor: Colors.deepOrange,
        ),
      ),
    );
  }
}
