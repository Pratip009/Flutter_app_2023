import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/utils/global_veriable.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:flutter_application_2023/widgets/post_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : kblacklight2,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: kblacklight2,
              centerTitle: false,
              title: Text(
                'Social Media',
                style: GoogleFonts.lobster(
                  color: kblacklight,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.messenger_outline,
                    color: kblacklight,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
