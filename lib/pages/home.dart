import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int foodCheck = 2;
  final int snackCheck = 0;
  final bool showerCheck = true;
  final bool walkCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    if (foodCheck == 0)
                      const Image(
                        image: AssetImage('assets/images/food_0.png'),
                      )
                    else
                      const Image(
                        image: AssetImage('assets/images/food_1.png'),
                      ),
                    Row(
                      children: [
                        for (int i = 0; i < foodCheck; i++)
                          Icon(
                            Icons.circle_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 16,
                          ),
                        for (int i = 0; i < 4 - foodCheck; i++)
                          const Icon(
                            Icons.circle_rounded,
                            color: Colors.black12,
                            size: 16,
                          ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    if (snackCheck == 0)
                      const Image(
                        image: AssetImage('assets/images/snack_0.png'),
                      )
                    else
                      const Image(
                        image: AssetImage('assets/images/snack_1.png'),
                      ),
                    Row(
                      children: [
                        for (int i = 0; i < snackCheck; i++)
                          Icon(
                            Icons.circle_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 16,
                          ),
                        for (int i = 0; i < 4 - snackCheck; i++)
                          const Icon(
                            Icons.circle_rounded,
                            color: Colors.black12,
                            size: 16,
                          ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    if (showerCheck == false)
                      const Image(
                        image: AssetImage('assets/images/shower_0.png'),
                      )
                    else
                      const Image(
                        image: AssetImage('assets/images/shower_1.png'),
                      ),
                    const SizedBox(
                      height: 16,
                      width: 64,
                    )
                  ],
                ),
                Column(
                  children: [
                    if (walkCheck == false)
                      const Image(
                        image: AssetImage('assets/images/walk_0.png'),
                      )
                    else
                      const Image(
                        image: AssetImage('assets/images/walk_1.png'),
                      ),
                    const SizedBox(
                      height: 16,
                      width: 64,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 450,
            ),
            FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: 0,
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
    );
  }
}
