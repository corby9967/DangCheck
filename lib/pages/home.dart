import 'package:flutter/material.dart';

import '../my classes/message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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

  bool message1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "멍췤 하우스",
          style: TextStyle(
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
                            message1 = !message1;
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
                          ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    isLongTapped3
                        ? const SizedBox(
                            width: 65,
                            height: 10,
                            child: Icon(
                              Icons.highlight_remove_rounded,
                              size: 22,
                              color: Colors.black26,
                            ),
                          )
                        : const SizedBox(width: 65, height: 10),
                    const SizedBox(width: 65, height: 40),
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
                          ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    isLongTapped4
                        ? const SizedBox(
                            width: 65,
                            height: 10,
                            child: Icon(
                              Icons.highlight_remove_rounded,
                              size: 22,
                              color: Colors.black26,
                            ),
                          )
                        : const SizedBox(width: 65, height: 10),
                    const SizedBox(width: 65, height: 40),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 17),
            message1 ? const Message() : const SizedBox(height: 60),
            const Image(
              width: 190,
              height: 280,
              image: AssetImage('assets/images/dog.png'),
            ),
            SizedBox(
              width: 250,
              height: 222,
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: isButtonClicked
                        ? const Duration(milliseconds: 275)
                        : const Duration(milliseconds: 875),
                    alignment: alignment1,
                    curve: isButtonClicked ? Curves.easeIn : Curves.easeOut,
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
                          setState(() {
                            foodCheck < 4 ? foodCheck++ : foodCheck;
                          });
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
                    curve: isButtonClicked ? Curves.easeIn : Curves.easeOut,
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
                          setState(() {
                            snackCheck < 4 ? snackCheck++ : snackCheck;
                          });
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
                    curve: isButtonClicked ? Curves.easeIn : Curves.easeOut,
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
                          setState(() {
                            showerCheck = true;
                          });
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
                    curve: isButtonClicked ? Curves.easeIn : Curves.easeOut,
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
                          setState(() {
                            walkCheck = true;
                          });
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
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
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
