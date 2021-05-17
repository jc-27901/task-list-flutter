// import 'package:flutter/material.dart';
// import 'package:task_list/functions/services1.dart';
// import 'package:task_list/functions/users1.dart';

// class LoadlistJson extends StatefulWidget {
//   static const routename = 'load-list-from-api';
//   //
//   LoadlistJson() : super();
//   @override
//   _LoadlistJsonState createState() => _LoadlistJsonState();
// }

// class _LoadlistJsonState extends State<LoadlistJson> {
//   //
//   List<Users> _users;
//   bool _loading;
//   @override
//   void initState() {
//     super.initState();
//     _loading = true;
//     Services.getUsers().then((users) {
//       setState(() {
//         _users = users;
//         _loading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_loading ? 'Loading...' : 'Users'),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Container(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: null == _users ? 0 : _users.length,
//                 itemBuilder: (context, index) {
//                   Users user = _users[index];
//                   return Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.grey,
//                     ),
//                     height: 80,
//                     width: double.infinity,
//                     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             user.name,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                         Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 15.0),
//                           child: CircleAvatar(
//                             radius: 30,
//                             //  backgroundColor: Colors.blue,
//                             backgroundImage: NetworkImage(user.imageUrl),
//                           ),
//                         )
//                       ],
//                     ),
//                   );

//                   //  ListTile(
//                   //   title: Text(user.name),
//                   //   subtitle: Text(user.imageUrl),
//                   // );
//                 },
//               ),
//             ),
//             Spacer(),
//             Center(
//               child: Container(
//                 height: 60.0,
//                 width: 210.0,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50)),
//                       elevation: 8.0,
//                       primary: Colors.black,
//                       shadowColor: Colors.black),
//                   onPressed: (() {}),
//                   child: Text(
//                     'Load list from api',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 30.0,
//             ),
//             Padding(
//               padding: EdgeInsets.only(bottom: 28.0),
//               child: Center(
//                 child: Text(
//                   'List successfully fetched from API.',
//                   style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green[800]),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
