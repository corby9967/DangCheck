import 'package:dangcheck/my%20classes/textfield.dart';
import 'package:dangcheck/pages/make_house4.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MakeHousePage2 extends StatefulWidget {
  const MakeHousePage2({super.key});

  @override
  State<MakeHousePage2> createState() => _MakeHousePage2();
}

class _MakeHousePage2 extends State<MakeHousePage2> {
  final dogNameController = TextEditingController();
  final dogBdayController = TextEditingController();
  final dogBreedController = TextEditingController();

  bool isButtonActive = false;
  bool name = false;
  bool bday = false;
  bool breed = false;

  bool boy = false;
  bool girl = false;

  bool small = false;
  bool middle = false;
  bool big = false;

  @override
  void initState() {
    super.initState();
    dogNameController.addListener(() {
      name = dogNameController.text.isNotEmpty;
      setState(() {
        name && bday && breed ? isButtonActive = true : isButtonActive = false;
      });
    });
    dogBdayController.addListener(() {
      bday = dogBdayController.text.isNotEmpty;
      setState(() {
        name && bday && breed ? isButtonActive = true : isButtonActive = false;
      });
    });
    dogBreedController.addListener(() {
      breed = dogBreedController.text.isNotEmpty;
      setState(() {
        name && bday && breed ? isButtonActive = true : isButtonActive = false;
      });
    });
  }

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
            AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: const Text(
                '하우스 만들기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 3,
                  width: 84,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: 257,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '강아지 정보를 입력해주세요.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 54,
              child: MyTextField(
                controller: dogNameController,
                hintText: '강아지 이름',
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 54,
              child: MyTextField(
                controller: dogBdayController,
                hintText: '강아지 생일',
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 54,
              child: MyTextField(
                controller: dogBreedController,
                hintText: '강아지 종',
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '성별',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: boy
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(boy
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).colorScheme.background),
                              ),
                        onPressed: () {
                          setState(() {
                            boy = true;
                            girl = false;
                          });
                        },
                        child: Text(
                          '남자',
                          style: TextStyle(
                            color: boy
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: girl
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(girl
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).colorScheme.background),
                              ),
                        onPressed: () {
                          setState(() {
                            girl = true;
                            boy = false;
                          });
                        },
                        child: Text(
                          '여자',
                          style: TextStyle(
                            color: girl
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '구분',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: small
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(small
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).colorScheme.background),
                              ),
                        onPressed: () {
                          setState(() {
                            small = true;
                            middle = false;
                            big = false;
                          });
                        },
                        child: Text(
                          '소형',
                          style: TextStyle(
                            color: small
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: middle
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    middle
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                        : Theme.of(context)
                                            .colorScheme
                                            .background),
                              ),
                        onPressed: () {
                          setState(() {
                            small = false;
                            middle = true;
                            big = false;
                          });
                        },
                        child: Text(
                          '중형',
                          style: TextStyle(
                            color: middle
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: big
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(big
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).colorScheme.background),
                              ),
                        onPressed: () {
                          setState(() {
                            small = false;
                            middle = false;
                            big = true;
                          });
                        },
                        child: Text(
                          '중형',
                          style: TextStyle(
                            color: big
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 228,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(isButtonActive
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
                onPressed: isButtonActive
                    ? () {
                        Get.to(
                          const MakeHousePage4(),
                          transition: Transition.noTransition,
                        );
                      }
                    : null,
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
