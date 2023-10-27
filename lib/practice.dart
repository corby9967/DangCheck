import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future firebaseShoot() async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection("cars").doc("123456789").update(
        {
          "brand": "Genebsdfsdfro",
        },
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              firebaseShoot();
            },
            icon: const Icon(Icons.abc),
          ),
        ],
      ),
    );
  }
}
