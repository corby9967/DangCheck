import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/my%20classes/textfield.dart';
import 'package:dangcheck/pages/make_house_pages/make_house3.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';

class MakeHousePage2 extends StatefulWidget {
  const MakeHousePage2({super.key});

  @override
  State<MakeHousePage2> createState() => _MakeHousePage2();
}

class _MakeHousePage2 extends State<MakeHousePage2> {
  final dogNameController = TextEditingController();
  final dogBdayController = TextEditingController();
  final dogBreedController = TextEditingController();

  bool isButtonActive = false;
  bool name = false;
  bool bday = false;
  bool breed = false;

  bool boy = false;
  bool girl = false;

  bool small = false;
  bool middle = false;
  bool big = false;

  @override
  void initState() {
    super.initState();
    dogNameController.addListener(() {
      name = dogNameController.text.isNotEmpty;
      setState(() {
        name && bday && breed && (boy || girl) && (small || middle || big)
            ? isButtonActive = true
            : isButtonActive = false;
      });
    });
    dogBdayController.addListener(() {
      bday = dogBdayController.text.isNotEmpty;
      setState(() {
        name && bday && breed && (boy || girl) && (small || middle || big)
            ? isButtonActive = true
            : isButtonActive = false;
      });
    });
    dogBreedController.addListener(() {
      breed = dogBreedController.text.isNotEmpty;
      setState(() {
        name && bday && breed && (boy || girl) && (small || middle || big)
            ? isButtonActive = true
            : isButtonActive = false;
      });
    });
  }

  Future saveHouseName() async {
    await FirebaseFirestore.instance.collection('house').doc('12345').update({
      "dogname": dogNameController.text,
      "dogbirthday": dogBdayController.text,
      "dogbreed": dogBreedController.text,
    });

    if (girl == true) {
      await FirebaseFirestore.instance.collection('house').doc('12345').update(
        {
          "gender": '여자',
        },
      );
    }
    if (boy == true) {
      await FirebaseFirestore.instance.collection('house').doc('12345').update(
        {
          "gender": '남자',
        },
      );
    }
    if (small == true) {
      await FirebaseFirestore.instance.collection('house').doc('12345').update(
        {
          "size": '소형',
        },
      );
    }
    if (middle == true) {
      await FirebaseFirestore.instance.collection('house').doc('12345').update(
        {
          "size": '중형',
        },
      );
    }
    if (big == true) {
      await FirebaseFirestore.instance.collection('house').doc('12345').update(
        {
          "size": '대형',
        },
      );
    }
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
                  width: 84,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  height: 3,
                  width: 257,
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
              '강아지 정보를 입력해주세요.',
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
                controller: dogNameController,
                hintText: '강아지 이름',
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextField(
                controller: dogBdayController,
                decoration: const InputDecoration(
                  hintText: '강아지 생일',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE8E8E8)),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                              primary: Theme.of(context).colorScheme.primary),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    setState(() {
                      dogBdayController.text = formattedDate;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 54,
              child: MyTextField(
                controller: dogBreedController,
                hintText: '강아지 종',
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '성별',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: boy
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(boy
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).colorScheme.background),
                              ),
                        onPressed: () {
                          setState(() {
                            boy = true;
                            girl = false;
                            name &&
                                    bday &&
                                    breed &&
                                    (boy || girl) &&
                                    (small || middle || big)
                                ? isButtonActive = true
                                : isButtonActive = false;
                          });
                        },
                        child: Text(
                          '남자',
                          style: TextStyle(
                            color: boy
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: girl
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(girl
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).colorScheme.background),
                              ),
                        onPressed: () {
                          setState(() {
                            girl = true;
                            boy = false;
                            name &&
                                    bday &&
                                    breed &&
                                    (boy || girl) &&
                                    (small || middle || big)
                                ? isButtonActive = true
                                : isButtonActive = false;
                          });
                        },
                        child: Text(
                          '여자',
                          style: TextStyle(
                            color: girl
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '구분',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: small
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(small
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).colorScheme.background),
                              ),
                        onPressed: () {
                          setState(() {
                            small = true;
                            middle = false;
                            big = false;
                            name &&
                                    bday &&
                                    breed &&
                                    (boy || girl) &&
                                    (small || middle || big)
                                ? isButtonActive = true
                                : isButtonActive = false;
                          });
                        },
                        child: Text(
                          '소형',
                          style: TextStyle(
                            color: small
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: middle
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    middle
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                        : Theme.of(context)
                                            .colorScheme
                                            .background),
                              ),
                        onPressed: () {
                          setState(() {
                            small = false;
                            middle = true;
                            big = false;
                            name &&
                                    bday &&
                                    breed &&
                                    (boy || girl) &&
                                    (small || middle || big)
                                ? isButtonActive = true
                                : isButtonActive = false;
                          });
                        },
                        child: Text(
                          '중형',
                          style: TextStyle(
                            color: middle
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      height: 37,
                      width: 77,
                      child: TextButton(
                        style: big
                            ? ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                              )
                            : ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black54),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(big
                                    ? Theme.of(context).colorScheme.onBackground
                                    : Theme.of(context).colorScheme.background),
                              ),
                        onPressed: () {
                          setState(() {
                            small = false;
                            middle = false;
                            big = true;
                            name &&
                                    bday &&
                                    breed &&
                                    (boy || girl) &&
                                    (small || middle || big)
                                ? isButtonActive = true
                                : isButtonActive = false;
                          });
                        },
                        child: Text(
                          '대형',
                          style: TextStyle(
                            color: big
                                ? Theme.of(context).colorScheme.background
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 228,
            ),
            SizedBox(
              height: 54,
              width: 356,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(isButtonActive
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
                        saveHouseName();
                        Get.to(
                          const MakeHousePage3(),
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
