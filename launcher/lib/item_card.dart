import 'package:flutter/material.dart';

import 'theme.dart';

class ItemCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final String genre;
  final VoidCallback onPressed;

  const ItemCard(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.genre,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: MainTheme.cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(imagePath),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 18, color: MainTheme.cardTitleColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                genre,
                style: const TextStyle(fontSize: 12, color: MainTheme.cardGenreColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0), // Add space at the bottom
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text("Play"),
              ),
            ),
          ],
        ));
  }
}
