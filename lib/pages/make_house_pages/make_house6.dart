import 'package:dangcheck/pages/make_house_pages/make_house7.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeHousePage6 extends StatefulWidget {
  const MakeHousePage6({super.key});

  @override
  State<MakeHousePage6> createState() => _MakeHousePage6();
}

class _MakeHousePage6 extends State<MakeHousePage6> {
  bool isButtonActive = true;
  int feed = 1;

  List<String> days = ['1주', '2주', '3주', '한달'];
  String dropdowntext = '1주';
  bool showDropDownMenu = false;

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
                  width: 126 + 42 + 42 + 42,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: 215 - 42 - 42 - 42,
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
              '강아지의 목욕 주기를 알려주세요.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              width: 337,
              height: 64,
              decoration: const BoxDecoration(
                  color: Color(0xFFF2F4F6),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(dropdowntext),
                        IconButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          onPressed: () {
                            setState(() {
                              showDropDownMenu = !showDropDownMenu;
                            });
                          },
                        ),
                      ],
                    ),
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
                        '$feed번',
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
            const SizedBox(height: 6),
            showDropDownMenu
                ? Container(
                    width: 90,
                    height: 150,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF2F4F6),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                width: 90,
                                height: 40,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      dropdowntext = days[index];
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        days[index],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 90,
                                height: 1,
                                decoration:
                                    const BoxDecoration(color: Colors.black12),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                : const SizedBox(height: 150),
            const SizedBox(height: 240),
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
                          const MakeHousePage7(),
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
