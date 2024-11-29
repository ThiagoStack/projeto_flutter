import 'package:flutter/material.dart';

class UserHeaderHomePage extends StatelessWidget {
  final String userName;
  final double screenWidth;
  final double screenHeight;

  const UserHeaderHomePage({
    Key? key,
    required this.userName,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: screenWidth * 0.07,
          backgroundImage: const AssetImage('assets/images/avatar.png'),
        ),
        SizedBox(width: screenWidth * 0.03),
        Flexible(
          child: Text(
            'Olá, $userName',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}