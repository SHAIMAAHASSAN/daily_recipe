import 'package:flutter/material.dart';
class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isfavorite = false;
  Color _color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Rebuild widget with updated state
          isfavorite = !isfavorite; // Toggle favorite state
          _color = isfavorite
              ? Colors.deepOrange
              : Colors.grey; // Change color based on state
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(isfavorite ? Icons.favorite : Icons.favorite_border,
            color: _color, size:25),
      ),
    );
  }
}
