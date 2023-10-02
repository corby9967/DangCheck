import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'house_join.dart';
import 'make_house.dart';

class HousePage extends StatefulWidget {
  const HousePage({super.key});

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
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
                fontSize: 18,
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.to(
                        const MakeHousePage(),
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
                    color: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF7B7B7B)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.to(
                        const JoinHousePage(),
                        transition: Transition.noTransition,
                      );
                    },
                    child: const Center(
                      child: Text(
                        '하우스 들어가기',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
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
