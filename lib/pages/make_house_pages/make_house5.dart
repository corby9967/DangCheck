import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../my classes/textfield.dart';
import 'make_house6.dart';

class MakeHousePage5 extends StatefulWidget {
  const MakeHousePage5({super.key});

  @override
  State<MakeHousePage5> createState() => _MakeHousePage5();
}

class _MakeHousePage5 extends State<MakeHousePage5> {
  bool isButtonActive = false;
  bool check = true;
  int feed = 1;

  List<TextEditingController> controllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();

    for (TextEditingController controller in controllers) {
      controller.addListener(() {
        setState(() {
          controller.text.isNotEmpty
              ? isButtonActive = true
              : isButtonActive = false;
        });
      });
    }
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
                  width: 126 + 42 + 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: 215 - 42 - 42,
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
              '강아지의 간식 정보를 알려주세요.',
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
                      '간식 횟수 (하루)',
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
                              // textfield 개수 줄이기
                              if (feed > 1) {
                                controllers[feed - 1].clear();
                                controllers[feed - 1].dispose();
                                controllers.removeAt(feed - 1);
                              }

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
                              // textfield 개수 늘리기
                              if (feed < 4) {
                                controllers.add(TextEditingController());
                              }

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
            SizedBox(
              height: 360,
              child: Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  itemCount: controllers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          '🍚 ${index + 1}번째 간식 이름',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        MyTextField(
                          controller: controllers[index],
                          hintText: '메뉴를 입력하세요',
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 36),
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
                    const Placeholder(),
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
            const SizedBox(
              height: 10,
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
                          const MakeHousePage6(),
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
