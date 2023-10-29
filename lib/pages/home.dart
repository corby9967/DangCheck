import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/pages/make_house_pages/make_house_final.dart';
import 'package:dangcheck/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my classes/message.dart';
import 'chat.dart';

class HomePage extends StatefulWidget {
  final String currentCode;
  final String houseName;
  const HomePage(
      {super.key, required this.currentCode, required this.houseName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int foodCheck = 0;
  int snackCheck = 0;
  bool showerCheck = false;
  bool walkCheck = false;

  bool isButtonClicked = true;
  bool isLongTapped1 = false;
  bool isLongTapped2 = false;
  bool isLongTapped3 = false;
  bool isLongTapped4 = false;

  Alignment alignment1 = const Alignment(0, 0);
  Alignment alignment2 = const Alignment(0, 0);
  Alignment alignment3 = const Alignment(0, 0);
  Alignment alignment4 = const Alignment(0, 0);

  double size = 40;

  bool isMessage1 = false;
  bool isMessage2 = false;
  bool isMessage3 = false;
  bool isMessage4 = false;

  String message1 = '지원이가 7시간 전에 사료을 줬어멍!';
  String message2 = '지원이가 1시간 전에 뼈껌을 줬어멍!';
  String message3 = '지원이가 6시간 전에 목욕을 시켜 줬어멍!';
  String message4 = '지원이가 4시간 전에 산책을 시켜 줬어멍!';

  String showerPeriod = '';
  String walkPeriod = '';
  int noOfFood = 0;
  int noOfSnack = 0;
  int noOfShower = 0;
  int noOfWalk = 0;

  List foodList = [];
  List snackList = [];

  int _selectedIndex = 0;


  final List<Widget> _pages = [const ChatPage(), const SettingPage()];


  @override
  void initState() {
    getInfo();
    super.initState();
  }

  Future getInfo() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.currentCode)
        .get();

    noOfFood = documentSnapshot.get('음식 개수');
    noOfSnack = documentSnapshot.get('간식 개수');
    noOfShower = documentSnapshot.get('목욕 횟수');
    noOfWalk = documentSnapshot.get('산책 횟수');
    showerPeriod = documentSnapshot.get('목욕 주기');
    walkPeriod = documentSnapshot.get('산책 주기');

    for (int i = 0; i < noOfFood; i++) {
      foodList.add(documentSnapshot.get('식사 메뉴 ${i + 1}'));
    }
    for (int i = 0; i < noOfSnack; i++) {
      snackList.add(documentSnapshot.get('간식 메뉴 ${i + 1}'));
    }
  }

