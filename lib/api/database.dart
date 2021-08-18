import 'package:chat_app/models/postImage.dart';
import 'package:chat_app/models/postModel.dart';
import 'package:chat_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference postCollection =
      Firestore.instance.collection('posts');
  final CollectionReference imgCollection =
      Firestore.instance.collection('postImage');
  final CollectionReference getUsersCollection =
      Firestore.instance.collection('users');

  Stream<List<postModel>> getDonorPosts(cateId, donorId) {
    return postCollection
        .where('cateId', isEqualTo: cateId)
        .where('donorId', isEqualTo: donorId)
        .snapshots()
        .map((snapShot) => snapShot.documents
            .map((document) => postModel.fromSnapshot(document))
            .toList());
  }
  Stream<List<postModel>> getAllPosts(cateId) {
    return postCollection
        .where('cateId', isEqualTo: cateId)
        .snapshots()
        .map((snapShot) => snapShot.documents
        .map((document) => postModel.fromSnapshot(document))
        .toList());
  }

  Stream<List<postImage>> getPostImage(postId) {
    return imgCollection.where('postId', isEqualTo: postId).snapshots().map(
        (event) => event.documents
            .map((result) => postImage.fromJson(result.data))
            .toList());
  }

  Future<List<postImage>> getProdImage1(postId) {
    return imgCollection.where('postId', isEqualTo: postId).getDocuments().then(
        (snapShot) => snapShot.documents
            .map((result) => postImage.fromJson(result.data))
            .toList());
  }


  Future<void> Addpost(postModel PostModel) async {
    String postId = postCollection.document().documentID;
    await postCollection.document(postId).setData({
      'postId': postId,
      'cateId': PostModel.cateId,
      'donorId': PostModel.donorId,
      'postDesc': PostModel.postDesc,
      'postTitle': PostModel.postTitle,
      'postImage': PostModel.postImage,
      'postType': PostModel.postType,
      'postState': PostModel.postState,
      'postDate': PostModel.postDate,
    });

  }

  Future updatePost(postId) async {
    return await postCollection.document(postId).updateData({
      'postState': true,
    });
  }

  Future editUserData(
    String fullName,
    String phoneNumber,
    String emailAddress,
    String id,
  ) async {
    return await getUsersCollection.document(id).updateData({
      'uid': id,
      'name': fullName,
      'phoneNumber': phoneNumber,
      'email': emailAddress,

    });
  }

  Future deleteTask(postId) async {
    await postCollection.document(postId).delete();}
  Stream<List<UserModel>> getAllUserloyees() {
    return getUsersCollection.snapshots().map((snapShot) => snapShot.documents
        .map((document) => UserModel.fromSnapshot(document))
        .toList());
  }
}
