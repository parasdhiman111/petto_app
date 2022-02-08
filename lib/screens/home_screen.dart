import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petto_app/constants.dart';
import 'package:petto_app/screens/Uploader_Screen.dart';
import 'package:petto_app/screens/activity_feed_screen.dart';
import 'package:petto_app/screens/main_screen.dart';
import 'package:petto_app/screens/profile_screen.dart';
import 'package:petto_app/screens/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }


  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: PageView(
            children: [
              Container(
                color: Colors.white,
                child: MainScreen(),
              ),
              Container(color: Colors.white, child: SearchScreen()),
              Container(
                color: Colors.white,
                child: UploaderScreen(),
              ),
              Container(
                  color: Colors.white, child: ActivityFeedScreen()),
              Container(
                  color: Colors.white,
                  child: ProfileScreen()),
            ],
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
          ),
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,
                      color: (_page == 0) ? Colors.black : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search,
                      color: (_page == 1) ? Colors.black : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle,
                      color: (_page == 2) ? Colors.black : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star,
                      color: (_page == 3) ? Colors.black : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color: (_page == 4) ? Colors.black : Colors.grey),
                  title: Container(height: 0.0),
                  backgroundColor: Colors.white),
            ],
            onTap: navigationTapped,
            currentIndex: _page,
          ),
        );
  }


}
