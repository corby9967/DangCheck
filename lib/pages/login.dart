import 'package:dangcheck/pages/forgot_password.dart';
import 'package:dangcheck/pages/sign_up_pages/signup_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my classes/textfield.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  bool userNameInserted = false;
  bool passWordInserted = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();

    userNameController.addListener(() {
      final isButtonActive = userNameController.text.isNotEmpty;
      setState(() {
        userNameInserted = isButtonActive;
      });
    });

    passWordController.addListener(() {
      final isButtonActive = passWordController.text.isNotEmpty;
      setState(() {
        passWordInserted = isButtonActive;
      });
    });
  }

  Future logIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: userNameController.text,
            password: passWordController.text,
          )
          .then((value) => Navigator.pop(context));
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      print(e);
      if (e.code == 'invalid-email') {
        setState(() {});
        errorMsg = '이메일 형식이 올바르지 않습니다.';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        setState(() {});
        errorMsg = '로그인 정보가 틀렸습니다.';
      } else if (e.code == 'wrong-password') {
        setState(() {});
        errorMsg = '비밀번호가 틀렸습니다.';
      }
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "로그인",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            MyTextField(
              controller: userNameController,
              hintText: "아이디",
              obscureText: false,
            ),
            const SizedBox(
              height: 14,
            ),
            MyTextField(
              controller: passWordController,
              hintText: "비밀번호",
              obscureText: true,
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll((userNameInserted &&
                          passWordInserted)
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
                onPressed: (userNameInserted && passWordInserted)
                    ? () {
                        logIn();
                      }
                    : null,
                child: Text(
                  '로그인',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 278,
                    child: Text(
                      errorMsg,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const ForgotPasswordPage(),
                          transition: Transition.downToUp);
                    },
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              '계정이 없으신가요?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black54,
                fontSize: 11,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black87,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.to(const SignupPage2(),
                      transition: Transition.noTransition);
                },
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.black54,
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
