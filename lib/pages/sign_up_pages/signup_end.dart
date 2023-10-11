import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/house.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage5 extends StatefulWidget {
  const SignupPage5({super.key});

  @override
  State<SignupPage5> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage5> {
  String nickname = '';

  Future getNickName() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.email!)
        .get()
        .then((snapshot) {
      nickname = snapshot.get("nickname");
    });
    print(nickname);
  }

  @override
  void initState() {
    getNickName();
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                '회원가입',
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
                  width: 341,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: 0,
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
              height: 220,
            ),
            const Text(
              '회원가입 완료!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '$nickname님',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              '환영합니다!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 225,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
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
                    const HousePage(),
                    transition: Transition.noTransition,
                  );
                },
                child: Text(
                  '시작하기',
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
