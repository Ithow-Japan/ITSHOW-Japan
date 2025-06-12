import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final int id, achievement;
  final String image_path;
  final String name;

  const CategoryWidget({
    super.key,
    required this.achievement,
    required this.image_path,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 30,
                  offset: Offset(0, 0),
                )
              ],
            ),
            width: 316,
            height: 136,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                        child: Expanded(
                          child: Image.asset(
                            width: 80,
                            height: 80,
                            image_path,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "총 20개",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xffC7C7C7),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 230,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      minHeight: 10,
                      value: achievement / 100.0,
                      backgroundColor: Color(0xffD9D9D9),
                      valueColor: AlwaysStoppedAnimation(Color(0xffFD6929)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
