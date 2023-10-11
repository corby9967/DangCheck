import 'package:dangcheck/pages/sign_up_pages/signup_confirm_password.dart';
import 'package:dangcheck/my%20classes/textfield.dart';
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
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      final isButtonActive = passwordController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
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
                          Get.to(
                            SignupPage7(
                              email: widget.email,
                              password: passwordController.text,
                            ),
                            transition: Transition.noTransition,
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
      ),
    );
  }
}
