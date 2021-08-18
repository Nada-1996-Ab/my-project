//import 'dart:ui';
//import 'package:chat_app/models/order.dart';
//import 'package:chat_app/widgets/spaces.dart';
//import 'package:chat_app/widgets/values.dart';
//import 'package:flutter/material.dart';
//
//class detailsRequestScreen extends StatefulWidget {
//  OrderModel orderData1;
//  int index;
//  detailsRequestScreen({this.orderData1, this.index});
//  @override
//  _detailsRequestScreenState createState() => _detailsRequestScreenState();
//}
//
//class _detailsRequestScreenState extends State<detailsRequestScreen>
//    with TickerProviderStateMixin {
//  AnimationController animationController;
//
//  void _submitForm() async {
////    final userProvider = Provider.of<UserProvider>(context);
////    await userProvider.getOrders();
//    animationController = AnimationController(
//        duration: const Duration(milliseconds: 1000), vsync: this);
//  }
//
//  @override
//  void initState() {
//    _submitForm();
//    super.initState();
//  }
//
//  Future<bool> getData() async {
//    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//    return true;
//  }
//
//  @override
//  void dispose() {
//    animationController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: AppColors.whiteShade2,
//        body: Container(
//          child: Column(
//            children: <Widget>[
//              getAppBarUI(),
//              Expanded(
//                child: Container(
//                    color: AppColors.whiteShade2,
//                    child: Column(children: <Widget>[
//                      Expanded(
//                          child: Container(
//                            color: AppColors.white,
//                            child: Padding(
//                              padding: const EdgeInsets.only(
//                                  left: 24, right: 24, top: 8, bottom: 400),
//                              child: InkWell(
//                                splashColor: Colors.transparent,
//                                onTap: () {
//
//                                },
//                                child: Container(
//                                  decoration: BoxDecoration(
//                                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
//                                    boxShadow: <BoxShadow>[
//                                      BoxShadow(
//                                        color: Colors.grey.withOpacity(0.6),
//                                        offset: const Offset(4, 4),
//                                        blurRadius: 16,
//                                      ),
//                                    ],
//                                  ),
//                                  child: ClipRRect(
//                                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//                                    child: Stack(
//                                      children: <Widget>[
//                                        Container(
//                                          padding: EdgeInsets.symmetric(
//                                              vertical: 14.0, horizontal: 18.0),
//                                          color: AppColors.whiteShade2,
//                                          child: Column(
//                                            children: <Widget>[
//                                              Row(
//                                                mainAxisAlignment: MainAxisAlignment.end,
//                                                children: <Widget>[
//
//                                                  Expanded(
//                                                    flex: 8,
//                                                    child: Container(
//                                                      alignment: Alignment.centerLeft,
//                                                      margin: EdgeInsets.only(
//                                                          left: 10.0, right: 10.0),
//                                                      child: Column(children: <Widget>[
//                                                        Container(
//                                                          alignment: Alignment.center,
//                                                          child: Text(
//                                                            "Request " + widget. index.toString(),
//                                                            textAlign: TextAlign.left,
//                                                            style: TextStyle(
//                                                              color: AppColors.primaryTwo
//                                                                  .withOpacity(.7),
//                                                              fontSize: 16,
//                                                              fontWeight: FontWeight.w600,
//                                                              height: 1.5,
//                                                            ),
//                                                            //maxLines: 1,
//                                                            softWrap: false,
//                                                            overflow: TextOverflow.ellipsis,
//                                                            maxLines: 2,
//                                                          ),
//                                                        ),
//
//                                                        SpaceH8(),
//                                                        Container(
//                                                          padding: EdgeInsets.all(3),
//
//                                                          child: Row(
//                                                              mainAxisAlignment:
//                                                              MainAxisAlignment.start,
//                                                              children: <Widget>[
//                                                                Text(
//                                                                  StringConst.CITY_NAME +": ",
//                                                                  style: TextStyle(
//                                                                    color: AppColors.primaryTwo,
//                                                                    fontSize: 15,
//                                                                    fontWeight:
//                                                                    FontWeight.w500,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow: TextOverflow.clip,
//                                                                  maxLines: 2,
//                                                                ),
//                                                                Text( widget.orderData1.city
//                                                                  ,
//                                                                  style: TextStyle(
//                                                                    color: AppColors.blackShade2,
//                                                                    fontSize: 13,
//                                                                    fontWeight:
//                                                                    FontWeight.normal,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow:
//                                                                  TextOverflow.ellipsis,
//                                                                  maxLines: 2,
//                                                                ),
//
//                                                              ]),
//                                                        ),
//                                                        SpaceH8(),
//                                                        Container(
//                                                          padding: EdgeInsets.all(3),
//                                                          child: Row(
//                                                              mainAxisAlignment:
//                                                              MainAxisAlignment.start,
//                                                              children: <Widget>[
//                                                                Text(
//                                                                  StringConst.NEIGHBOR +": ",
//                                                                  style: TextStyle(
//                                                                    color: AppColors.primaryTwo,
//                                                                    fontSize: 15,
//                                                                    fontWeight:
//                                                                    FontWeight.w500,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow: TextOverflow.clip,
//                                                                  maxLines: 1,
//                                                                ),
//                                                                Text( widget.orderData1.neighbor
//                                                                  ,
//                                                                  style: TextStyle(
//                                                                    color: AppColors.blackShade2,
//                                                                    fontSize: 13,
//                                                                    fontWeight:
//                                                                    FontWeight.normal,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow:
//                                                                  TextOverflow.ellipsis,
//                                                                  maxLines: 2,
//                                                                ),
//
//                                                              ]),
//                                                        ),
//                                                        SpaceH8(),
//                                                        Container(
//                                                          padding: EdgeInsets.all(3),
//                                                          child: Row(
//                                                              mainAxisAlignment:
//                                                              MainAxisAlignment.start,
//                                                              children: <Widget>[
//                                                                Text(
//                                                                  StringConst.BUILDING +": ",
//                                                                  style: TextStyle(
//                                                                    color: AppColors.primaryTwo,
//                                                                    fontSize: 15,
//                                                                    fontWeight:
//                                                                    FontWeight.w500,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow: TextOverflow.clip,
//                                                                  maxLines: 1,
//                                                                ),
//                                                                Text( widget.orderData1.buildingNo
//                                                                  ,
//                                                                  style: TextStyle(
//                                                                    color: AppColors.blackShade2,
//                                                                    fontSize: 13,
//                                                                    fontWeight:
//                                                                    FontWeight.normal,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow:
//                                                                  TextOverflow.ellipsis,
//                                                                  maxLines: 2,
//                                                                ),
//
//                                                              ]),
//                                                        ),
//                                                        SpaceH8(),
//                                                        Container(
//                                                          padding: EdgeInsets.all(3),
//                                                          child: Row(
//                                                              mainAxisAlignment:
//                                                              MainAxisAlignment.start,
//                                                              children: <Widget>[
//                                                                Text(
//                                                                  StringConst.PAY +": ",
//                                                                  style: TextStyle(
//                                                                    color: AppColors.primaryTwo,
//                                                                    fontSize: 15,
//                                                                    fontWeight:
//                                                                    FontWeight.w500,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow: TextOverflow.clip,
//                                                                  maxLines: 1,
//                                                                ),
//                                                                Text( widget.orderData1.paymentMethod
//                                                                  ,
//                                                                  style: TextStyle(
//                                                                    color: AppColors.blackShade2,
//                                                                    fontSize: 13,
//                                                                    fontWeight:
//                                                                    FontWeight.normal,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow:
//                                                                  TextOverflow.ellipsis,
//                                                                  maxLines: 2,
//                                                                ),
//
//                                                              ]),
//                                                        ),
//                                                        SpaceH8(),
//                                                        Container(
//                                                          padding: EdgeInsets.all(3),
//                                                          child: Row(
//                                                              mainAxisAlignment:
//                                                              MainAxisAlignment.start,
//                                                              children: <Widget>[
//                                                                Text(
//                                                                  StringConst.TOTAL +": ",
//                                                                  style: TextStyle(
//                                                                    color: AppColors.primaryTwo,
//                                                                    fontSize: 15,
//                                                                    fontWeight:
//                                                                    FontWeight.w500,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow: TextOverflow.clip,
//                                                                  maxLines: 1,
//                                                                ),
//                                                                Text( widget.orderData1.total
//                                                                    .toString()+" SAR",
//                                                                  style: TextStyle(
//                                                                    color: AppColors.blackShade2,
//                                                                    fontSize: 13,
//                                                                    fontWeight:
//                                                                    FontWeight.normal,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow:
//                                                                  TextOverflow.ellipsis,
//                                                                  maxLines: 2,
//                                                                ),
//
//                                                              ]),
//                                                        ),
//                                                        SpaceH8(),
//                                                        Container(
//                                                          padding: EdgeInsets.all(3),
//
//                                                          child: Row(
//                                                              mainAxisAlignment:
//                                                              MainAxisAlignment.start,
//                                                              children: <Widget>[
//                                                                Text(
//                                                                  StringConst.DATE + ": ",
//                                                                  style: TextStyle(
//                                                                    color: AppColors.primaryTwo,
//                                                                    fontSize: 15,
//                                                                    fontWeight:
//                                                                    FontWeight.w500,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow: TextOverflow.clip,
//                                                                  maxLines: 1,
//                                                                ),
//                                                                Text(
//                                                                  DateTime.fromMillisecondsSinceEpoch(
//                                                                      widget.orderData1.createdAt)
//                                                                      .toString(),
//                                                                  style: TextStyle(
//                                                                    color: AppColors.blackShade2,
//                                                                    fontSize: 13,
//                                                                    fontWeight:
//                                                                    FontWeight.normal,
//                                                                    letterSpacing: .5,
//                                                                    height: 1.3,
//                                                                  ),
//                                                                  softWrap: false,
//                                                                  overflow:
//                                                                  TextOverflow.ellipsis,
//                                                                  maxLines: 2,
//                                                                ),
//
//                                                              ]),
//                                                        ),
//                                                        SpaceH8(),
//                                                      ]),
//                                                    ),
//                                                  ),
//                                                ],
//                                              ),
//
//
//                                            ],
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            )
//                          ))
//                    ])),
//              )
//            ],
//          ),
//        ));
//  }
//
//  Widget getAppBarUI() {
//    return Container(
//      decoration: BoxDecoration(
//        color: AppColors.whiteShade2,
//        boxShadow: <BoxShadow>[
//          BoxShadow(
//              color: Colors.grey.withOpacity(0.2),
//              offset: const Offset(0, 2),
//              blurRadius: 8.0),
//        ],
//      ),
//      child: Padding(
//        padding: EdgeInsets.only(
//            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
//        child: Row(
//          children: <Widget>[
//            Container(
//              margin: EdgeInsets.all(5),
//              alignment: Alignment.centerLeft,
//              width: AppBar().preferredSize.height,
//              height: AppBar().preferredSize.height,
//              decoration: BoxDecoration(
//                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
//                color: AppColors.white,
//                boxShadow: <BoxShadow>[
//                  BoxShadow(
//                    color: AppColors.primary.withOpacity(0.7),
//                    offset: const Offset(2, 3),
//                    blurRadius: 5,
//                  ),
//                ],
//              ),
//              child: ClipRRect(
//                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
//                child: Image.asset('assets/images/logo.png'),
//              ),
//            ),
//            Expanded(
//              child: Center(
//                child: Text(
//                  "Details Requests",
//                  style: TextStyle(
//                    fontWeight: FontWeight.w600,
//                    fontSize: 18,
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              width: AppBar().preferredSize.height + 40,
//              height: AppBar().preferredSize.height,
//              child: Material(
//                color: Colors.transparent,
//                child: InkWell(
//                  borderRadius: const BorderRadius.all(
//                    Radius.circular(32.0),
//                  ),
////                  onTap: () {
////                    Navigator.push(context,
////                        MaterialPageRoute(builder: (context) => AddNewTask(taskEmpty,StringConst.AddNewTask)));
////                  },
//
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//
////
//
//
//}
//
