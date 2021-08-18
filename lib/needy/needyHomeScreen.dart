import 'dart:ui';
import 'package:chat_app/category.dart';
import 'package:chat_app/helpers/common.dart';
import 'package:chat_app/helpers/style.dart';
import 'package:chat_app/needy/needyPostsScreen.dart';
import 'package:chat_app/screens/cart.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';

class needyHomeScreen extends StatefulWidget {
  @override
  _needyHomeScreenState createState() => _needyHomeScreenState();
}

class _needyHomeScreenState extends State<needyHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<needyCategory> cateList = needyCategory.categoryList;
  bool multiple = true;

  void _submitForm() async {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    setState(() {});
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
    return Scaffold(
        backgroundColor: AppColors.whiteShade2,
        body: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: AppColors.black,
                      ),
                      title: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (pattern) async {
//                          await productProvider.search(productName: pattern);
//                          changeScreen(context, ProductSearchScreen());
                        },
                        decoration: InputDecoration(
                          hintText: "Search...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.whiteShade2,
                  child: Column(children: <Widget>[
                    Expanded(
                        child: Container(
                      color: AppColors.white,
                      child: new GridView(
                        padding:
                            const EdgeInsets.only(top: 0, left: 12, right: 12),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: List<Widget>.generate(
                          cateList.length,
                          (int index) {
                            final int count = cateList.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController.forward();
                            return CateList(
                              animation: animation,
                              animationController: animationController,
                              needycateData: cateList[index],
                            );
                          },
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: multiple ? 2 : 1,
                          mainAxisSpacing: 19.0,
                          crossAxisSpacing: 19.0,
                          childAspectRatio: 1.0,
                        ),
                      ),
                    ))
                  ]),
                ),
              )
            ],
          ),
        ));
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteShade2,
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
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            ),
            Expanded(
              child: Center(
                child: Text(
                  StringConst.MYCATEGORY,
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        changeScreen(context, CartScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(
                          Icons.shopping_cart,
                          color: AppColors.black,
                          size: 25,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CateList extends StatelessWidget {
  const CateList(
      {Key key,
      this.animationController,
      this.animation,
      this.callback,
      this.needycateData})
      : super(key: key);
  final VoidCallback callback;
  final needyCategory needycateData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  void goBack(BuildContext context) {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Container(
                margin:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightBlueShade1,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppColors.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            print(needycateData.cateId);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => needyPostsScreen(
                                        needycateData.cateId)));
                          },
                          child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
//                                    color: AppColors.primary,
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          needycateData.imagePath))))),
                      new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(0.0)),
                                  color: AppColors.black.withOpacity(0.1),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(needycateData.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 1),
                                    textScaleFactor: 1.4)),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(0.0)),
                                color: AppColors.black.withOpacity(0.1),
                              ),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
//
                                  ],
                                ),
                              ),
                            )
                          ]),
                    ],
                  ),
                ))),
          ),
        );
      },
    );
  }
}
