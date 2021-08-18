import 'package:chat_app/models/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const CART = "cart";
  static const NEEDY_ID = "needyId";
  static const DONOR_ID = "donorId";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";
  static const CUSTOM_NAME = "customName";
  static const PHONE_NUMBER = "phoneNumber";
  static const CITY = "city";
  static const STREET = "street";
  static const BUILDING_NO = "buildingNo";
  static const DISTRICT_NAME = "districtName";

  String _id;
  String _needyId;
  String _donorId;
  String _status;
  int _createdAt;
  String _customName;
  String _phoneNumber;
  String _city;
  String _street;
  String _buildingNo;
  String _districtName;

  String get id => _id;
  String get needyId => _needyId;
  String get donorId => _donorId;
  String get status => _status;
  int get createdAt => _createdAt;
  String get customName => _customName;

  String get phoneNumber => _phoneNumber;
  String get city => _city;
  String get street => _street;
  String get buildingNo => _buildingNo;
  String get districtName => _districtName;
  List<CartItemModel> cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _status = snapshot.data[STATUS];
    _needyId = snapshot.data[NEEDY_ID];
    _donorId = snapshot.data[DONOR_ID];
    _createdAt = snapshot.data[CREATED_AT];
    _customName = snapshot.data[CUSTOM_NAME];
    _phoneNumber = snapshot.data[PHONE_NUMBER];
    _city = snapshot.data[CITY];
    _street = snapshot.data[STREET];
    _buildingNo = snapshot.data[BUILDING_NO];
    _districtName = snapshot.data[DISTRICT_NAME];

    cart = _convertCartItems(snapshot.data[CART]?? []);
  }

  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
  set customName(String value) {
    _customName = value;
  }
  set phoneNumber(String value) {
    _phoneNumber = value;
  }
  set city(String value) {
    _city = value;
  }
  set street(String value) {
    _street = value;
  }

  set buildingNo(String value) {
    _buildingNo = value;
  }

  set districtName(String value) {
    _districtName = value;
  }
}
