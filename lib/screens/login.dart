import 'package:chat_app/app_theme.dart';
import 'package:chat_app/donor/donorDrawer/donorNavigationHome.dart';
import 'package:chat_app/helpers/common.dart';
import 'package:chat_app/helpers/style.dart';
import 'package:chat_app/needy/needyDrawer/needyNavigationHome.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/screens/signup.dart';
import 'package:chat_app/screens/start_page.dart';
import 'package:chat_app/widgets/clipper_container_login.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        key: _key,
        body:  user.status == Status.Authenticating ? Loading() :SingleChildScrollView(
            child:
            Container(
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
                              alignment: Alignment.center,
                              height:  height * .2,
                              width:  height * .2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primary,
                                    width: 0
                                ),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(90.0)),
                                color: AppColors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.7),
                                    offset: const Offset(4, 4),
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
                      child: Container(
                          padding: EdgeInsets.only(top: 40,left: 20,right: 20),
                          height: size.height * 0.6,
                          width: size.width,
                          color: AppColors.primary.withOpacity(0),
                          alignment: Alignment.center,
                          child: Form(
                              key: _formKey,
                              child: ListView(
                                children: <Widget>[
                                  SizedBox(height: 50,),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 8.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.grey.withOpacity(0.3),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: TextFormField(
                                          keyboardType:TextInputType.emailAddress,
                                          controller: _email,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            icon: Icon(Icons.alternate_email),
                                          ),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Email is required';
                                            }
                                            if (!RegExp(
                                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                .hasMatch(value)) {
                                              return 'Please enter a valid email address';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.grey.withOpacity(0.3),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: TextFormField(
                                          obscureText: true,
                                          controller: _password,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            icon: Icon(Icons.lock_outline),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "The password field cannot be empty";
                                            } else if (value.length < 6) {
                                              return "the password has to be at least 6 characters long";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(80.0, 22.0, 80.0, 22.0),
                                    child: Material(
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: AppColors.primary,
                                        elevation: 0.0,
                                        child: MaterialButton(
                                          onPressed: () async{
                                            if(_formKey.currentState.validate()){
                                              if(!await user.signIn(_email.text, _password.text))
                                                _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                                            }
                                            if(userProvider.userModel.signup_type =="Dondor"){
                                              changeScreenReplacement(context, donor_navigation_home());
                                            }
                                            else
                                              changeScreenReplacement(context, needy_navigation_home());

                                          },
                                          minWidth: MediaQuery.of(context).size.width,
                                          child: Text(
                                            "Login",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0),
                                          ),
                                        )),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          changeScreenReplacement(context, StartPage());
                                        },
                                        child: Container(
//                                        margin: EdgeInsets.symmetric(vertical: 20),
                                          padding: EdgeInsets.only(bottom: 30),
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                StringConst.dontAlreadyHaveAcount,
                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                StringConst.creatAn_Acount,
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )

                                  ),


                                ],
                              ))
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

}
