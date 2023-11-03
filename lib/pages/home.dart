import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dangcheck/my%20classes/message.dart';
import 'package:dangcheck/pages/chat.dart';
import 'package:dangcheck/pages/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final String currentCode;

  const HomePage({super.key, required this.currentCode});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String houseName = '';

  int foodCheck = 0;
  int snackCheck = 0;
  int showerCheck = 0;
  int walkCheck = 0;

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

  String showerPeriod = '';
  String walkPeriod = '';
  int noOfFood = 0;
  int noOfSnack = 0;
  int noOfShower = 0;
  int noOfWalk = 0;
  int totalFood = 0;
  int totalSnack = 0;
  int iconIndex = 2;

  List foodList = [];
  List snackList = [];
  String updateData = '';
  String updateCollection = '';

  int _selectedIndex = 0;

  int foodtime = 0;
  int snacktime = 0;
  int showertime = 0;
  int walktime = 0;

  int foodTimeDifference = 0;
  int snackTimeDifference = 0;
  int showerTimeDifference = 0;
  int walkTimeDifference = 0;

  String nickName = '';
  String recentWho1 = '';
  String recentWho2 = '';
  String recentWho3 = '';
  String recentWho4 = '';
  String recentWhat1 = '';
  String recentWhat2 = '';

  List<Widget> _pages = [];
  List<AssetImage> images = [
    const AssetImage('assets/images/dog.png'),
    const AssetImage('assets/images/dog2.png'),
    const AssetImage('assets/images/dog_bg.png'),
  ];

  @override
  void initState() {
    _pages = [
      ChatPage(currentCode: widget.currentCode),
      SettingPage(
        currentCode: widget.currentCode,
      )
    ];
    super.initState();
    resetInfo();
    getInfo();
    listenForUpdates();
  }

  resetInfo() {
    TimeOfDay scheduledTime = const TimeOfDay(hour: 0, minute: 0);

    DateTime now = DateTime.now();
    DateTime scheduledDateTime = DateTime(
        now.year, now.month, now.day, scheduledTime.hour, scheduledTime.minute);

    if (now.isAfter(scheduledDateTime)) {
      scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
    }

    Duration initialDelay = scheduledDateTime.difference(now);

    Timer.periodic(const Duration(days: 1), (timer) {
      foodCheck = 0;
      snackCheck = 0;
    });

    Timer(Duration(milliseconds: initialDelay.inMilliseconds), () {
      foodCheck = 0;
      snackCheck = 0;
    });
  }

  void listenForUpdates() {
    FirebaseFirestore.instance
        .collection('house')
        .doc(widget.currentCode)
        .collection('dog status')
        .doc('status')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        setState(() {
          foodCheck = snapshot.get('food status');
          snackCheck = snapshot.get('snack status');
          showerCheck = snapshot.get('shower status');
          walkCheck = snapshot.get('walk status');
        });
      }
    });
  }

  /* DB Read */
  Future getInfo() async {
    DocumentSnapshot documentSnapshot1 = await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.currentCode)
        .get();

    DocumentSnapshot documentSnapshot3 = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();

    houseName = documentSnapshot1.get('하우스 이름');
    noOfFood = documentSnapshot1.get('식사 개수');
    noOfSnack = documentSnapshot1.get('간식 개수');
    noOfShower = documentSnapshot1.get('목욕 횟수');
    noOfWalk = documentSnapshot1.get('산책 횟수');
    showerPeriod = documentSnapshot1.get('목욕 주기');
    walkPeriod = documentSnapshot1.get('산책 주기');
    totalFood = documentSnapshot1.get('식사 횟수');
    totalSnack = documentSnapshot1.get('간식 횟수');
    iconIndex = documentSnapshot1.get('강아지 아이콘');

    for (int i = 0; i < noOfFood; i++) {
      foodList.add(documentSnapshot1.get('식사 메뉴 ${i + 1}'));
    }
    for (int i = 0; i < noOfSnack; i++) {
      snackList.add(documentSnapshot1.get('간식 메뉴 ${i + 1}'));
    }

    nickName = documentSnapshot3.get('nickname');

    setState(() {});
  }

  /* DB Delete */
  Future removeInfo(int type) async {
    String updateName = '';
    int updateValue = 0;

    if (type == 1) {
      if (foodCheck > 0) foodCheck--;
      updateValue = foodCheck;
      updateName = 'food status';
      updateCollection = 'food time';
    } else if (type == 2) {
      if (snackCheck > 0) snackCheck--;
      updateValue = snackCheck;
      updateName = 'snack status';
      updateCollection = 'snack time';
    } else if (type == 3) {
      showerCheck = 0;
      updateValue = showerCheck;
      updateName = 'shower status';
      updateCollection = 'shower time';
    } else if (type == 4) {
      walkCheck = 0;
      updateValue = walkCheck;
      updateName = 'walk status';
      updateCollection = 'walk time';
    }

    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.currentCode)
        .collection(updateCollection)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final recentDocument = querySnapshot.docs[0];

        recentDocument.reference.delete().then((_) {
          print("가장 최근 document가 삭제되었습니다.");
        }).catchError((error) {
          print("삭제 중 오류 발생: $error");
        });
      } else {
        print("삭제할 document가 없습니다.");
      }
    }).catchError((error) {
      print("데이터 가져오기 중 오류 발생: $error");
    });

    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.currentCode)
        .collection('dog status')
        .doc('status')
        .update({
      updateName: updateValue,
    });
  }

  /* DB Create */
  Future addInfo(String type, String updateData) async {
    String updateName = '';
    String updateNameTime = '';
    int updateValue = 0;

    if (type == "밥") {
      if (foodCheck < totalFood) foodCheck++;
      updateValue = foodCheck;
      updateName = 'food status';
      updateNameTime = 'food time';
    } else if (type == "간식") {
      if (snackCheck < totalSnack) snackCheck++;
      updateValue = snackCheck;
      updateName = 'snack status';
      updateNameTime = 'snack time';
    } else if (type == "목욕") {
      showerCheck = 1;
      updateValue = showerCheck;
      updateName = 'shower status';
      updateNameTime = 'shower time';
    } else if (type == "산책") {
      walkCheck = 1;
      updateValue = walkCheck;
      updateName = 'walk status';
      updateNameTime = 'walk time';
    }

    await FirebaseFirestore.instance
        .collection('house')
        .doc(widget.currentCode)
        .collection('dog status')
        .doc('status')
        .update({
      updateName: updateValue,
    });

    CollectionReference collectionReference1 = FirebaseFirestore.instance
        .collection('house')
        .doc(widget.currentCode)
        .collection(updateNameTime);

    collectionReference1.add({
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'what': updateData,
      'who': nickName,
    });
  }

  /* BottomDrawer1 */
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
                                        addInfo(type, updateData);
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
                                    if (type == '밥') {
                                      updateData = foodList[index];
                                    } else {
                                      updateData = snackList[index];
                                    }
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

  /* BottomDrawer2 */
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
                                        addInfo(type, updateData);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    type == '목욕'
                                        ? '$showerPeriod에'
                                        : '$walkPeriod에',
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    type == '목욕'
                                        ? '$noOfShower번'
                                        : '$noOfWalk번',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ],
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('house')
                                      .doc(widget.currentCode)
                                      .collection(type == '목욕'
                                          ? 'shower time'
                                          : 'walk time')
                                      .orderBy('timestamp', descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      if (snapshot.hasData) {
                                        final querySnapshot = snapshot.data;
                                        if (querySnapshot!.docs.isNotEmpty) {
                                          final mostRecentDocument =
                                              querySnapshot.docs.first;

                                          type == '목욕'
                                              ? showertime = mostRecentDocument
                                                  .get('timestamp') as int
                                              : walktime = mostRecentDocument
                                                  .get('timestamp') as int;

                                          type == '목욕'
                                              ? showerTimeDifference = (DateTime
                                                              .now()
                                                          .millisecondsSinceEpoch -
                                                      showertime) ~/
                                                  1000
                                              : walkTimeDifference = (DateTime
                                                              .now()
                                                          .millisecondsSinceEpoch -
                                                      walktime) ~/
                                                  1000;

                                          print(
                                              '실시간 시간: $showerTimeDifference초');
                                        } else {
                                          type == '목욕'
                                              ? showerTimeDifference = 0
                                              : walkTimeDifference = 0;
                                          print('컬렉션에 문서가 없습니다.');
                                        }
                                      }
                                    }
                                    int timeDifference = type == '목욕'
                                        ? showerTimeDifference
                                        : walkTimeDifference;
                                    if (timeDifference > 0 &&
                                        timeDifference < 60) {
                                      return Text('방금 전에 $type했어요');
                                    } else if (timeDifference >= 60 &&
                                        timeDifference < 60 * 60) {
                                      return Text(
                                          '${timeDifference ~/ 60}분 전에 $type했어요');
                                    } else if (timeDifference >= 60 * 60 &&
                                        timeDifference < 60 * 60 * 24) {
                                      return Text(
                                          '${timeDifference ~/ (60 * 60)}시간 전에 $type했어요');
                                    } else if (timeDifference >= 60 * 60 * 24) {
                                      return Text(
                                          '${timeDifference ~/ (60 * 60 * 24)}일 전에 $type했어요');
                                    } else {
                                      return Text('아직 $type을 안했어요!');
                                    }
                                  }),
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

  /* AlertDialog */
  Future<dynamic> myAlertDialog(BuildContext context, int time,
      String recentWhat, String recentWho, String type) {
    String pastTime = '';

    if (time >= 0 && time < 60) {
      pastTime = '방금';
    } else if (time > 60 && time < 60 * 60) {
      pastTime = '${time ~/ 60}분';
    } else if (time > 60 * 60 && time < 60 * 60 * 24) {
      pastTime = '${time ~/ (60 * 60)}시간';
    } else if (time > 60 * 60 * 24) {
      pastTime = '${time ~/ (60 * 60 * 24)}일';
    }

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
          contentPadding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
          content: SizedBox(
            height: 42,
            width: 305,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (type == '밥' || type == '간식')
                    ? Text('$pastTime 전에 ‘$recentWhat’를 주었습니다.')
                    : Text('$pastTime 전에 $recentWho가 $recentWhat을 시켰습니다.'),
                (type == '밥' || type == '간식')
                    ? Text('그래도 다시 $type을 주시겠습니까?')
                    : Text('그래도 다시 $type을 시키겠습니까?'),
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
                      Get.back();
                      if (type == '밥') myBottomDrawer(context, type, noOfFood);
                      if (type == '간식') {
                        myBottomDrawer(context, type, noOfSnack);
                      }
                      if (type == '목욕') {
                        myBottomDrawer2(context, type);
                      }
                      if (type == '산책') myBottomDrawer2(context, type);
                    },
                    child: Text(
                      (type == '밥' || type == '간식')
                          ? '다시 급여'
                          : type == '목욕'
                              ? '다시 목욕'
                              : '다시 산책',
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

  /* Build */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          houseName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: '210 Gulim',
          ),
        ),
        backgroundColor: const Color(0xFFFFFAF4),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        for (int i = 0; i < totalFood - foodCheck; i++)
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
                                removeInfo(1);
                                setState(() {
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
                        for (int i = 0; i < totalSnack - snackCheck; i++)
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
                                removeInfo(2);
                                setState(() {
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
                        if (showerCheck == 0)
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
                                removeInfo(3);
                                setState(() {
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
                        if (walkCheck == 0)
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
                                removeInfo(4);
                                setState(() {
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
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 330,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    width: 190,
                    height: 270,
                    image: images[iconIndex],
                  ),
                  isMessage1
                      ? Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('house')
                                    .doc(widget.currentCode)
                                    .collection('food time')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      final querySnapshot = snapshot.data;
                                      if (querySnapshot!.docs.isNotEmpty) {
                                        final mostRecentDocument =
                                            querySnapshot.docs.first;

                                        foodtime = mostRecentDocument
                                            .get('timestamp') as int;

                                        recentWho1 = mostRecentDocument
                                            .get('who') as String;

                                        recentWhat1 = mostRecentDocument
                                            .get('what') as String;

                                        foodTimeDifference = (DateTime.now()
                                                    .millisecondsSinceEpoch -
                                                foodtime) ~/
                                            1000;

                                        print('실시간 시간: $foodTimeDifference초');
                                      } else {
                                        print('컬렉션에 문서가 없습니다.');
                                      }
                                    }
                                  }
                                  int timeDifference = foodTimeDifference;
                                  if (timeDifference > 0 &&
                                      timeDifference < 60) {
                                    return Message(
                                        message:
                                            '$recentWho1가 방금 전에 $recentWhat1를 줬어멍!');
                                  } else if (timeDifference >= 60 &&
                                      timeDifference < 60 * 60) {
                                    return Message(
                                        message:
                                            '$recentWho1가 ${timeDifference ~/ 60}분 전에 $recentWhat1를 줬어멍!');
                                  } else if (timeDifference >= 60 * 60 &&
                                      timeDifference < 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho1가 ${timeDifference ~/ (60 * 60)}시간 전에 $recentWhat1를 줬어멍!');
                                  } else if (timeDifference >= 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho1가 ${timeDifference ~/ (60 * 60 * 24)}일 전에 $recentWhat1를 줬어멍!');
                                  } else {
                                    return const Message(
                                        message: '아직 사료를 안 줬어멍!');
                                  }
                                }),
                          ),
                        )
                      : Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('house')
                                    .doc(widget.currentCode)
                                    .collection('food time')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      final querySnapshot = snapshot.data;
                                      if (querySnapshot!.docs.isNotEmpty) {
                                        final mostRecentDocument =
                                            querySnapshot.docs.first;

                                        foodtime = mostRecentDocument
                                            .get('timestamp') as int;

                                        recentWho1 = mostRecentDocument
                                            .get('who') as String;

                                        recentWhat1 = mostRecentDocument
                                            .get('what') as String;

                                        foodTimeDifference = (DateTime.now()
                                                    .millisecondsSinceEpoch -
                                                foodtime) ~/
                                            1000;

                                        print('실시간 시간: $foodTimeDifference초');
                                      } else {
                                        print('컬렉션에 문서가 없습니다.');
                                      }
                                    }
                                  }
                                  int timeDifference = foodTimeDifference;
                                  if (timeDifference > 0 &&
                                      timeDifference < 60) {
                                    return Message(
                                        message:
                                            '$recentWho1가 방금 전에 $recentWhat1를 줬어멍!');
                                  } else if (timeDifference >= 60 &&
                                      timeDifference < 60 * 60) {
                                    return Message(
                                        message:
                                            '$recentWho1가 ${timeDifference ~/ 60}분 전에 $recentWhat1를 줬어멍!');
                                  } else if (timeDifference >= 60 * 60 &&
                                      timeDifference < 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho1가 ${timeDifference ~/ (60 * 60)}시간 전에 $recentWhat1를 줬어멍!');
                                  } else if (timeDifference >= 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho1가 ${timeDifference ~/ (60 * 60 * 24)}일 전에 $recentWhat1를 줬어멍!');
                                  } else {
                                    return const Message(
                                        message: '아직 사료를 안 줬어멍!');
                                  }
                                }),
                          ),
                        ),
                  isMessage2
                      ? Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('house')
                                    .doc(widget.currentCode)
                                    .collection('snack time')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      final querySnapshot = snapshot.data;
                                      if (querySnapshot!.docs.isNotEmpty) {
                                        final mostRecentDocument =
                                            querySnapshot.docs.first;

                                        snacktime = mostRecentDocument
                                            .get('timestamp') as int;

                                        recentWho2 = mostRecentDocument
                                            .get('who') as String;

                                        recentWhat2 = mostRecentDocument
                                            .get('what') as String;

                                        snackTimeDifference = (DateTime.now()
                                                    .millisecondsSinceEpoch -
                                                snacktime) ~/
                                            1000;

                                        print('실시간 시간: $snackTimeDifference초');
                                      } else {
                                        print('컬렉션에 문서가 없습니다.');
                                      }
                                    }
                                  }
                                  int timeDifference = snackTimeDifference;
                                  if (timeDifference > 0 &&
                                      timeDifference < 60) {
                                    return Message(
                                        message:
                                            '$recentWho2가 방금 전에 $recentWhat2를 줬어멍!');
                                  } else if (timeDifference >= 60 &&
                                      timeDifference < 60 * 60) {
                                    return Message(
                                        message:
                                            '$recentWho2가 ${timeDifference ~/ 60}분 전에 $recentWhat2를 줬어멍!');
                                  } else if (timeDifference >= 60 * 60 &&
                                      timeDifference < 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho2가 ${timeDifference ~/ (60 * 60)}시간 전에 $recentWhat2를 줬어멍!');
                                  } else if (timeDifference >= 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho2가 ${timeDifference ~/ (60 * 60 * 24)}일 전에 $recentWhat2를 줬어멍!');
                                  } else {
                                    return const Message(
                                        message: '아직 사료를 안 줬어멍!');
                                  }
                                }),
                          ),
                        )
                      : Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('house')
                                    .doc(widget.currentCode)
                                    .collection('snack time')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      final querySnapshot = snapshot.data;
                                      if (querySnapshot!.docs.isNotEmpty) {
                                        final mostRecentDocument =
                                            querySnapshot.docs.first;

                                        snacktime = mostRecentDocument
                                            .get('timestamp') as int;

                                        recentWho2 = mostRecentDocument
                                            .get('who') as String;

                                        recentWhat2 = mostRecentDocument
                                            .get('what') as String;

                                        snackTimeDifference = (DateTime.now()
                                                    .millisecondsSinceEpoch -
                                                snacktime) ~/
                                            1000;

                                        print('실시간 시간: $snackTimeDifference초');
                                      } else {
                                        print('컬렉션에 문서가 없습니다.');
                                      }
                                    }
                                  }
                                  int timeDifference = snackTimeDifference;
                                  if (timeDifference > 0 &&
                                      timeDifference < 60) {
                                    return Message(
                                        message:
                                            '$recentWho2가 방금 전에 $recentWhat2를 줬어멍!');
                                  } else if (timeDifference >= 60 &&
                                      timeDifference < 60 * 60) {
                                    return Message(
                                        message:
                                            '$recentWho2가 ${timeDifference ~/ 60}분 전에 $recentWhat2를 줬어멍!');
                                  } else if (timeDifference >= 60 * 60 &&
                                      timeDifference < 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho2가 ${timeDifference ~/ (60 * 60)}시간 전에 $recentWhat2를 줬어멍!');
                                  } else if (timeDifference >= 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho2가 ${timeDifference ~/ (60 * 60 * 24)}일 전에 $recentWhat2를 줬어멍!');
                                  } else {
                                    return const Message(
                                        message: '아직 사료를 안 줬어멍!');
                                  }
                                }),
                          ),
                        ),
                  isMessage3
                      ? Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('house')
                                    .doc(widget.currentCode)
                                    .collection('shower time')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      final querySnapshot = snapshot.data;
                                      if (querySnapshot!.docs.isNotEmpty) {
                                        final mostRecentDocument =
                                            querySnapshot.docs.first;

                                        showertime = mostRecentDocument
                                            .get('timestamp') as int;

                                        recentWho3 = mostRecentDocument
                                            .get('who') as String;

                                        showerTimeDifference = (DateTime.now()
                                                    .millisecondsSinceEpoch -
                                                showertime) ~/
                                            1000;

                                        print('실시간 시간: $showerTimeDifference초');
                                      } else {
                                        print('컬렉션에 문서가 없습니다.');
                                      }
                                    }
                                  }
                                  int timeDifference = showerTimeDifference;
                                  if (timeDifference > 0 &&
                                      timeDifference < 60) {
                                    return Message(
                                        message:
                                            '$recentWho3가 방금 전에 목욕을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 &&
                                      timeDifference < 60 * 60) {
                                    return Message(
                                        message:
                                            '$recentWho3가 ${timeDifference ~/ 60}분 전에 목욕을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 * 60 &&
                                      timeDifference < 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho3가 ${timeDifference ~/ (60 * 60)}시간 전에 목욕을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho3가 ${timeDifference ~/ (60 * 60 * 24)}일 전에 목욕을 시켜줬어멍!');
                                  } else {
                                    return const Message(
                                        message: '아직 목욕을 안 시켜줬어멍!');
                                  }
                                }),
                          ),
                        )
                      : Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('house')
                                    .doc(widget.currentCode)
                                    .collection('shower time')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      final querySnapshot = snapshot.data;
                                      if (querySnapshot!.docs.isNotEmpty) {
                                        final mostRecentDocument =
                                            querySnapshot.docs.first;

                                        showertime = mostRecentDocument
                                            .get('timestamp') as int;

                                        recentWho3 = mostRecentDocument
                                            .get('who') as String;

                                        showerTimeDifference = (DateTime.now()
                                                    .millisecondsSinceEpoch -
                                                showertime) ~/
                                            1000;

                                        print('실시간 시간: $showerTimeDifference초');
                                      } else {
                                        print('컬렉션에 문서가 없습니다.');
                                      }
                                    }
                                  }
                                  int timeDifference = showerTimeDifference;
                                  if (timeDifference > 0 &&
                                      timeDifference < 60) {
                                    return Message(
                                        message:
                                            '$recentWho3가 방금 전에 목욕을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 &&
                                      timeDifference < 60 * 60) {
                                    return Message(
                                        message:
                                            '$recentWho3가 ${timeDifference ~/ 60}분 전에 목욕을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 * 60 &&
                                      timeDifference < 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho3가 ${timeDifference ~/ (60 * 60)}시간 전에 목욕을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho3가 ${timeDifference ~/ (60 * 60 * 24)}일 전에 목욕을 시켜줬어멍!');
                                  } else {
                                    return const Message(
                                        message: '아직 목욕을 안 시켜줬어멍!');
                                  }
                                }),
                          ),
                        ),
                  isMessage4
                      ? Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('house')
                                    .doc(widget.currentCode)
                                    .collection('walk time')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      final querySnapshot = snapshot.data;
                                      if (querySnapshot!.docs.isNotEmpty) {
                                        final mostRecentDocument =
                                            querySnapshot.docs.first;

                                        walktime = mostRecentDocument
                                            .get('timestamp') as int;

                                        recentWho4 = mostRecentDocument
                                            .get('who') as String;

                                        walkTimeDifference = (DateTime.now()
                                                    .millisecondsSinceEpoch -
                                                walktime) ~/
                                            1000;

                                        print('실시간 시간: $walkTimeDifference초');
                                      } else {
                                        print('컬렉션에 문서가 없습니다.');
                                      }
                                    }
                                  }
                                  int timeDifference = walkTimeDifference;
                                  if (timeDifference > 0 &&
                                      timeDifference < 60) {
                                    return Message(
                                        message:
                                            '$recentWho4가 방금 전에 산책을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 &&
                                      timeDifference < 60 * 60) {
                                    return Message(
                                        message:
                                            '$recentWho4가 ${timeDifference ~/ 60}분 전에 산책을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 * 60 &&
                                      timeDifference < 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho4가 ${timeDifference ~/ (60 * 60)}시간 전에 산책을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho4가 ${timeDifference ~/ (60 * 60 * 24)}일 전에 산책을 시켜줬어멍!');
                                  } else {
                                    return const Message(
                                        message: '아직 산책을 안 시켜줬어멍!');
                                  }
                                }),
                          ),
                        )
                      : Positioned(
                          bottom: 260,
                          child: AnimatedOpacity(
                            opacity: 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('house')
                                    .doc(widget.currentCode)
                                    .collection('walk time')
                                    .orderBy('timestamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      final querySnapshot = snapshot.data;
                                      if (querySnapshot!.docs.isNotEmpty) {
                                        final mostRecentDocument =
                                            querySnapshot.docs.first;

                                        walktime = mostRecentDocument
                                            .get('timestamp') as int;

                                        recentWho4 = mostRecentDocument
                                            .get('who') as String;

                                        walkTimeDifference = (DateTime.now()
                                                    .millisecondsSinceEpoch -
                                                walktime) ~/
                                            1000;

                                        print('실시간 시간: $walkTimeDifference초');
                                      } else {
                                        print('컬렉션에 문서가 없습니다.');
                                      }
                                    }
                                  }
                                  int timeDifference = walkTimeDifference;
                                  if (timeDifference > 0 &&
                                      timeDifference < 60) {
                                    return Message(
                                        message:
                                            '$recentWho4가 방금 전에 산책을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 &&
                                      timeDifference < 60 * 60) {
                                    return Message(
                                        message:
                                            '$recentWho4가 ${timeDifference ~/ 60}분 전에 산책을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 * 60 &&
                                      timeDifference < 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho4가 ${timeDifference ~/ (60 * 60)}시간 전에 산책을 시켜줬어멍!');
                                  } else if (timeDifference >= 60 * 60 * 24) {
                                    return Message(
                                        message:
                                            '$recentWho4가 ${timeDifference ~/ (60 * 60 * 24)}일 전에 산책을 시켜줬어멍!');
                                  } else {
                                    return const Message(
                                        message: '아직 산책을 안 시켜줬어멍!');
                                  }
                                }),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 5),
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
                          if (foodCheck > 0) {
                            if (foodTimeDifference > 60 * 60) {
                              myBottomDrawer(context, '밥', noOfFood);
                            } else {
                              myAlertDialog(context, foodTimeDifference,
                                  recentWhat1, recentWho1, '밥');
                            }
                          } else {
                            myBottomDrawer(context, '밥', noOfFood);
                          }
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
                          if (snackCheck > 0) {
                            if (snackTimeDifference > 60 * 60) {
                              myBottomDrawer(context, '간식', noOfSnack);
                            } else {
                              myAlertDialog(context, snackTimeDifference,
                                  recentWhat2, recentWho2, '간식');
                            }
                          } else {
                            myBottomDrawer(context, '간식', noOfSnack);
                          }
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
                          if (showerCheck > 0) {
                            if (showerTimeDifference > 60 * 60) {
                              myBottomDrawer2(context, '목욕');
                            } else {
                              myAlertDialog(context, showerTimeDifference, '목욕',
                                  recentWho3, '목욕');
                            }
                          } else {
                            myBottomDrawer2(context, '목욕');
                          }
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
                          if (walkCheck > 0) {
                            if (walkTimeDifference > 60 * 60) {
                              myBottomDrawer2(context, '산책');
                            } else {
                              myAlertDialog(context, walkTimeDifference, '산책',
                                  recentWho4, '산책');
                            }
                          } else {
                            myBottomDrawer2(context, '산책');
                          }
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
                  transition: Transition.downToUp,
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
