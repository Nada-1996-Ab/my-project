import 'package:chat_app/models/cart_item.dart';
import 'package:chat_app/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderServices{
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  void createOrder({
    String needyId ,
    String id,
    String donorId,
    String status ,
    List<CartItemModel> cart,
    String customName,
    String phoneNumber,
    String city,
    String buildingNo,
    String street,
    String district}) {
    List<Map> convertedCart = [];
    for(CartItemModel item in cart){
      convertedCart.add(item.toMap());
    }

    _firestore.collection(collection).document(id).setData({
      "needyId": needyId,
      "id": id,
      "cart": convertedCart,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "donorId": donorId,
      "status": status,
      "customName": customName,
      "phoneNumber": phoneNumber,
      "city": city,
      "street": street,
      "buildingNo": buildingNo,
      "district": district
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async =>
      _firestore
          .collection(collection)
          .where("needyId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });

  Future<List<OrderModel>> getAllOrders() async =>
      _firestore
          .collection(collection)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}