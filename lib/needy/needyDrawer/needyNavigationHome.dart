import 'package:chat_app/donor/donorDrawer/donorHomeDrawer.dart';
import 'package:chat_app/needy/OrderScreen1.dart';
import 'package:chat_app/needy/needyHomeScreen.dart';
import 'package:chat_app/needy/needyDrawer/drawer_needy_controller.dart';
import 'package:chat_app/app_theme.dart';
import 'package:chat_app/needy/needyDrawer/needyHomeDrawer.dart';
import 'package:chat_app/profile/profileScreen.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
class needy_navigation_home extends StatefulWidget {
  @override
  _needy_navigation_homeState createState() => _needy_navigation_homeState();
}

class _needy_navigation_homeState extends State<needy_navigation_home> {
  Widget screenView;
  DrawerIndexNedded drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndexNedded.HOME;
    screenView =  needyHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.primary,
          body: drawer_needycontroller(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndexNedded drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndexNedded drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndexNedded.HOME) {
        setState(() {
          screenView =  needyHomeScreen();
        });
      } else if (drawerIndex == DrawerIndexNedded.Help) {
        setState(() {
          screenView = OrderScreen1();
        });
      } else if (drawerIndex == DrawerIndexNedded.Profile) {
        setState(() {
          screenView = profileScreen();
        });
      } else if (drawerIndex == DrawerIndexNedded.Orders) {
        setState(() {
//          screenView = PendingTaskScreen();
          screenView = OrderScreen1();
        });
      } else {
        //do in your way......
      }
    }
  }
}
