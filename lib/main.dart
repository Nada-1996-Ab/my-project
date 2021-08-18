import 'package:chat_app/donor/donorDrawer/donorNavigationHome.dart';
import 'package:chat_app/needy/needyDrawer/needyNavigationHome.dart';
import 'package:chat_app/provider/app.dart';
import 'package:chat_app/provider/post.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/splash.dart';
import 'package:chat_app/screens/start_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: PostProvider.initialize()),
    ChangeNotifierProvider.value(value: AppProvider()),


  ], child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.white
    ),
    home: ScreensController(),
  ),));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
        return StartPage();
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return  user.userModel.signup_type=="Needy"?
        needy_navigation_home():donor_navigation_home();
      default:
        return StartPage();
//    case Status.Uninitialized:
//    return Splash();
//    case Status.Unauthenticated:
//    return StartScreen();
//    case Status.Authenticating:
//    return Login();
//    case Status.Authenticated:
//    return NavigationScreen();
//    default: return StartScreen();
//
    }
  }
}




