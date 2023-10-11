import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeHousePage5 extends StatefulWidget {
  const MakeHousePage5({super.key});

  @override
  State<MakeHousePage5> createState() => _MakeHousePage5();
}

class _MakeHousePage5 extends State<MakeHousePage5> {
  bool isButtonActive = true;
  int shower = 1;

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
                  width: 126 + 42 + 42,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
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
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: const Color(0xFFF2F4F6),
                  //     elevation: 0,
                  //   ),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Text(
                  //         value,
                  //         style: const TextStyle(color: Colors.black),
                  //       ),
                  //       const SizedBox(
                  //         width: 5,
                  //       ),
                  //       const Icon(
                  //         Icons.arrow_drop_down,
                  //         color: Colors.black,
                  //         size: 24.0,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFFE8E8E8),
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
                            shower > 1 ? shower-- : shower = 1;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$shower번',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
                            shower++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // Container(
            //   width: 70,
            //   height: 100,
            //   decoration: const BoxDecoration(
            //       color: Color(0xFFF2F4F6),
            //       borderRadius: BorderRadius.all(Radius.circular(10))),
            //   child: ListView.builder(
            //     itemCount: 7,
            //     padding: const EdgeInsets.symmetric(vertical: 5),
            //     itemBuilder: (context, index) => Column(
            //       children: [
            //         TextButton(
            //           onPressed: () {},
            //           style: const ButtonStyle(alignment: Alignment.centerLeft),
            //           child: Text(
            //             '${index + 1}일',
            //             style:
            //                 const TextStyle(fontSize: 14, color: Colors.black),
            //           ),
            //         ),
            //         const Divider(
            //           height: 0,
            //           color: Color(0xFFE8E8E8),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 200,
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
                          const Placeholder(),
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
