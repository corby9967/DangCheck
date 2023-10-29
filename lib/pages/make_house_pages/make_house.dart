import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/make_house_pages/make_house2.dart';
import 'package:dangcheck/my%20classes/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeHousePage extends StatefulWidget {
  final String newCode;
  const MakeHousePage({super.key, required this.newCode});

  @override
  State<MakeHousePage> createState() => _MakeHousePage();
}

class _MakeHousePage extends State<MakeHousePage> {
  final houseNameController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();

    houseNameController.addListener(() {
      final isButtonActive = houseNameController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  Future saveHouseName() async {
    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.newCode)
        .update({
      "housename": houseNameController.text,
    });
  }

  deleteCode() {}

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
                    deleteCode();
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                  controller: houseNameController,
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
                          saveHouseName();
                          Get.to(
                            MakeHousePage2(newCode: widget.newCode),
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
