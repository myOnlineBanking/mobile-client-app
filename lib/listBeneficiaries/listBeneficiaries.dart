// import 'package:app_for_test/ListCards/Person.dart';
// import 'package:app_for_test/listRecipients/add_recipient/add_recipient.dart';
// import 'package:flutter/material.dart';

// class ListBeneficiaries extends StatefulWidget {
//   @override
//   _ListBeneficiaries createState() => _ListBeneficiaries();
// }

// class _ListBeneficiaries extends State<ListBeneficiaries> {
//   final borderRad = BorderRadius.circular(15.0);
//   bool isToggled = false;
//   List<Person> beneficiaries = [
//     Person(
//         name: '12345678909',
//         profileImg: 'images/user-profile.png',
//         bio: "Software Developer"),
//     Person(
//         name: '123456789123456',
//         profileImg: 'images/cam.png',
//         bio: "UI Designer"),
//     Person(
//         name: 'Andy Smith',
//         profileImg: 'images/user-profile.png',
//         bio: "UI Designer"),
//     Person(
//         name: 'Andy Smith',
//         profileImg: 'images/user-profile.png',
//         bio: "UI Designer"),
//     Person(
//         name: 'Andy Smith',
//         profileImg: 'images/user-profile.png',
//         bio: "UI Designer"),
//     Person(
//         name: 'Andy Smith',
//         profileImg: 'images/user-profile.png',
//         bio: "UI Designer"),
//     Person(
//         name: 'Creepy Story',
//         profileImg: 'images/appLogo.jpg',
//         bio: "Software Tester")
//   ];

//   final borderside = BorderSide(
//     color: Colors.white,
//   );

//   var accountType;
//   var accountCurrency;

//   var beneficiaryController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               colors: [Colors.cyan, Colors.cyan, Colors.cyanAccent]),
//         ),
//         child: Column(
//           children: <Widget>[
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       Text(
//                         "Your Beneficiaries",
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                           color: Colors.white60,
//                         ),
//                         child: IconButton(
//                           onPressed: () => Navigator.of(context).push(
//                             MaterialPageRoute(
//                                 builder: (context) => AddRecipient()),
//                           ),
//                           icon: Icon(Icons.add_box),
//                           color: Colors.cyan,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
//                   child: Center(
//                     child: TextFormField(
//                       controller: beneficiaryController,
//                       enabled: true,
//                       decoration: InputDecoration(
//                           labelText: 'Search',
//                           labelStyle:
//                               TextStyle(color: Colors.white, fontSize: 18),
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: Colors.white,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: borderRad,
//                             borderSide: borderside,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: borderRad,
//                             borderSide: borderside,
//                           ),
//                           errorStyle: TextStyle(fontSize: 14)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//             Expanded(
//                 child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(60),
//                     topRight: Radius.circular(60),
//                   )),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
//                 child: ListView(
//                   physics: BouncingScrollPhysics(),
//                   children: <Widget>[
//                     Column(
//                         children: beneficiaries.map((p) {
//                       return personDetailCard(p);
//                     }).toList())
//                   ],
//                 ),
//               ),
//             ))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget personDetailCard(person) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                     width: 50.0,
//                     height: 50.0,
//                     decoration: new BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.cyan,
//                         image: new DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                                 'https://hamzatahri.github.io/assets/img/profile-img.jpg')))),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Text(
//                     "Name: " + person.name,
//                     style: TextStyle(fontSize: 15),
//                   ),
//                   Text(
//                     "Account Number: ",
//                     style: TextStyle(fontSize: 10),
//                   ),
//                   Text(
//                     person.bio,
//                     style: TextStyle(color: Colors.cyan, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
