import 'dart:ui';
import 'package:chat_app/models/cart_item.dart';
import 'package:chat_app/models/order.dart';
import 'package:chat_app/provider/app.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/spaces.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class orderScreen extends StatefulWidget {
  @override
  _orderScreenState createState() => _orderScreenState();
}

class _orderScreenState extends State<orderScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  void _submitForm() async {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void initState() {
    _submitForm();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // _submitForm(userProvider);
    return Scaffold(
        backgroundColor: AppColors.whiteShade2,
        body: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                child: Container(
                    color: AppColors.whiteShade2,
                    child: Column(children: <Widget>[
                      getSearchBarUI(),
                      getCategoryUI(),
                      Expanded(
                          child: Container(
                        color: AppColors.white,
                        child: new ListView.builder(
                          itemCount: userProvider.orders.length,
                          padding: const EdgeInsets.only(top: 8),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final int count = userProvider.orders.length > 10
                                ? 10
                                : userProvider.orders.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animationController,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            animationController.forward();
                            return CompaniesList(
                              orderData: userProvider.orders[index],
                              animation: animation,
                              index: index,
                              animationController: animationController,
                            );
                          },
                        ),
                      ))
                    ])),
              )
            ],
          ),
        ));
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(.1),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  "Orders",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Orders",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: AppColors.black.withOpacity(0.5),
                ),
              ),
            )),
        const SizedBox(
          height: 16,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 13, bottom: 13),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20, color: AppColors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 1, bottom: 1),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteShade2,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: new ListTile(
                  title: new TextField(
                    decoration: new InputDecoration(
                        hintText: StringConst.search, border: InputBorder.none),
//                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new InkWell(
                    onTap: () {
//                      controller.clear();
//                      onSearchTextChanged('');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
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
                      child: new Icon(Icons.clear, color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompaniesList extends StatelessWidget {
  const CompaniesList({
    Key key,
    this.orderData,
    this.animationController,
    this.animation,
    this.index,
  }) : super(key: key);

  final OrderModel orderData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final int index;

  void goBack(BuildContext context) {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 18.0),
                          color: AppColors.whiteShade2,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    height: 90,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12.0)),
                                      color: AppColors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color:AppColors.grey
                                              .withOpacity(0.7),
                                          offset: const Offset(2, 4),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12.0)),
                                      child:
                                          Image.asset('assets/icons/orders.png',
                                           // color: AppColors.grey,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Column(children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Oreder " + index.toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.black
                                                  .withOpacity(.7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              height: 1.5,
                                            ),
                                            //maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        SpaceH8(),
                                        Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.black
                                                    .withOpacity(.3),
                                                width: 1),
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(8.0)),
                                            color: AppColors.white,
                                          ),
                                          child:  Column(
                                            children: <Widget>[

                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  StringConst.Name + ": ",
                                                  style: TextStyle(
                                                    color: AppColors.black.withOpacity(.7),
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    letterSpacing: .5,
                                                    height: 1.3,
                                                  ),
                                                  softWrap: false,
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 1,
                                                ),

                                                Text(orderData.customName,
                                                  style: TextStyle(
                                                    color: AppColors.black.withOpacity(.5),
                                                    fontSize: 11,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    letterSpacing: .5,
                                                    height: 1.3,
                                                  ),
                                                  softWrap: false,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),

                                              ]),
                                              Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      StringConst.DATE + ": ",
                                                      style: TextStyle(
                                                        color: AppColors.black.withOpacity(.7),
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        letterSpacing: .5,
                                                        height: 1.3,
                                                      ),
                                                      softWrap: false,
                                                      overflow: TextOverflow.clip,
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      DateTime.fromMillisecondsSinceEpoch(
                                                          orderData.createdAt)
                                                          .toString().substring(0,14),
                                                      style: TextStyle(
                                                        color: AppColors.black.withOpacity(.5),
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        letterSpacing: .5,
                                                        height: 1.3,

                                                      ),
                                                      softWrap: false,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),

                                                  ]),])
                                        ),
                                        SpaceH8(),
                                        
                                        SpaceH8(),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              SpaceH12(),
                              SpaceH8(),
                              Divider(
                                color: AppColors.grey.withOpacity(.2),
                                height: 3,
                                thickness: 1,
                              ),
                              ExpansionTile(
                                  childrenPadding: EdgeInsets.all(4),
                                  title: Text(
                                    StringConst.viewMore,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.black.withOpacity(.7),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  children: <Widget>[
                                    for (var post in orderData.cart)
                                    appProvider.isLoading
                                        ? Loading()
                                        :
                                    Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColors.primary.withOpacity(0.2),
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
                                                post.image,
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.all(3),
                                                    padding: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors.black
                                                              .withOpacity(.3),
                                                          width: 1),
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                      color: AppColors.white,
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            "Name: ",
                                                            style: TextStyle(
                                                              color: AppColors.black.withOpacity(.7),
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight.normal,
                                                              letterSpacing: .5,
                                                              height: 1.3,
                                                            ),
                                                            softWrap: false,
                                                            overflow: TextOverflow.clip,
                                                            maxLines: 1,
                                                          ),
                                                          Text(
                                                            post.name,
                                                            style: TextStyle(
                                                              color: AppColors.black.withOpacity(.5),
                                                              fontSize: 11,
                                                              fontWeight:
                                                              FontWeight.normal,
                                                              letterSpacing: .5,
                                                              height: 1.3,

                                                            ),
                                                            softWrap: false,
                                                            overflow:
                                                            TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                          ),

                                                        ]),
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.all(3),
                                                    padding: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors.black
                                                              .withOpacity(.3),
                                                          width: 1),
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                      color: AppColors.white,
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                              "Type: ",
                                                            style: TextStyle(
                                                              color: AppColors.black.withOpacity(.7),
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight.normal,
                                                              letterSpacing: .5,
                                                              height: 1.3,
                                                            ),
                                                            softWrap: false,
                                                            overflow: TextOverflow.clip,
                                                            maxLines: 1,
                                                          ),
                                                          Text(
                                                              post.postType,
                                                            style: TextStyle(
                                                              color: AppColors.black.withOpacity(.5),
                                                              fontSize: 11,
                                                              fontWeight:
                                                              FontWeight.normal,
                                                              letterSpacing: .5,
                                                              height: 1.3,

                                                            ),
                                                            softWrap: false,
                                                            overflow:
                                                            TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                          ),

                                                        ]),
                                                  ),

                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
