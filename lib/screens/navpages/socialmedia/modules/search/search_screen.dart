// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
// import 'package:flutter_application_2023/screens/navpages/chat/chats_screen.dart';
// import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
// import 'package:flutter_application_2023/screens/navpages/socialmedia/model/user_model.dart';
// import 'package:flutter_application_2023/widgets/constant.dart';

// class SocialSearchScreen extends StatefulWidget {
//   const SocialSearchScreen({super.key});

//   @override
//   State<SocialSearchScreen> createState() => _SocialSearchScreenState();
// }

// class _SocialSearchScreenState extends State<SocialSearchScreen> {
//   List<UserModel> _list = [];

//   // for storing searched items
//   final List<UserModel> _searchList = [];
//   bool _isSearching = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(CupertinoIcons.home),
//         title: _isSearching
//             ? TextField(
//                 decoration: const InputDecoration(
//                     border: InputBorder.none, hintText: 'Search Friend...'),
//                 autofocus: true,
//                 style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
//                 //when search text changes then updated search list
//                 onChanged: (val) {
//                   //search logic
//                   _searchList.clear();

//                   for (var i in _list) {
//                     if (i.name!.toLowerCase().contains(val.toLowerCase()) ||
//                         i.email!.toLowerCase().contains(val.toLowerCase())) {
//                       _searchList.add(i);
//                       setState(() {
//                         _searchList;
//                       });
//                     }
//                   }
//                 },
//               )
//             : const Text('Search Friend'),
//         actions: [
//           //search user button
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   _isSearching = !_isSearching;
//                 });
//               },
//               icon: Icon(_isSearching
//                   ? CupertinoIcons.clear_circled_solid
//                   : Icons.search)),

//           //more features button
//         ],
//       ),
//       body: StreamBuilder(
//         stream: SocialLayoutController.getMyUsersId(),

//         //get id of only known users
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             //if data is loading
//             case ConnectionState.waiting:
//             case ConnectionState.none:
//               return const Center(child: CircularProgressIndicator());

//             //if some or all data is loaded then show it
//             case ConnectionState.active:
//             case ConnectionState.done:
//               return StreamBuilder(
//                 stream: SocialLayoutController.getAllUser(
//                     snapshot.data?.docs.map((e) => e.id).toList() ?? []),

//                 //get only those user, who's ids are provided
//                 builder: (context, snapshot) {
//                   switch (snapshot.connectionState) {
//                     //if data is loading
//                     case ConnectionState.waiting:
//                     case ConnectionState.none:
//                     // return const Center(
//                     //     child: CircularProgressIndicator());

//                     //if some or all data is loaded then show it
//                     case ConnectionState.active:
//                     case ConnectionState.done:
//                       final data = snapshot.data?.docs;
//                       _list = data
//                               ?.map((e) => UserModel.fromJson(e.data()))
//                               .toList() ??
//                           [];

//                       if (_list.isNotEmpty) {
//                         return ListView.builder(
//                             itemCount: _isSearching
//                                 ? _searchList.length
//                                 : _list.length,
//                             padding: EdgeInsets.only(top: mq.height * .01),
//                             physics: const BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return Text('Hello');
//                             });
//                       } else {
//                         return const Center(
//                           child: Text('No Connections Found!',
//                               style: TextStyle(fontSize: 20)),
//                         );
//                       }
//                   }
//                 },
//               );
//           }
//         },
//       ),
//     );
//   }
// }
