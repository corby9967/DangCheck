import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 241,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: ShapeDecoration(
            color: const Color(0xFFFF9519),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '지원이가 1시간 전에 사료을 줬어멍!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: '210 Gulim',
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                ),
              ),
            ],
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(0.0, -6.0)
            ..rotateZ(-3.14),
          child: Container(
            width: 20,
            height: 20,
            decoration: const ShapeDecoration(
              color: Color(0xFFFF9519),
              shape: StarBorder.polygon(
                sides: 3,
                pointRounding: 0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
