import 'package:chat_app/models/postModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostServices {
  String collection = "posts";
  Firestore _firestore = Firestore.instance;

  Future<List<postModel>> getPosts() async =>
      _firestore.collection(collection)

          .getDocuments().then((result) {
        List<postModel> posts = [];
        for (DocumentSnapshot post in result.documents) {
          posts.add(postModel.fromSnapshot(post));
        }
        return posts;
      });


  Future<List<postModel>> searchPosts({String postTitle}) {
    // code to convert the first character to uppercase
    String searchKey = postTitle[0].toUpperCase() + postTitle.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("postTitle")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<postModel> posts = [];
      for (DocumentSnapshot post in result.documents) {
        posts.add(postModel.fromSnapshot(post));
      }
      return posts;
    });
  }
}
