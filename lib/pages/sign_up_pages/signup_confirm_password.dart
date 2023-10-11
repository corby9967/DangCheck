import 'package:dangcheck/pages/sign_up_pages/signup_email.dart';
import 'package:dangcheck/pages/sign_up_pages/signup_nickname.dart';
import 'package:dangcheck/pages/sign_up_pages/signup_password.dart';
import 'package:dangcheck/pages/sign_up_pages/signup_profile.dart';
import 'package:dangcheck/my%20classes/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SignupPage7 extends StatefulWidget {
  final String email;
  final String password;
  const SignupPage7({required this.email, required this.password, super.key});

  @override
  State<SignupPage7> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage7> {
  final confirmPasswordController = TextEditingController();
  bool isButtonActive = false;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();

    confirmPasswordController.addListener(() {
      final isButtonActive = confirmPasswordController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
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
      if (widget.password == confirmPasswordController.text) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: widget.email,
              password: widget.password,
            )
            .then((value) => {
                  Navigator.pop(context),
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("회원 가입이 완료 되었습니다."),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Get.to(const SignupPage(),
                                  transition: Transition.noTransition);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                });
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("비밀번호가 일치하지 않습니다."),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.to(
                      SignupPage6(email: widget.email),
                      transition: Transition.noTransition,
                    );
                  },
                ),
              ],
            );
          },
        );
        // setState(() {});
        // errorMsg = '비밀번호가 일치하지 않습니다.';
        // Get.to(
        //   SignupPage6(email: widget.email),
        //   transition: Transition.noTransition,
        // );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      print(e);
      if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("이미 사용중인 이메일 입니다."),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.to(
                      const SignupPage2(),
                      transition: Transition.noTransition,
                    );
                  },
                ),
              ],
            );
          },
        );
        // setState(() {});
        // errorMsg = '이미 사용중인 이메일 입니다.';
        // Get.to(
        //   const SignupPage2(),
        //   transition: Transition.noTransition,
        // );
      } else if (e.code == 'invalid-email') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("이메일 형식이 잘못 되었습니다."),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.to(
                      const SignupPage2(),
                      transition: Transition.noTransition,
                    );
                  },
                ),
              ],
            );
          },
        );
        // setState(() {});
        // errorMsg = '존재하지 않는 이메일 입니다.';
        // Get.to(
        //   const SignupPage2(),
        //   transition: Transition.noTransition,
        // );
      } else if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("비밀번호가 6자리 이상이어야 합니다."),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.to(
                      SignupPage6(email: widget.email),
                      transition: Transition.noTransition,
                    );
                  },
                ),
              ],
            );
          },
        );
        // setState(() {});
        // errorMsg = '비밀번호가 6자리 이상이어야 합니다.';
        // Get.to(
        //   SignupPage6(email: widget.email),
        //   transition: Transition.noTransition,
        // );
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
                    width: 136,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  Container(
                    height: 3,
                    width: 205,
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
                '비밀번호를 다시 한번 입력해주세요.',
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
                  controller: confirmPasswordController,
                  hintText: '비밀번호',
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 470,
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
