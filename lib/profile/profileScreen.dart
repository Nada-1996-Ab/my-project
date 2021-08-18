import 'package:chat_app/api/database.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/widgets/clipper_container_login.dart';
import 'package:chat_app/widgets/spaces.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class profileScreen extends StatefulWidget {
  profileScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  bool editePhone = false;
  bool editeName = false;
  bool editeEmail = false;
  bool save = false;
  String user_id;

  TextEditingController fullName = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController emailAddress = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  CategoryType categoryType = CategoryType.requested;
  String selectLanguage = StringConst.english;
  List<String> _languages = [
    StringConst.english,
    StringConst.arabic,
  ];
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    fullName.text = userProvider.userModel?.name ?? "username lading...";
    phoneNumber.text = userProvider.userModel?.phoneNumber ?? "phone number lading...";
    emailAddress.text = userProvider.userModel?.email ?? "username lading...";

    setState(() {
      user_id=userProvider.userModel.id;
    });
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  appBar(),
                  SpaceH20(),
                  Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.center,
                      height: height * .2,
                      width: height * .2,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary, width: 0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(90.0)),
                        color: AppColors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.7),
                            offset: const Offset(2, 4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(90.0)),
                        child: Image.asset(
                          'assets/icons/userImage.png',
                        ),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            child: ClipPath(
              clipper: LoginCustomClipper(),
              child: _buttonsSignUp(size, context),
            ),
          ),
        ],
      ),
    ));
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height + 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Text(
                StringConst.profile,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.darkModeColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(AppBar().preferredSize.height),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 10),
                      child: Row(
                        children: <Widget>[

                          save?InkWell(
                            onTap: () {
                              setState(() {
                                setState(() {
                                  DatabaseService().editUserData(
                                      fullName.text,phoneNumber.text,emailAddress.text, user_id);
                                  editeName=!editeName;
                                  editeEmail=!editeEmail;
                                  editePhone=!editePhone;
                                  save=!save;
                                });

                              });

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                LineAwesomeIcons.check,
                                color: AppColors.primary,
                                size: 28,
                              ),
                            ),
                          ):Text(" "),
                          InkWell(
                            onTap: () {
                              setState(() {
                                editeName=!editeName;
                                editeEmail=!editeEmail;
                                editePhone=!editePhone;
                                save=!save;
                              });

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Icon(
                                LineAwesomeIcons.edit,
                                color: AppColors.primary,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
              onTap: () {
                setState(() {
                  // multiple = !multiple;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buttonsSignUp(Size size, BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 120),
        height: size.height * 0.8,
        width: size.width,
        color: AppColors.primary.withOpacity(0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpaceH12(),
              SizedBox(
                height: 15,
              ),
              SpaceH12(),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 3),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Column(
//
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color:
                                              AppColors.grey.withOpacity(0.2),
                                          offset: const Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
//                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    // maxLines: 4,
                                    maxLengthEnforced: false,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    controller: fullName,
                                    enabled: editeName,
//                                          enabled: false,
                                    decoration: InputDecoration(
                                      hintText: StringConst.NAME,
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
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
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppColors.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            // maxLines: 4,
                            maxLengthEnforced: false,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            controller: phoneNumber,
                            enabled: editePhone,
                            decoration: InputDecoration(
                              hintText: StringConst.phoneNumber,
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          SpaceH8(),
                          TextFormField(
                            controller: emailAddress,
                            enabled: editeEmail,
                            decoration: InputDecoration(
                              hintText: "Email",
                            ),
                          ),
//


                        ])),
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ));
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;

  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .2,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(top: 6, bottom: 4),
          child: Text(
            title,
            softWrap: false,
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: TextStyle(
                fontSize: 14,
                color: AppColors.black.withOpacity(.8),
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}

enum CategoryType {
  requested,
  done,
}
