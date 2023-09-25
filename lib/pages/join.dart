import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'make_house.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 120,
            ),
            const Text(
              '댕CHECK,\n소중한 강아지를 가족과 함께 관리해보세요',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 190,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF7B7B7B)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.to(
                        const JoinPage2(),
                        transition: Transition.noTransition,
                      );
                    },
                    child: Center(
                      child: Text(
                        '하우스 만들기',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Container(
                  width: 160,
                  height: 160,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF7B7B7B)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Text('하우스 참가하기'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
