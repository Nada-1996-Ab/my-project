import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/signup.dart';
import 'package:chat_app/widgets/clipper_container_login.dart';
import 'package:chat_app/widgets/spaces.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/home_basic.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
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
                          'assets/icons/logo.jpg',
                        ),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: LoginCustomClipper(),
              child: _buttonsSignUp(size, context),
            ),
          ),
        ],
      ),
    ));
  }

  Container _buttonsSignUp(Size size, BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 120),
        height: size.height * 0.6,
        width: size.width,
        color: AppColors.primary.withOpacity(0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpaceH16(),
              signEmployeeButton(context),
              SpaceH16(),
              signCompButton(context),
              SpaceH16(),
              InkWell(
                onTap: () {},
                child: Text(
                  StringConst.ALREADY_HAVE_AN_ACCOUNT,
                  style: TextStyle(color: AppColors.black.withOpacity(.6)),
                  textAlign: TextAlign.center,
                ),
              ),
              SpaceH16(),
              loginButton(context),
            ],
          ),
        ));
  }

  SizedBox signCompButton(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: Material(
          borderRadius: BorderRadius.circular(50.0),
          color: AppColors.primary,
          elevation: 0.0,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUp("Needy")));
            },
            minWidth: MediaQuery.of(context).size.width,
            child: Text(
              StringConst.SING_UP_AS_NEEDY,
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }

  SizedBox signEmployeeButton(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: Material(
          borderRadius: BorderRadius.circular(50.0),
          color: AppColors.primary,
          elevation: 0.0,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUp("Dondor")));
            },
            minWidth: MediaQuery.of(context).size.width,
            child: Text(
              StringConst.SING_UP_AS_DONDOR,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.white,
                  // fontWeight: FontWeight.normal,
                  fontSize: 16.0),
            ),
          )),
    );
  }

  Container loginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 80, left: 80),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(50.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppColors.primaryShadow.withOpacity(0.4),
              offset: const Offset(2, 4),
              blurRadius: 9.0),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Text(
          StringConst.LOG_IN,
          style: TextStyle(fontSize: 16, color: AppColors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
