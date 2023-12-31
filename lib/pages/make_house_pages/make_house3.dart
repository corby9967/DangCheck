import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/make_house_pages/make_house4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeHousePage3 extends StatefulWidget {
  final String newCode;
  const MakeHousePage3({super.key, required this.newCode});

  @override
  State<MakeHousePage3> createState() => _MakeHousePage3();
}

class _MakeHousePage3 extends State<MakeHousePage3> {
  bool isButtonActive = true;
  int feed = 1;
  int index = 100;

  List<AssetImage> profiles = [
    const AssetImage('assets/images/dog_profile.png'),
    const AssetImage('assets/images/dog2_profile.png')
  ];

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
                  width: (MediaQuery.of(context).size.width - 34) / 8 * 3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: (MediaQuery.of(context).size.width - 34) / 8 * 5,
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
              '강아지 아이콘을 선택해주세요.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      index--;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xFF8B95A1),
                  ),
                  iconSize: 40,
                ),
                Container(
                  width: 185,
                  height: 185,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                    image: DecorationImage(
                      image: profiles[index % 2],
                      alignment: Alignment.bottomCenter,
                      scale: 1.94,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      index++;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF8B95A1),
                  ),
                  iconSize: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 204,
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
                        FirebaseFirestore.instance
                            .collection('house')
                            .doc(widget.newCode)
                            .update({'강아지 아이콘': (index % 2)});
                        Get.to(
                          MakeHousePage4(
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
