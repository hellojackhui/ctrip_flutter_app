import 'package:ctrip_flutter_app/dao/travel_tab_dao.dart';
import 'package:ctrip_flutter_app/model/travel_tab_model.dart';
import 'package:ctrip_flutter_app/pages/travel_tab_page.dart';
import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget{
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin{
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(vsync: this, length: model.tabs.length);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 30),
          child: TabBar(
            controller: _controller,
            isScrollable: true,
            labelColor: Colors.black12,
            labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 3, color: Color(0xff2fcfbb)),
              insets: EdgeInsets.fromLTRB(0, 0, 0, 10)
            ),
            tabs: tabs.map<Tab>((TravelTab tab) {
              return Tab(
                text: tab.labelName,
              );
            }).toList(),
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: _controller,
            children: tabs.map((TravelTab tab) {
              return TravelTabPage(
                travelUrl: travelTabModel.url,
                params: travelTabModel.params,
                groupChannelCode: tab.groupChannelCode,
                type: tab.type,
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}