import 'dart:ui';
import 'package:chat_app/api/database.dart';
import 'package:chat_app/donor/donor_Edite/add_post_screen.dart';
import 'package:chat_app/donor/donor_post_details.dart';
import 'package:chat_app/helpers/common.dart';
import 'package:chat_app/models/postModel.dart';
import 'package:chat_app/provider/app.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/services/users.dart';
import 'package:chat_app/widgets/CheckDialog.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/spaces.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MyPostsScreen2 extends StatefulWidget {
  int cateId;

  MyPostsScreen2(this.cateId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyPostsScreen2State(this.cateId);
  }
}

class _MyPostsScreen2State extends State<MyPostsScreen2>
    with TickerProviderStateMixin {
  int cateId;

  AnimationController animationController;

  _MyPostsScreen2State(this.cateId);

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
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteShade2,
        body: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                child: Container(
                  color: AppColors.whiteShade2,
                  child: StreamProvider<List<postModel>>.value(
                    value: DatabaseService(uid: "")
                        .getDonorPosts(cateId, userProvider.userModel.id),
                    child: PostsList(animationController),
                  ),
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
                  StringConst.myPost,
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
                        print(cateId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Addpost(new postModel(),
                                    StringConst.addPost, cateId)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: AppColors.primary,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostsList extends StatefulWidget {
  final AnimationController animationController;

  PostsList(this.animationController);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PostsListState(this.animationController);
  }
}

class _PostsListState extends State<PostsList> {
  final AnimationController animationController;
  TextEditingController controller = new TextEditingController();
  String userId = '';
  List<postModel> _searchResult = [];
  List<postModel> _postDetails = [];

  _PostsListState(this.animationController);

  @override
  void initState() {
    super.initState();
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _postDetails.forEach((userDetail) {
      if (userDetail.postTitle.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _postDetails = Provider.of<List<postModel>>(context);
    });
    return Column(children: <Widget>[
      getSearchBarUI(),
      getCategoryUI(),
      _postDetails?.isEmpty ?? true
          ? Padding(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.height * 0.08,
              ),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    StringConst.postEmpty,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                  )),
            )
          : Expanded(
              child: Container(
              color: AppColors.white,
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? new GridView(
                      padding: const EdgeInsets.all(8),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: List<Widget>.generate(
                        _searchResult.length,
                        (int index) {
                          final int count = _searchResult.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn),
                            ),
                          );
                          animationController.forward();
                          return postList(
                            callback: () {},
                            postData: _searchResult[index],
                            animation: animation,
                            animationController: animationController,
                          );
                        },
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 32.0,
                        crossAxisSpacing: 32.0,
                        childAspectRatio: 0.8,
                      ),
                    )
                  : new GridView(
                      padding: const EdgeInsets.all(8),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: List<Widget>.generate(
                        _postDetails.length,
                        (int index) {
                          final int count = _postDetails.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn),
                            ),
                          );
                          animationController.forward();
                          return postList(
                            callback: () {},
                            postData: _postDetails[index],
                            animation: animation,
                            animationController: animationController,
                          );
                        },
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 32.0,
                        crossAxisSpacing: 32.0,
                        childAspectRatio: 0.8,
                      ),
                    ),
            ))
    ]);
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
                StringConst.myPost,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: AppColors.darkModeColor.withOpacity(0.5),
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
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: StringConst.search, border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new InkWell(
                    onTap: () {
                      controller.clear();
                      onSearchTextChanged('');
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

class postList extends StatelessWidget {
  const postList(
      {Key key,
      this.postData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final postModel postData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

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
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
                changeScreen(context, PostDetails(post: postData));
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(3),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  shape: BoxShape.rectangle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AppColors.grey.withOpacity(0.4),
                                        offset: const Offset(2.0, 2.0),
                                        blurRadius: 8),
                                  ],
                                  color: AppColors.white),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 3,
                                          bottom: 2),
                                      // alignment: Alignment.center,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              postData.postTitle,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                letterSpacing: 0.27,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(right: 6,left: 6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(0.0)),
                                                color: AppColors.primary
                                                    .withOpacity(0.2),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5,
                                                          bottom: 5,
                                                          right: 10,
                                                          left: 10),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    .5),
                                                            width: 1),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        color: AppColors.white,
                                                      ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            '${postData.postType}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 11,
                                                              letterSpacing:
                                                                  0.27,
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: AppColors.googleRed,
                                                        ),
                                                        onPressed: () async {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return CheckDialog(
                                                                title:
                                                                    StringConst
                                                                        .delete,
                                                                content: StringConst
                                                                    .checkDeletePost,
                                                                pressYes:
                                                                    () async {
                                                                  await DatabaseService(
                                                                          uid:
                                                                              "")
                                                                      .deleteTask(
                                                                          postData
                                                                              .postId);
                                                                  Navigator.pop(
                                                                      context,
                                                                      true);
                                                                },
                                                                pressNo: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      true);
                                                                },
                                                              );
                                                            },
                                                          );
                                                        })
                                                  ],
                                                ),
                                              )),
                                          SpaceH8(),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 2, bottom: 2),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    '${postData.postState ? "UnAvaliable" : "Avaliable"} ',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.blackShade2,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      letterSpacing: .5,
                                                      height: 1.0,
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
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //  height: 130,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppColors.grey.withOpacity(0.9),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: AspectRatio(
                              aspectRatio: 1.28,
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: postData.postImage,
                                fit: BoxFit.cover,
                                height: 150,
                                width: 120,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
