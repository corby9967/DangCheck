import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/make_house_pages/make_house5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../my classes/textfield.dart';

class MakeHousePage4 extends StatefulWidget {
  final String newCode;
  const MakeHousePage4({super.key, required this.newCode});

  @override
  State<MakeHousePage4> createState() => _MakeHousePage4();
}

class _MakeHousePage4 extends State<MakeHousePage4> {
  bool isButtonActive = false;
  int feed = 1;
  int foodMenu = 1;

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  void initState() {
    super.initState();

    controllers[0].addListener(() {
      if (controllers[0].text.isNotEmpty) {
        setState(() {
          isButtonActive = true;
        });
      } else {
        isButtonActive = false;
      }
    });
  }

  Future saveFoodInfo() async {
    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.newCode)
        .update({
      "식사 횟수": feed,
      "식사 메뉴 1": controllers[0].text,
    });
    if (controllers[1].text.isNotEmpty) {
      foodMenu++;
      await FirebaseFirestore.instance
          .collection('house')
          .doc(widget.newCode)
          .update({
        "식사 메뉴 2": controllers[1].text,
      });
    }
    if (controllers[2].text.isNotEmpty) {
      foodMenu++;
      await FirebaseFirestore.instance
          .collection('house')
          .doc(widget.newCode)
          .update({
        "식사 메뉴 3": controllers[2].text,
      });
    }
    if (controllers[3].text.isNotEmpty) {
      foodMenu++;
      await FirebaseFirestore.instance
          .collection('house')
          .doc(widget.newCode)
          .update({
        "식사 메뉴 4": controllers[3].text,
      });
    }
    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.newCode)
        .update({
      "식사 개수": foodMenu,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                    width: 126 + 42,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  Container(
                    height: 3,
                    width: 215 - 42,
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
                '강아지의 밥 정보를 알려주세요.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  width: 337,
                  height: 64,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF2F4F6),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '식사 횟수 (하루)',
                        style: TextStyle(fontSize: 14),
                      ),
                      Row(
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: feed == 1
                                  ? const Color(0xFFE8E8E8)
                                  : Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(0),
                              elevation: 0,
                            ),
                            icon: Icon(
                              Icons.remove,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            onPressed: () {
                              setState(() {
                                feed > 1 ? feed-- : feed = 1;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$feed끼',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: feed != 4
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color(0xFFE8E8E8),
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(1),
                              elevation: 0,
                            ),
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            onPressed: () {
                              setState(() {
                                feed < 4 ? feed++ : feed = 4;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 370,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      '🍚 1번째 식사 메뉴',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      controller: controllers[0],
                      hintText: '메뉴를 입력하세요',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '🍚 2번째 식사 메뉴',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      controller: controllers[1],
                      hintText: '메뉴를 입력하세요 (선택)',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '🍚 3번째 식사 메뉴',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      controller: controllers[2],
                      hintText: '메뉴를 입력하세요 (선택)',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '🍚 4번째 식사 메뉴',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      controller: controllers[3],
                      hintText: '메뉴를 입력하세요 (선택)',
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // SizedBox(
              //   height: 322,
              //   child: Expanded(
              //     child: ListView.builder(
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
              //       itemCount: controllers.length,
              //       itemBuilder: (context, index) {
              //         return Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             const SizedBox(height: 10),
              //             Text(
              //               '🍚 ${index + 1}번째 식사 메뉴',
              //               style: const TextStyle(fontSize: 14),
              //             ),
              //             const SizedBox(height: 5),
              //             MyTextField(
              //               controller: controllers[index],
              //               hintText: '메뉴를 입력하세요',
              //               obscureText: false,
              //             ),
              //             const SizedBox(height: 10),
              //           ],
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // Container(
              //   width: 356,
              //   height: 54,
              //   decoration: ShapeDecoration(
              //     color: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ),
              //   child: TextButton(
              //     onPressed: () {
              //       setState(() {
              //         // textfield 개수 늘리기
              //         if (menu < 4) {
              //           controllers.add(TextEditingController());
              //         }

              //         for (TextEditingController controller in controllers) {
              //           controller.addListener(() {
              //             if (controller.text.isNotEmpty) {
              //               count++;
              //             }
              //           });
              //         }

              //         if (count == controllers.length) {
              //           isButtonActive = true;
              //         }

              //         menu < 4 ? menu++ : menu = 4;
              //       });
              //     },
              //     child: const Text(
              //       '+ 추가하기',
              //       style: TextStyle(
              //         color: Color(0xFFD7D7D7),
              //         fontSize: 14,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 54,
                width: 356,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFFF2F4F6)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.to(
                      MakeHousePage5(
                        newCode: widget.newCode,
                      ),
                      transition: Transition.noTransition,
                    );
                  },
                  child: const Text(
                    '나중에 할래요',
                    style: TextStyle(
                      color: Color(0xFF7B7B7B),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 54,
                width: 356,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(isButtonActive
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.6)),
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
                          saveFoodInfo();
                          Get.to(
                            MakeHousePage5(
                              newCode: widget.newCode,
                            ),
                            transition: Transition.rightToLeft,
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
      ),
    );
  }
}
