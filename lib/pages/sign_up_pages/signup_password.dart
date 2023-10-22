import 'package:dangcheck/my%20classes/textfield.dart';
import 'package:dangcheck/pages/sign_up_pages/signup_nickname.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SignupPage6 extends StatefulWidget {
  final String email;
  const SignupPage6({required this.email, super.key});

  @override
  State<SignupPage6> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage6> {
  final passwordController = TextEditingController();
  final confirmPassWordController = TextEditingController();
  bool passWordInserted = false;
  bool confirmPassWordInserted = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      final isButtonActive = passwordController.text.isNotEmpty;
      setState(() {
        passWordInserted = isButtonActive;
      });
    });

    confirmPassWordController.addListener(() {
      final isButtonActive = confirmPassWordController.text.isNotEmpty;
      setState(() {
        confirmPassWordInserted = isButtonActive;
      });
    });
  }

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPassWordController.text) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: widget.email,
              password: passwordController.text,
            )
            .then(
              (value) => {
                Navigator.pop(context),
                Get.to(const SignupPage(), transition: Transition.noTransition)
              },
            );
      } else {
        Navigator.pop(context);
        setState(() {});
        errorMsg = '비밀번호가 일치하지 않습니다.';
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      print(e);
      if (e.code == 'email-already-in-use') {
        setState(() {});
        errorMsg = '이미 사용중인 이메일 입니다.';
      } else if (e.code == 'invalid-email') {
        setState(() {});
        errorMsg = '이메일 형식이 틀렸습니다.';
      } else if (e.code == 'weak-password') {
        setState(() {});
        errorMsg = '비밀번호가 6자리 이상이어야 합니다.';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                    width: 137,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  Container(
                    height: 3,
                    width: 204,
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
                '비밀번호를 입력해주세요.',
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
                  controller: passwordController,
                  hintText: '비밀번호',
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 54,
                child: MyTextField(
                  controller: confirmPassWordController,
                  hintText: '비밀번호 확인',
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  errorMsg,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 390,
              ),
              SizedBox(
                height: 54,
                width: 356,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        (passWordInserted && confirmPassWordInserted)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: (passWordInserted && confirmPassWordInserted)
                      ? () {
                          signUserUp();
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
      ),
    );
  }
}
