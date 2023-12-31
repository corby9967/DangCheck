import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/make_house_pages/make_house_final.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeHousePage7 extends StatefulWidget {
  final String newCode;
  const MakeHousePage7({super.key, required this.newCode});

  @override
  State<MakeHousePage7> createState() => _MakeHousePage7();
}

class _MakeHousePage7 extends State<MakeHousePage7> {
  bool isButtonActive = true;
  int walk = 1;

  List<String> days = ['1일', '2일', '3일', '4일', '5일', '6일', '일주일'];
  String dropdowntext = '1일';
  bool showDropDownMenu = false;

  @override
  void initState() {
    super.initState();
  }

  Future saveWalkInfo() async {
    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.newCode)
        .update({
      "산책 주기": dropdowntext,
      "산책 횟수": walk,
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
                  width: (MediaQuery.of(context).size.width - 34) / 8 * 7,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: (MediaQuery.of(context).size.width - 34) / 8 * 1,
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
              '강아지의 산책 주기를 알려주세요.',
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
              width: (MediaQuery.of(context).size.width - 34),
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
                          backgroundColor: walk == 1
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
                            walk > 1 ? walk-- : walk = 1;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$walk번',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: walk != 4
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
                            walk < 4 ? walk++ : walk = 4;
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
                                      showDropDownMenu = false;
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
              width: MediaQuery.of(context).size.width,
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
                    MakeHousePageFinal(
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 54,
              width: MediaQuery.of(context).size.width,
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
                        saveWalkInfo();
                        Get.to(
                          MakeHousePageFinal(
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
    );
  }
}
