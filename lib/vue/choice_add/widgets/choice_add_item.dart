import 'package:flutter/material.dart';


class ChoiceAddItem extends StatelessWidget {
  final Color backColor;
  final String title;
  final IconData iconData;
  final Function() onClicked;
  const ChoiceAddItem({
    super.key,
    required this.title,
    required this.backColor,
    required this.onClicked,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                color: Colors.white,
                size: 80,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