  Future<dynamic> myBottomDrawer(BuildContext context, String type, int no) {
    List<bool> isChecked = [];
    for (int i = 0; i < no; i++) {
      isChecked.add(false);
    }
    bool b = false;

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter myState) {
          return SingleChildScrollView(
            child: Container(
              height: 400,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: 375,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '멍췤이의 $type 선택',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  myState(() {
                                    setState(() {
                                      if (b) {
                                        type == '밥'
                                            ? foodCheck < 4
                                                ? foodCheck++
                                                : foodCheck
                                            : snackCheck < 4
                                                ? snackCheck++
                                                : snackCheck;
                                      }
                                    });
                                  });

                                  if (b) Navigator.of(context).pop();
                                },
                                child: Text(
                                  '선택',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: b
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.black45),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 19,
                        vertical: 20,
                      ),
                      itemCount: no,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              '🍚 ${index + 1}번째 $type 메뉴',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                myState(() {
                                  setState(() {
                                    for (int i = 0; i < isChecked.length; i++) {
                                      if (i == index) {
                                        isChecked[i] = true;
                                      } else {
                                        isChecked[i] = false;
                                      }
                                    }
                                    b = true;
                                  });
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  border: isChecked[index]
                                      ? Border(
                                          top: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            width: 2,
                                          ),
                                          bottom: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            width: 2,
                                          ),
                                          left: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            width: 2,
                                          ),
                                          right: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            width: 2,
                                          ),
                                        )
                                      : const Border(
                                          top: BorderSide(
                                            color: Colors.black12,
                                            width: 2,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black12,
                                            width: 2,
                                          ),
                                          left: BorderSide(
                                            color: Colors.black12,
                                            width: 2,
                                          ),
                                          right: BorderSide(
                                            color: Colors.black12,
                                            width: 2,
                                          ),
                                        ),
                                ),
                                width: 337,
                                height: 54,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      type == '밥'
                                          ? Text(
                                              foodList[index],
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            )
                                          : Text(
                                              snackList[index],
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: isChecked[index]
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.black12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future<dynamic> myBottomDrawer2(BuildContext context, String type) {
    bool isTapped = false;

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter myState) {
          return SingleChildScrollView(
            child: Container(
              height: 300,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: 375,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '멍췤이의 $type',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  myState(() {
                                    setState(() {
                                      if (isTapped) {
                                        type == '목욕'
                                            ? showerCheck = true
                                            : walkCheck = true;
                                      }
                                    });
                                  });
                                  if (isTapped) Navigator.of(context).pop();
                                },
                                child: Text(
                                  '완료',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isTapped
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type == '목욕' ? '🛁 목욕 주기' : '🐕 산책 주기',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          width: 337,
                          height: 54,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFE8E8E8)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                type == '목욕'
                                    ? '$showerPeriod에'
                                    : '$walkPeriod에',
                              ),
                              const SizedBox(width: 7),
                              Text(
                                type == '목욕' ? '$noOfShower번' : '$noOfWalk번',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              const SizedBox(width: 100),
                              Text('4일 전에 $type했어요'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: () {
                            myState(() {
                              setState(() {
                                isTapped = !isTapped;
                              });
                            });
                          },
                          child: Container(
                            width: 337,
                            height: 54,
                            decoration: ShapeDecoration(
                              color: isTapped
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFFF9519)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$type했어요!',
                                  style: TextStyle(
                                    color: isTapped
                                        ? Colors.white
                                        : const Color(0xFFFF9519),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future<dynamic> myAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          alignment: Alignment.center,
          iconPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          icon: Icon(
            Icons.error_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 48,
          ),
          contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          content: const SizedBox(
            height: 42,
            width: 305,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('1시간 전에 ‘멍멍이표 사료’를 주었습니다.'),
                Text('그래도 다시 밥을 주시겠습니까?'),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.fromLTRB(0, 18, 0, 20),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '취소',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '다시 급여',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.houseName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFFFFAF4),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (foodCheck == 0)
                      const Column(
                        children: [
                          SizedBox(height: 7.0),
                          Image(
                            image: AssetImage('assets/images/food_0.png'),
                          ),
                          SizedBox(height: 7.0),
                        ],
                      )
                    else
                      GestureDetector(
                        child: const Text(
                          '🍚',
                          style: TextStyle(fontSize: 32),
                        ),
                        onLongPress: () {
                          setState(() {
                            isLongTapped1 = !isLongTapped1;
                            isLongTapped2 = false;
                            isLongTapped3 = false;
                            isLongTapped4 = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            isMessage1 = !isMessage1;
                            isMessage2 = false;
                            isMessage3 = false;
                            isMessage4 = false;
                          });
                        },
                      ),
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        for (int i = 0; i < foodCheck; i++)
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: const OvalBorder(),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        for (int i = 0; i < 4 - foodCheck; i++)
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const ShapeDecoration(
                                  color: Colors.black12,
                                  shape: OvalBorder(),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                      ],
                    ),
                    isLongTapped1
                        ? SizedBox(
                            width: 65,
                            height: 40,
                            child: GestureDetector(
                              child: const Icon(
                                Icons.highlight_remove_rounded,
                                size: 22,
                                color: Colors.black26,
                              ),
                              onTap: () {
                                setState(() {
                                  foodCheck > 0 ? foodCheck-- : foodCheck;
                                  isLongTapped1 = !isLongTapped1;
                                });
                              },
                            ),
                          )
                        : const SizedBox(width: 65, height: 40),
                  ],
                ),
                Column(
                  children: [
                    if (snackCheck == 0)
                      const Column(
                        children: [
                          SizedBox(height: 7.0),
                          Image(
                            image: AssetImage('assets/images/snack_0.png'),
                          ),
                          SizedBox(height: 7.0),
                        ],
                      )
                    else
                      GestureDetector(
                        child: const Text(
                          '🦴',
                          style: TextStyle(fontSize: 32),
                        ),
                        onLongPress: () {
                          setState(() {
                            isLongTapped1 = false;
                            isLongTapped2 = !isLongTapped2;
                            isLongTapped3 = false;
                            isLongTapped4 = false;
                          });
                        },
                        onTap: () {
                          setState(() {
                            isMessage1 = false;
                            isMessage2 = !isMessage2;
                            isMessage3 = false;
                            isMessage4 = false;
                          });
                        },
                      ),
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        for (int i = 0; i < snackCheck; i++)
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: const OvalBorder(),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        for (int i = 0; i < 4 - snackCheck; i++)
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const ShapeDecoration(
                                  color: Colors.black12,
                                  shape: OvalBorder(),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                      ],
                    ),
                    isLongTapped2
                        ? SizedBox(
                            width: 65,
                            height: 40,
                            child: GestureDetector(
                              child: const Icon(
                                Icons.highlight_remove_rounded,
                                size: 22,
                                color: Colors.black26,
                              ),
                              onTap: () {
                                setState(() {
                                  snackCheck > 0 ? snackCheck-- : snackCheck;
                                  isLongTapped2 = !isLongTapped2;
                                });
                              },
                            ),
                          )
                        : const SizedBox(width: 65, height: 40),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        if (showerCheck == false)
                          const Column(
                            children: [
                              SizedBox(height: 7.0),
                              Image(
                                image: AssetImage('assets/images/shower_0.png'),
                              ),
                              SizedBox(height: 7.0),
                            ],
                          )
                        else
                          GestureDetector(
                            child: const Text(
                              '🛁',
                              style: TextStyle(fontSize: 32),
                            ),
                            onLongPress: () {
                              setState(() {
                                isLongTapped1 = false;
                                isLongTapped2 = false;
                                isLongTapped3 = !isLongTapped3;
                                isLongTapped4 = false;
                              });
                            },
                            onTap: () {
                              setState(() {
                                isMessage1 = false;
                                isMessage2 = false;
                                isMessage3 = !isMessage3;
                                isMessage4 = false;
                              });
                            },
                          ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    isLongTapped3
                        ? SizedBox(
                            width: 65,
                            height: 22,
                            child: GestureDetector(
                              child: const SizedBox(
                                width: 22,
                                height: 22,
                                child: Icon(
                                  Icons.highlight_remove_rounded,
                                  size: 22,
                                  color: Colors.black26,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showerCheck = false;
                                  isLongTapped3 = !isLongTapped3;
                                });
                              },
                            ),
                          )
                        : const SizedBox(width: 65, height: 22),
                    const SizedBox(width: 65, height: 28),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        if (walkCheck == false)
                          const Column(
                            children: [
                              SizedBox(height: 7.0),
                              Image(
                                image: AssetImage('assets/images/walk_0.png'),
                              ),
                              SizedBox(height: 7.0),
                            ],
                          )
                        else
                          GestureDetector(
                            child: const Text(
                              '🐕',
                              style: TextStyle(fontSize: 32),
                            ),
                            onLongPress: () {
                              setState(() {
                                isLongTapped1 = false;
                                isLongTapped2 = false;
                                isLongTapped3 = false;
                                isLongTapped4 = !isLongTapped4;
                              });
                            },
                            onTap: () {
                              setState(() {
                                isMessage1 = false;
                                isMessage2 = false;
                                isMessage3 = false;
                                isMessage4 = !isMessage4;
                              });
                            },
                          ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    isLongTapped4
                        ? SizedBox(
                            width: 65,
                            height: 22,
                            child: GestureDetector(
                              child: const SizedBox(
                                width: 22,
                                height: 22,
                                child: Icon(
                                  Icons.highlight_remove_rounded,
                                  size: 22,
                                  color: Colors.black26,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  walkCheck = false;
                                  isLongTapped4 = !isLongTapped4;
                                });
                              },
                            ),
                          )
                        : const SizedBox(width: 65, height: 22),
                    const SizedBox(width: 65, height: 28),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 300,
              height: 330,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Image(
                    width: 190,
                    height: 270,
                    image: AssetImage('assets/images/dog.png'),
                  ),
                  isMessage1
                      ? Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: Message(message: message1),
                          ),
                        )
                      : Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Message(message: message1),
                          ),
                        ),
                  isMessage2
                      ? Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: Message(message: message2),
                          ),
                        )
                      : Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Message(message: message2),
                          ),
                        ),
                  isMessage3
                      ? Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: Message(message: message3),
                          ),
                        )
                      : Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Message(message: message3),
                          ),
                        ),
                  isMessage4
                      ? Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: Message(message: message4),
                          ),
                        )
                      : Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Message(message: message4),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 240,
              height: 222,
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: isButtonClicked
                        ? const Duration(milliseconds: 275)
                        : const Duration(milliseconds: 875),
                    alignment: alignment1,
                    curve: isButtonClicked
                        ? Curves.fastOutSlowIn
                        : Curves.elasticOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 275),
                      curve: isButtonClicked ? Curves.easeIn : Curves.easeOut,
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          foodCheck < 4
                              ? myBottomDrawer(context, '밥', noOfFood)
                              : myAlertDialog(context);
                        },
                        child: const Center(
                          child: Text(
                            '🍚',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    duration: isButtonClicked
                        ? const Duration(milliseconds: 275)
                        : const Duration(milliseconds: 875),
                    alignment: alignment2,
                    curve: isButtonClicked
                        ? Curves.fastOutSlowIn
                        : Curves.elasticOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 275),
                      curve: isButtonClicked ? Curves.easeIn : Curves.easeOut,
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          myBottomDrawer(context, '간식', noOfSnack);
                        },
                        child: const Center(
                          child: Text(
                            '🦴',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    duration: isButtonClicked
                        ? const Duration(milliseconds: 275)
                        : const Duration(milliseconds: 875),
                    alignment: alignment3,
                    curve: isButtonClicked
                        ? Curves.fastOutSlowIn
                        : Curves.elasticOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 275),
                      curve: isButtonClicked ? Curves.easeIn : Curves.easeOut,
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          myBottomDrawer2(context, '목욕');
                        },
                        child: const Center(
                          child: Text(
                            '🛁',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    duration: isButtonClicked
                        ? const Duration(milliseconds: 275)
                        : const Duration(milliseconds: 875),
                    alignment: alignment4,
                    curve: isButtonClicked
                        ? Curves.fastOutSlowIn
                        : Curves.elasticOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 275),
                      curve: isButtonClicked ? Curves.easeIn : Curves.easeOut,
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          myBottomDrawer2(context, '산책');
                        },
                        child: const Center(
                          child: Text(
                            '🐕',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FittedBox(
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              setState(() {
                if (isButtonClicked) {
                  isButtonClicked = !isButtonClicked;
                  alignment1 = const Alignment(-0.6, -0.3);
                  alignment2 = const Alignment(-0.25, -0.7);
                  alignment3 = const Alignment(0.25, -0.7);
                  alignment4 = const Alignment(0.6, -0.3);
                } else {
                  isButtonClicked = !isButtonClicked;
                  alignment1 = const Alignment(0.0, 0.0);
                  alignment2 = const Alignment(0.0, 0.0);
                  alignment3 = const Alignment(0.0, 0.0);
                  alignment4 = const Alignment(0.0, 0.0);
                }
              });
            },
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomAppBar(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          elevation: 0,
          notchMargin: 15,
          color: Theme.of(context).colorScheme.background,
          child: Expanded(
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
                Get.to(
                  _pages[_selectedIndex],
                  transition: Transition.noTransition,
                );
              },
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
              selectedItemColor: Colors.black26,
              selectedFontSize: 13,
              unselectedItemColor: Colors.black26,
              unselectedFontSize: 13,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  label: "멤버",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  label: "설정",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
