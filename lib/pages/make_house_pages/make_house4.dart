import 'package:dangcheck/pages/make_house_pages/make_house5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeHousePage4 extends StatefulWidget {
  const MakeHousePage4({super.key});

  @override
  State<MakeHousePage4> createState() => _MakeHousePage4();
}

class _MakeHousePage4 extends State<MakeHousePage4> {
  bool isButtonActive = true;
  int feed = 1;
  List<Text> tempList = [];
  @override
  void initState() {
    super.initState();
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
                  width: 126 + 42,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
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
                            backgroundColor: feed < 4
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
                            backgroundColor: feed < 4
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

                              tempList.add(const Text("hi"));
                              print("junduck");
                              print(tempList.length);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black,
              height: 300,
              child: ListView.builder(
                  itemCount: tempList.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    return tempList[idx];
                  }),
            ),
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
                          const MakeHousePage5(),
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
