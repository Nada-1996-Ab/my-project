import 'package:chat_app/helpers/common.dart';
import 'package:chat_app/helpers/style.dart';
import 'package:chat_app/models/postModel.dart';
import 'package:chat_app/provider/app.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/screens/cart.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends StatefulWidget {
  final postModel product;
//  final CartItemModel acountitem;
  const ProductDetails({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _key = GlobalKey<ScaffoldState>();
  int _n = 1;
  void add() {
    setState(() {
      _n++;
    });
//    widget.acountitem.acount==_n;
  }

  void minus() {
    setState(() {
      if (_n > 1) {
        _n--;
      } else
        _n = 1;
    });
//    widget.acountitem.acount==_n;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      body: SafeArea(
          child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Loading(),
                )),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
//                    image: widget.product.picture,
                    fit: BoxFit.fill,
                    height: 400,
                    width: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Positioned(
                    bottom: 50,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                      minus();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(38.0),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              offset: const Offset(0, 2),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: new Icon(Icons.remove,
                                          color: AppColors.primary),
                                    )),
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
//                                        color: AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(38.0),
                                    ),
                                    border: Border.all(
                                        color: AppColors.primary, width: 1),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          offset: const Offset(0, 4),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                  child: new Text('$_n',
                                      style: new TextStyle(
                                          fontSize: 20.0, color: Colors.white)),
                                ),
                                InkWell(
                                  onTap: () {
                                    add();
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(38.0),
                                      ),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            offset: const Offset(0, 2),
                                            blurRadius: 8.0),
                                      ],
                                    ),
                                    child: new Icon(Icons.add,
                                        color: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  right: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        changeScreen(context, CartScreen());
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.shopping_cart),
                            ),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        print("CLICKED");
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: red,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(35))),
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(2, 5),
                          blurRadius: 10)
                    ]),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async {
                              //  widget.product.acount=_n;
                              appProvider.changeIsLoading();
                              bool success = await userProvider.addToCart(
                                post: widget.product,
                              );
                              if (success) {
                                _key.currentState.showSnackBar(
                                    SnackBar(content: Text("Added to Cart!")));
                                userProvider.reloadUserModel();
                                appProvider.changeIsLoading();
                                return;
                              } else {
                                _key.currentState.showSnackBar(SnackBar(
                                    content: Text("Not added to Cart!")));
                                appProvider.changeIsLoading();
                                return;
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: appProvider.isLoading
                                ? Loading()
                                : Text(
                                    "Add to cart",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
