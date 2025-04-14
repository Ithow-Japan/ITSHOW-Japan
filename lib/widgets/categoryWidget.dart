import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final int id;
  final String name;

  const CategoryWidget({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
<<<<<<< HEAD
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
                height: 25,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Text(
                    "80%",
                    style: TextStyle(
                      color: Color(0xffFD6929),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Text(
                      "학습완료",
                      style: TextStyle(
                        color: Color(0xff9E9E9E),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 157,
                  ),
                  Text(
                    "총 245개",
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xff919191),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 17,
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: 280,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffffe7dd),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        '이거 345개 주세요',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        width: 136,
                      ),
                      Icon(Icons.keyboard_arrow_right_rounded),
                    ],
                  ),
                ),
=======
>>>>>>> dc95c2a34bf38222e272389818bb82fa7957f070
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
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                ),
                Text(
                  "총 20개",
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xffC7C7C7),
                  ),
                ),
                SizedBox(
                  width: 256,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 12,
                    value: 0.3,
                    backgroundColor: Color(0xffD9D9D9),
                    valueColor: AlwaysStoppedAnimation(Color(0xffFD6929)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
