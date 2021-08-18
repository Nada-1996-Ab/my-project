import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";
  static const SIGNUP_TYPE = "signup_type";
  static const PHONENUMBER = "phoneNumber";
  static const BIRTHDAY = "cardNumber";

  String _name;
  String _email;
  String _id;
  String _stripeId;
  String _signup_type;
  String _phoneNumber;
  String _birthDay;
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;
  String get signup_type => _signup_type;
  String get phoneNumber => _phoneNumber;
  String get birthDay => _birthDay;
  List<CartItemModel> cart;
  int totalCartPrice;
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _signup_type = snapshot.data[SIGNUP_TYPE];
    _phoneNumber = snapshot.data[PHONENUMBER];
    _birthDay = snapshot.data[BIRTHDAY];
    _stripeId = snapshot.data[STRIPE_ID] ?? "";
    cart = _convertCartItems(snapshot.data[CART]?? []);

  }
  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
