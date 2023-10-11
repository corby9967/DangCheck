import 'package:dangcheck/my%20classes/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _SignupPageState();
}

class _SignupPageState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  bool isButtonActive = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      final isButtonActive = emailController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  Future resetPassword() async {
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
          .sendPasswordResetEmail(email: emailController.text)
          .then(
            (value) => {
              Navigator.pop(context),
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("이메일이 전송 되었습니다."),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('확인'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Get.back();
                        },
                      ),
                    ],
                  );
                },
              ),
            },
          );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      // print(e);
      if (e.code == 'invalid-email') {
        setState(() {});
        errorMsg = '이메일 형식이 올바르지 않습니다.';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        setState(() {});
        errorMsg = '로그인 정보가 틀렸습니다.';
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
                  '비밀번호 찾기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                '이메일을 입력해주세요.',
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
                  controller: emailController,
                  hintText: '이메일',
                  obscureText: false,
                ),
              ),
              Text(
                errorMsg,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 451,
              ),
              SizedBox(
                height: 54,
                width: 356,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(isButtonActive
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
                  onPressed: isButtonActive
                      ? () {
                          resetPassword();
                        }
                      : null,
                  child: Text(
                    '인증메일 발송',
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
