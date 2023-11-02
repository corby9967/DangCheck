import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InvitePage extends StatefulWidget {
  final String newCode;
  const InvitePage({super.key, required this.newCode});

  @override
  State<InvitePage> createState() => _InvitePage();
}

class _InvitePage extends State<InvitePage> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isButtonActive = true;
  String houseName = '';

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
  void initState() {
    super.initState();
    getInfo();
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
                '초대',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 43),
            const Text(
              '새로운 친구를 초대하고 싶다면\n하우스 코드를 친구들에게 알려주세요!',
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
            const SizedBox(
              height: 54,
              width: 356,
            ),
          ],
        ),
      ),
    );
  }
}
