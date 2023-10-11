import 'package:firebase_auth/firebase_auth.dart';
import 'package:dangcheck/pages/house_join.dart';
import 'package:dangcheck/pages/make_house_pages/make_house.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HousePage extends StatefulWidget {
  const HousePage({super.key});

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  bool isButtonSelected1 = false;
  bool isButtonSelected2 = false;

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
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(Icons.logout),
                  )
                ],
              ),
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
                    color: isButtonSelected1
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isButtonSelected1 = true;
                        isButtonSelected2 = false;
                      });
                    },
                    child: Center(
                      child: Text(
                        '하우스 만들기',
                        style: TextStyle(
                          color: isButtonSelected1
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.primary,
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
                    color: isButtonSelected2
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isButtonSelected2 = true;
                        isButtonSelected1 = false;
                      });
                    },
                    child: Center(
                      child: Text(
                        '하우스 들어가기',
                        style: TextStyle(
                          color: isButtonSelected2
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 194,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(isButtonSelected1 ||
                          isButtonSelected2
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  if (isButtonSelected1) {
                    Get.to(
                      const MakeHousePage(),
                      transition: Transition.noTransition,
                    );
                  } else if (isButtonSelected2) {
                    Get.to(
                      const JoinHousePage(),
                      transition: Transition.noTransition,
                    );
                  } else {
                    null;
                  }
                },
                child: Text(
                  '다음',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
