import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

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
              )
            ],
          ),
          width: 316,
          height: 136,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    "name",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 30,
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
                width: 30,
                height: 5,
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
    );
  }
}
