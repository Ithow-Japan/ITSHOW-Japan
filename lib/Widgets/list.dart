import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final IconData listIcon;
  final String listText;
  const UserList({
    super.key,
    required this.listIcon,
    required this.listText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
      child: Row(
        children: [
          Icon(
            listIcon,
            color: Color(0xFF757575),
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            listText,
            style: TextStyle(
              color: Color(0xFF757575),
            ),
          )
        ],
      ),
    );
  }
}
