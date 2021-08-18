import 'package:chat_app/api/database.dart';
import 'package:chat_app/models/cart_item.dart';
import 'package:chat_app/models/order.dart';
import 'package:chat_app/needy/needyDrawer/needyNavigationHome.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/services/order.dart';
import 'package:chat_app/widgets/globalData.dart';
import 'package:chat_app/widgets/spaces.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String userId = '';
  bool edite_user = false;
  bool edite_phone = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullName = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController cityName = new TextEditingController();
  TextEditingController street = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController districtName = new TextEditingController();

  OrderServices _orderServices = OrderServices();

  void goBack(BuildContext context) {
    Navigator.pop(context, true);
  }

  void submit(UserProvider userProvider) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    try {
      _formKey.currentState.save();
    var uuid = Uuid();
    String id = uuid.v4();
    _orderServices.createOrder(
      needyId: userProvider.user.uid,
      donorId: userProvider.userModel.id,
      id: id,
      status: "complete",
      cart: userProvider.userModel.cart,
      customName:userProvider.userModel.name,
      phoneNumber: phoneNumber.text,
      city: cityName.text,
      street: street.text,
      buildingNo: address.text,
      district: districtName.text,
    );
    for (CartItemModel cartItem in userProvider.userModel.cart) {
      bool value = await userProvider.removeFromCart(cartItem: cartItem);
      if (value) {
        userProvider.reloadUserModel();
        print("Item added to cart");
      } else {
        print("ITEM WAS NOT REMOVED");
      }
      DatabaseService(uid: "").updatePost(CartItemModel.POST_ID);
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => needy_navigation_home()));
    }
    catch (error) {
      getToast(error.toString());
      print(error);
    }
  }
  void dispose() {
    super.dispose();
  }
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    fullName.text = userProvider.userModel?.name ?? "username lading...";
    //phoneNumber.text = userProvider.userModel?.phoneNumber ?? "";
    return Scaffold(
        backgroundColor: AppColors.whiteShade2,
        body: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                child: Container(
                  color: AppColors.whiteShade2,
                  child: Form(
                      autovalidate: true,
                      key: _formKey,
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 12),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    offset: const Offset(0, 4),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: new Text(StringConst.Personal_Information,
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 0, top: 5, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 16, right: 16, bottom: 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              maxLines: null,
                                              maxLengthEnforced: false,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              controller: fullName,
                                              enabled: edite_user,
                                              decoration: InputDecoration(
                                                hintText:
                                                    StringConst.CUSTOM_NAME,
                                                border: UnderlineInputBorder(),
                                              ),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return ' Name is required';
                                                }
                                                return null;
                                              },

                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          edite_user = !edite_user;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 0, top: 5, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 16, right: 16, bottom: 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              // maxLines: 4,
                                              maxLengthEnforced: false,
                                              keyboardType: TextInputType.phone,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              controller: phoneNumber,
                                              enabled: userProvider.userModel
                                                      .phoneNumber.isNotEmpty
                                                  ? false
                                                  : true,
                                              decoration: InputDecoration(
                                                hintText:
                                                    StringConst.PHONE_NUMBER,
                                                border: UnderlineInputBorder(),
                                              ),
//
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return '  phone number  is required';
                                                }
                                                return null;
                                              },

                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          edite_phone = !edite_phone;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15, bottom: 12),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    offset: const Offset(0, 4),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: new Text(StringConst.location_Information,
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold)),
//                                      child: new Icon(Icons.remove, color: AppColors.primary),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 0, top: 5, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 16, right: 16, bottom: 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              maxLines: null,
                                              maxLengthEnforced: false,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              controller: cityName,
                                              decoration: InputDecoration(
                                                hintText: StringConst.CITY,
                                                border: UnderlineInputBorder(),
                                              ),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return 'City Name is required';
                                                }
                                                return null;
                                              },

                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 0, top: 5, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 16, right: 16, bottom: 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              maxLines: null,
                                              maxLengthEnforced: false,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              controller: districtName,
                                              decoration: InputDecoration(
                                                hintText:
                                                    StringConst.DISTRICT_NAME,
                                                border: UnderlineInputBorder(),
                                              ),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return 'District Name is required';
                                                }
                                                return null;
                                              },

                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 0, top: 5, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 16, right: 16, bottom: 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextFormField(
                                              // maxLines: 4,
                                              maxLengthEnforced: false,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              controller: street,
                                              decoration: InputDecoration(
                                                hintText: StringConst.STREET,
                                                border: UnderlineInputBorder(),
                                              ),

                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return '  The name of street is required';
                                                }
                                                return null;
                                              },

                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 0, top: 5, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 16, right: 16, bottom: 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
//
                                            TextFormField(
                                              // maxLines: 4,
                                              maxLengthEnforced: false,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              controller: address,
                                              decoration: InputDecoration(
                                                hintText:
                                                    StringConst.BUILDING_NO,
                                                border: UnderlineInputBorder(),
                                              ),

                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return ' Building NO is required';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SpaceH20(),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.08,
                              right: MediaQuery.of(context).size.height * 0.08,
                              bottom: MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: Container(
                              width: 220,
                              height: 50,
                              child: FlatButton(
                                  color: AppColors.primary,
                                  shape: StadiumBorder(),
                                  child: Center(
                                    child: Text(
                                      StringConst.ok,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    submit(userProvider);
                                  }),
                            ),
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }

  Widget getAppBarUI() {
    return Container(
        child: AppBar(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.primary,
      ),
      centerTitle: true,
      title: Text(
        "Address",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
        ),
      ),
      elevation: 0.0,
    ));
  }
}
