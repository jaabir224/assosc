import 'package:flutter/material.dart';

import '../../../utils/custom_style.dart';

class UserInfoItem extends StatelessWidget {
  final String title, value;
  const UserInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: CustomStyle.night,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: CustomStyle.secondColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
