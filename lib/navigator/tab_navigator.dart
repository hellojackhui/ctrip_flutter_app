import 'package:ctrip_flutter_app/pages/home_page.dart';
import 'package:ctrip_flutter_app/pages/my_page.dart';
import 'package:ctrip_flutter_app/pages/search_page.dart';
import 'package:ctrip_flutter_app/pages/travel_page.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  var _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
           _currentIndex = index; 
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem(Icons.home, '首页', 0),
          _bottomItem(Icons.search, '搜索', 1),
          _bottomItem(Icons.camera_alt, '旅拍', 2),
          _bottomItem(Icons.account_circle, '我的', 3),

        ],
      ),
    );
  }
  BottomNavigationBarItem _bottomItem(icon, name, index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      title: Text(name, style: TextStyle(color: _currentIndex == index ? _activeColor : _defaultColor)),
      activeIcon: Icon(icon, color: _activeColor)
    );
  }
}