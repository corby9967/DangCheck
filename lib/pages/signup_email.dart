import 'package:flutter/material.dart';

class SignupPage2 extends StatefulWidget {
  const SignupPage2({super.key});

  @override
  State<SignupPage2> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage2> {
  final nickNameController = TextEditingController();

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
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: const Text(
                '회원가입',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 5,
                  width: 120,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 5,
                  width: 221,
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
              height: 15,
            ),
            const Text(
              '이메일을 입력해주세요.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 54,
              child: MyTextField(
                  controller: nickNameController,
                  hintText: '이메일',
                  obscureText: false),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  '다음',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
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

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: 356,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
    );
  }
}
