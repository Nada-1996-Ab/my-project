
class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const DESCRPTION = "postDesc";
  static const POST_ID = "postId";
  static const POST_TYPE = "postTyp";
  static const DONOR_ID = "donorId";
  String _id;
  String _name;
  String _image;
  String _postId;
  String _postDescrption;
  String _postType;
  String _donorId;
  String get id => _id;

  String get name => _name;

  String get image => _image;
  String get postId => _postId;
  String get postType => _postType;
  String get postDescrption => _postDescrption;
  String get donorId => _donorId;

  CartItemModel.fromMap(Map data){
    _id = data[ID];
    _name =  data[NAME];
    _image =  data[IMAGE];
    _postId = data[POST_ID];
    _postDescrption = data[DESCRPTION];
    _donorId = data[DONOR_ID];
    _postType = data[POST_TYPE];
  }
  Map toMap() => {
    ID: _id,
    IMAGE: _image,
    NAME: _name,
    POST_ID: _postId,
    DESCRPTION:_postDescrption,
    DONOR_ID:_donorId,
    POST_TYPE:_postType,
  };
}
