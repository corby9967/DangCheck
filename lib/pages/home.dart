import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int foodCircle = 1;
  final int snackCircle = 3;

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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.rice_bowl_rounded,
                        size: 35,
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < foodCircle; i++)
                          Icon(
                            Icons.circle_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 16,
                          ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shower_rounded,
                        size: 35,
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < snackCircle; i++)
                          Icon(
                            Icons.circle_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 16,
                          ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.rice_bowl_rounded,
                        size: 35,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shower_rounded,
                        size: 35,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
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
