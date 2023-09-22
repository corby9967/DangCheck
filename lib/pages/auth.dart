// import 'package:cardmap/screen/home.dart';
// import 'package:cardmap/screen/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             //print(snapshot.data);
//             return const HomePage();
//           } else {
//             return const LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }
