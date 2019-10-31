import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';


class CityPage extends StatefulWidget {
  final String locateCity;
  const CityPage({Key key, this.locateCity}):super(key: key);
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  List<CityInfo> _cityList = List();
  List<CityInfo> _historyList = List();
  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";
  @override
  void initState() {
    super.initState();
    if (widget.locateCity != null) {
      _historyList.add(CityInfo(name: widget.locateCity));
      setState(() {
       _suspensionTag = widget.locateCity;
      });
    }
    _loadData();
  }

  _loadData() async{
    try {
      var value = await rootBundle.loadString('assets/data/cities.json');
      List list = json.decode(value);
      list.forEach((value) {
        _cityList.add(CityInfo(name: value['name']));
      });
      _handleList(_cityList);
      setState(() {
        _cityList = _cityList;
      });
    } catch (e) {
      print(e);
    }
  }
  
  void _handleList(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildHeader() {
    List<CityInfo> hotCityList = List();
    hotCityList.addAll([
      CityInfo(name: "北京"),
      CityInfo(name: "上海"),
      CityInfo(name: "广州"),
      CityInfo(name: "深圳"),
      CityInfo(name: "西安"),
      CityInfo(name: "成都"),
    ]);
    return Padding(
      padding: EdgeInsets.only(right: 40),
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        spacing: 20.0,
        children: hotCityList.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, e.name);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200]
              ),
              child: Text(e.name, style: TextStyle(color: _suspensionTag == e.name ? Colors.blue : Colors.black54, fontSize: 14),),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(CityInfo model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: Text(model.name),
            onTap: () {
              print("OnItemClick: $model");
              Navigator.pop(context, model.name);
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('选择城市'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, '北京');
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
                    alignment: Alignment.centerLeft,
                    child: Text('当前城市', style: TextStyle(fontSize: 16, color: Colors.black87),),
                  ),
                  _buildHistory()
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: AzListView(
                  data: _cityList,
                  itemBuilder: (context, model) => _buildListItem(model),
                  suspensionWidget: _buildSusWidget(_suspensionTag),
                  isUseRealIndex: true,
                  itemHeight: _itemHeight,
                  suspensionHeight: _suspensionHeight,
                  onSusTagChanged: _onSusTagChanged,
                  header: AzListViewHeader(
                      tag: "热门",
                      height: 140,
                      builder: (context) {
                        return Column(
                          children: <Widget>[
                            FractionallySizedBox(
                              widthFactor: 1,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 15),
                                alignment: Alignment.centerLeft,
                                child: Text('热门城市', style: TextStyle(fontSize: 16, color: Colors.black87),),
                              ),
                            ),
                            _buildHeader()
                          ],
                        );
                      }),
                indexHintBuilder: (context, hint) {
                    return Container(
                      alignment: Alignment.center,
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          color: Colors.black54, shape: BoxShape.circle),
                      child: Text(hint,
                          style: TextStyle(color: Colors.white, fontSize: 30.0)),
                  );
                },
              )
            ),
          ],
        ),
      )
    );
  }

  Widget _buildHistory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _historyList.map((e) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
            margin: EdgeInsets.only(bottom: 10),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Icon(Icons.location_on, color: Colors.blue, size: 16,),
                ),
                Text(e.name, style: TextStyle(color: Colors.black87, fontSize: 14),)
              ],
            )
          );
        }).toList()
      ),
    );
  }
}


class CityInfo extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;
  CityInfo({this.name, this.tagIndex, this.namePinyin});
  CityInfo.fromJson(Map<String, dynamic> json) : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'tagIndex': tagIndex,
    'namePinyin': namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';

}