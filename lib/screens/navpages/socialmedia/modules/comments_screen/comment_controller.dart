import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/comment_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CommentsController extends GetxController {
  //NOTE Add Comment On Post
  Future<void> AddCommentToPost(String postId, CommentModel model) async {
    print("befor insert");
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toJson())
        .then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .where('postId', isEqualTo: postId)
          .get()
          .then((doc_of_post) {
        FirebaseFirestore.instance.collection('posts').doc(postId).update({
          'nbOfComments': doc_of_post.docs.first.data()['nbOfComments'] + 1,
        }).then((value) {});
      });
      print('inserted');
      print(value.id);
    });
  }
}
