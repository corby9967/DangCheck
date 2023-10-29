import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/my%20classes/textfield.dart';
import 'package:dangcheck/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinHousePage extends StatefulWidget {
  const JoinHousePage({super.key});

  @override
  State<JoinHousePage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinHousePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final houseCodeController = TextEditingController();

  bool isButtonActive = false;

  String errorMsg = '';

  @override
  void initState() {
    super.initState();

    houseCodeController.addListener(() {
      final isButtonActive = houseCodeController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  Future saveUserInfo() async {
    await FirebaseFirestore.instance
        .collection('house')
        .doc(houseCodeController.text)
        .collection('member')
        .doc(user.email!)
        .set({});
  }

  codeVerification() {
    final CollectionReference myCollection =
        FirebaseFirestore.instance.collection('house');
    final DocumentReference myDocument =
        myCollection.doc(houseCodeController.text);
    myDocument.get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          // The document exists in Firestore.
          saveUserInfo();
          Get.to(
            HomePage(
              newCode: houseCodeController.text,
            ),
            transition: Transition.noTransition,
          );
        } else {
          // The document does not exist in Firestore.
          errorMsg = '존재하지 않는 코드 입니다.';
          setState(() {});
        }
      },
    );
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
                '하우스 입장',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 43,
            ),
            const Text(
              '하우스 코드를 입력해주세요.',
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
                controller: houseCodeController,
                hintText: '하우스 코드',
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 341,
              child: Text(
                errorMsg,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 447,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(isButtonActive
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
                        codeVerification();
                      }
                    : null,
                child: Text(
                  '입장하기',
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
