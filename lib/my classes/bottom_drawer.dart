// void myBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return SingleChildScrollView(
//         child: SizedBox(
//           height: 400,
//           width: 375,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 60,
//                 width: 375,
//                 child: Center(
//                   child: Stack(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             '멍췤이의 밥 선택',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             '선택',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 19,
//                     vertical: 20,
//                   ),
//                   itemCount: 2,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 10),
//                         Text(
//                           '🍚 ${index + 1}번째 식사 메뉴',
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 5),
//                         Container(
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(16),
//                             ),
//                             border: Border(
//                               top: BorderSide(color: Colors.black12),
//                               bottom: BorderSide(color: Colors.black12),
//                               left: BorderSide(color: Colors.black12),
//                               right: BorderSide(color: Colors.black12),
//                             ),
//                           ),
//                           width: 337,
//                           height: 54,
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 15),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   '멍멍이표 사료',
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                                 Icon(
//                                   Icons.check_circle_rounded,
//                                   color: Colors.black12,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }



//   Future getLists() async {
//     await FirebaseFirestore.instance
//         .collection('house')
//         .doc('12345')
//         .get()
//         .then((snapshot) {
//       foodList = snapshot.get('foodlist');
//     });
//     setState(() {});
//   }