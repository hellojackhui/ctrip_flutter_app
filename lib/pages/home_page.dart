import 'package:ctrip_flutter_app/dao/home_dao.dart';
import 'package:ctrip_flutter_app/model/common_model.dart';
import 'package:ctrip_flutter_app/model/grid_nav_model.dart';
import 'package:ctrip_flutter_app/model/home_model.dart';
import 'package:ctrip_flutter_app/model/sales_box_model.dart';
import 'package:ctrip_flutter_app/pages/city_page.dart';
import 'package:ctrip_flutter_app/pages/search_page.dart';
import 'package:ctrip_flutter_app/pages/speak_page.dart';
import 'package:ctrip_flutter_app/util/navigator_utils.dart';
import 'package:ctrip_flutter_app/widgets/grid_nav.dart';
import 'package:ctrip_flutter_app/widgets/local_nav.dart';
import 'package:ctrip_flutter_app/widgets/sales_box.dart';
import 'package:ctrip_flutter_app/widgets/search_bar.dart';
import 'package:ctrip_flutter_app/widgets/sub_nav.dart';
import 'package:ctrip_flutter_app/widgets/webview.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNav;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;
  bool _loading = true;
  String city = '北京市';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
    Future.delayed(Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
  }

  void _onscroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
     appBarAlpha = alpha; 
    });
  }

  //加载首页数据
  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNav = model.gridNav;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollNotification && scrollNotification.depth == 0) {
                  _onscroll(scrollNotification.metrics.pixels);
                }
                return false;
              }, 
              child: _listView,
            ),
          ),
          _appBar
        ],
      ),
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            localNavList: localNavList,
          ),
        ),
        /*网格卡片*/
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNav: gridNav),
        ),
        /*活动导航*/
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        /*底部卡片*/
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(salesBox: salesBox),
        ),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: _jumpToCity,
              city: city,
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        autoplay: true,
        loop: true,
        pagination: SwiperPagination(),
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            bannerList[index].icon,
            fit: BoxFit.fill,);
        },
        onTap: (index) {
          NavigatorUtils.push(context, WebView(
            url: bannerList[index].url,
            title: bannerList[index].title,
            hideAppbar: bannerList[index].hideAppBar,
          ));
        },
      ),
    );
  }

  void _jumpToSearch() {
    NavigatorUtils.push(context, SearchPage(
      hint: SEARCH_BAR_DEFAULT_TEXT,
    ));
  }
  void _jumpToSpeak() {
    NavigatorUtils.push(context, SpeakPage());
  }
  void _jumpToCity() {
    NavigatorUtils.push(context, CityPage());
  }
}