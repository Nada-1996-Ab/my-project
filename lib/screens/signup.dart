import 'package:chat_app/app_theme.dart';
import 'package:chat_app/donor/donorDrawer/donorNavigationHome.dart';
import 'package:chat_app/helpers/common.dart';
import 'package:chat_app/helpers/style.dart';
import 'package:chat_app/needy/needyDrawer/needyNavigationHome.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/widgets/clipper_container_login.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  String signType;
  SignUp(this. signType);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool hidePass = true;
  int check_length;

  @override
  void initState() {
    print(widget.signType);
    check_length = widget.signType=="Donor"?8:6;

    super.initState();
  }

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
                        padding: EdgeInsets.only(top: 60,left: 20,right: 20),
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
                                  const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.grey.withOpacity(0.3),
                                    elevation: 0.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: ListTile(
                                        title: TextFormField(
                                          controller: _name,
                                          decoration: InputDecoration(
                                              hintText: "Full name",
                                              icon: Icon(Icons.person_outline),
                                              border: InputBorder.none),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "The name field cannot be empty";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.grey.withOpacity(0.2),
                                    elevation: 0.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: ListTile(
                                        title: TextFormField(
                                          controller: _email,
                                          decoration: InputDecoration(
                                              hintText: "Email",
                                              icon: Icon(Icons.alternate_email),
                                              border: InputBorder.none),
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
                                      child: ListTile(
                                        title: TextFormField(
                                          controller: _password,
                                          obscureText: hidePass,
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              icon: Icon(Icons.lock_outline),
                                              border: InputBorder.none),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "The password field cannot be empty";
                                            } else if (value.length < check_length) {
                                              return "the password has to least 6 characters long";
                                            }
                                            return null;
                                          },
                                        ),
                                        trailing: IconButton(
                                            icon: Icon(Icons.remove_red_eye),
                                            onPressed: () {
                                              setState(() {
                                                hidePass = !hidePass;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(80.0, 20.0, 80.0, 20.0),
                                  child: Material(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: AppColors.primary,
                                      elevation: 0.0,
                                      child: MaterialButton(
                                        onPressed: () async{
                                          if(_formKey.currentState.validate()){
                                            if(!await user.signUp(_name.text ,_email.text, _password.text,widget.signType)){
                                              _key.currentState.showSnackBar(SnackBar(content: Text("Sign up failed ")));
                                              return;
                                            }
                                            else
                                            if(widget.signType=="Dondor"){
                                              changeScreenReplacement(context, donor_navigation_home());
                                            }
                                            else
                                              changeScreenReplacement(context, needy_navigation_home());
                                          }
                                        },
                                        minWidth: MediaQuery.of(context).size.width,
                                        child: Text(
                                          "Sign up",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      )),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => Login()));
                                      },
                                      child: Container(
//                                        margin: EdgeInsets.symmetric(vertical: 20),
                                        padding: EdgeInsets.only(bottom: 30),
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              StringConst.alreadyHaveAcount,
                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              StringConst.LOG_IN_2,
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
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            )));

  }

}
