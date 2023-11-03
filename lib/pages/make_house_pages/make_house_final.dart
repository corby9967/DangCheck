import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MakeHousePageFinal extends StatefulWidget {
  final String newCode;
  const MakeHousePageFinal({super.key, required this.newCode});

  @override
  State<MakeHousePageFinal> createState() => _MakeHousePageFinal();
}

class _MakeHousePageFinal extends State<MakeHousePageFinal> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isButtonActive = true;
  String houseName = '';

  @override
  void initState() {
    super.initState();

    getInfo();
  }

  Future saveUserInfo() async {
    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.newCode)
        .collection('member')
        .doc(user.email!)
        .set({});

    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.newCode)
        .collection('dog status')
        .doc('status')
        .set({
      "food status": 0,
      "snack status": 0,
      "shower status": 0,
      "walk status": 0,
    });
  }

  Future getInfo() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.newCode)
        .get();
    setState(() {
      houseName = documentSnapshot.get('하우스 이름');
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
                  width: (MediaQuery.of(context).size.width - 34) / 8 * 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: (MediaQuery.of(context).size.width - 34) / 8 * 0,
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
            const SizedBox(height: 40),
            const Text(
              '하우스가 생성되었어요.\n하우스 코드를 친구들에게 알려주세요!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 59, vertical: 40),
              width: (MediaQuery.of(context).size.width - 34),
              height: 250,
              decoration: const BoxDecoration(
                  color: Color(0xFFF2F4F6),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$houseName의 하우스코드에요.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Text(
                    '가족들에게 공유해보세요 😊',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    widget.newCode,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.newCode));
                    },
                    child: Text(
                      '클립보드 복사',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 165),
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
                    ? () async {
                        saveUserInfo();
                        await getInfo();
                        Get.to(
                          HomePage(
                            currentCode: widget.newCode,
                          ),
                          transition: Transition.noTransition,
                        );
                      }
                    : null,
                child: Text(
                  '하우스로 이동하기',
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
