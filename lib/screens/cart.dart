import 'package:chat_app/address/custum_address.dart';
import 'package:chat_app/helpers/style.dart';
import 'package:chat_app/provider/app.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/services/order.dart';
import 'package:chat_app/widgets/custom_text.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.primaryTwo),
        backgroundColor: AppColors.whiteShade2,
        elevation: 0.0,
        title: CustomText(text: "Shopping Cart"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: appProvider.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: userProvider.userModel.cart.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primary.withOpacity(.3),
                              offset: Offset(3, 2),
                              blurRadius: 30)
                        ]),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          child: Image.network(
                            userProvider.userModel.cart[index].image,
                            height: 120,
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: userProvider
                                              .userModel.cart[index].name +
                                          "\n\n",
                                      style: TextStyle(
                                          color: AppColors.primaryTwo,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),

                                  TextSpan(
                                      text:
                                          "Status: ${userProvider.userModel.cart[index].postType} \n",
                                      style: TextStyle(
                                          color: AppColors.primaryTwo,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                ]),
                              ),

                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                  ),
                                  onPressed: () async {
                                    appProvider.changeIsLoading();
                                    bool success =
                                        await userProvider.removeFromCart(
                                            cartItem: userProvider
                                                .userModel.cart[index]);
                                    if (success) {
                                      userProvider.reloadUserModel();
                                      print("Item added to cart");
                                      _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Removed from Cart!")));
                                      appProvider.changeIsLoading();
                                      return;
                                    } else {
                                      appProvider.changeIsLoading();
                                    }
                                  })
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryTwo),
                child: FlatButton(
                    onPressed: () {
                      if (userProvider.userModel.totalCartPrice == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.shopping_cart,
                                              size: 100,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Your cart is empty',
                                              textAlign: TextAlign.center,
//                                                style: TextStyle(
//                                                    color: black,
//                                                    fontSize: 22,
//                                                    fontWeight: FontWeight.normal)
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Address()));
                                          },
                                          child: Text(
                                            "Accept",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: AppColors.grey),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: CustomText(
                      text: "Check out",
                      size: 20,
                      color: white,
                      weight: FontWeight.normal,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
