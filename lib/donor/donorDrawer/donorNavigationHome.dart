import 'package:chat_app/donor/OrderScreen.dart';
import 'package:chat_app/donor/donorDrawer/donorHomeDrawer.dart';
import 'package:chat_app/app_theme.dart';
import 'package:chat_app/donor/donor_Edite/donorCateFileScreen.dart';
import 'package:chat_app/profile/profileScreen.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'drawer_donor_controller.dart';
class donor_navigation_home extends StatefulWidget {
  @override
  _donor_navigation_homeState createState() => _donor_navigation_homeState();
}

class _donor_navigation_homeState extends State<donor_navigation_home> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView =  donorCateFileScreen();
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
          body: drawer_donorcontroller(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView =  donorCateFileScreen();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = OrderScreen();
        });
      } else if (drawerIndex == DrawerIndex.Profile) {
        setState(() {
          screenView = profileScreen();
        });
      } else if (drawerIndex == DrawerIndex.Orders) {
        setState(() {
//          screenView = PendingTaskScreen();
          screenView = OrderScreen();
        });
      } else {
        //do in your way......
      }
    }
  }
}
