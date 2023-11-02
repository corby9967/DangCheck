import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/sign_up_pages/signup_end.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage4 extends StatefulWidget {
  const SignupPage4({super.key});

  @override
  State<SignupPage4> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage4> {
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
                  width: (MediaQuery.of(context).size.width - 34) / 5 * 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: (MediaQuery.of(context).size.width - 34) / 5 * 1,
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
              '댕Check의 서비스 이용약관에\n동의해주세요.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '<댕 check>과 관련하여 아래와 같이 귀하의 개인정보를 수집 및 이용 내용을 개인정보보호법 제15조 (개인정보의 수집. 이용) 및 제17조(개인정보의 제공)에 의거하여 안내 드리니 확인하여 주시기 바랍니다.\n\n1. 수집하는 개인정보 항목: 닉네임, 이메일\n2. <댕 check>은 다음의 목적을 위하여 개인정보를 처리 하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.\n\t- 고객 가입 의사 확인, 고객에 대한 서비스 제공에 따른 본인 식별 인증, 회원자격 유지/ 관리 등\n3. 개인정보의 보유 및 이용 기간\n수집된 개인정보 보유 기간은 <댕 check> 앱 탈퇴 시까지 이며, 이용 및 제공목적이 달성된 경우 개인정보 보호법 제21조(개인정보의 파기)에 따라 처리합니다.\n\n귀하는 이에 대한 동의를 거부할 수 있습니다.\n다만, 동의가 없으면 <댕 check> 앱 이용이 불가함을 알려드립니다.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 145,
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
                    SignupPage5(
                      nickname: nickname,
                    ),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Text(
                  '동의합니다',
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
