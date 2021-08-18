import 'package:cloud_firestore/cloud_firestore.dart';
class postModel {
  String _postId;
  int _cateId;
  String _donorId;
  String _postTitle;
  String _postDesc;
  String _postImage;
  String _postType;
  bool _postState;
  String _postDate;

  postModel();
  String get postId => _postId;
  int get cateId => _cateId;

  String get donorId => _donorId;
  String get postTitle => _postTitle;

  String get postDesc => _postDesc;

  String get postImage => _postImage;

  String get postType => _postType;

  bool get postState => _postState;
  String get postDate => _postDate;

  postModel.fromSnapshot(DocumentSnapshot snapshot) {
    _postId = snapshot.data["postId"];
    _cateId = snapshot.data["cateId"];
    _donorId = snapshot.data["donorId"];
    _postDesc = snapshot.data["postDesc"] ?? " ";
    _postTitle = snapshot.data["postTitle"];
    _postImage = snapshot.data["postImage"];
    _postType = snapshot.data["postType"];
    _postState = snapshot.data["postState"];
    _postDate = snapshot.data["postDate"];
  }
  set postDate(String value) {
    _postDate = value;
  }

  set postState(bool value) {
    _postState = value;
  }

  set postType(String value) {
    _postType = value;
  }

  set postImage(String value) {
    _postImage = value;
  }

  set postDesc(String value) {
    _postDesc = value;
  }

  set postTitle(String value) {
    _postTitle = value;
  }



  set donorId(String value) {
    _donorId = value;
  }

  set cateId(int value) {
    _cateId = value;
  }

  set postId(String value) {
    _postId = value;
  }


}
