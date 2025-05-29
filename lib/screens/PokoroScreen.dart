import 'package:flutter/material.dart';
import 'package:harugo/widgets/pokoroContainerWidget.dart';

class PokoroScreen extends StatelessWidget {
  const PokoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "나의 포코로",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xffFFE7DD),
      body: Column(
        children: [
          Transform.translate(
            offset: Offset(0, -11),
            child: Image.asset("./assets/first_pokoro.png"),
          ),
          Transform.translate(
            offset: Offset(0, -40),
            child: Container(
              width: 184,
              height: 55,
              decoration: BoxDecoration(
                color: Color(0xffFD6929),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "현재 착용 의상",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "봄 포코로",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -20),
            child: PokoroContainerWidget(),
          )
        ],
      ),
    );
  }
}
