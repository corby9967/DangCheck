import 'package:dangcheck/pages/make_house2.dart';
import 'package:dangcheck/pages/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinPage2 extends StatefulWidget {
  const JoinPage2({super.key});

  @override
  State<JoinPage2> createState() => _JoinPage2State();
}

class _JoinPage2State extends State<JoinPage2> {
  final nickNameController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();

    nickNameController.addListener(() {
      final isButtonActive = nickNameController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
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
                '하우스 만들기',
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
                  width: 42,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: 299,
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
              '하우스 이름을 입력해주세요.',
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
                controller: nickNameController,
                hintText: '하우스 이름',
                obscureText: false,
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
                        Get.to(
                          const JoinPage3(),
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
    );
  }
}
