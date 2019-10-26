import 'package:ctrip_flutter_app/model/common_model.dart';
import 'package:ctrip_flutter_app/util/navigator_utils.dart';
import 'package:ctrip_flutter_app/widgets/webview.dart';
import 'package:flutter/material.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;
  const SubNav({Key key, @required this.subNavList}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6)
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    int seperate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, seperate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(seperate, subNavList.length),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          NavigatorUtils.push(context, WebView(
            url: model.url,
            statusBarColor: model.statusBarColor,
            hideAppbar: model.hideAppBar,
            title: model.title,
          ));
        },
        child: Column(
          children: <Widget>[
            Image.network(model.icon, width: 18, height: 18),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                model.title, style: TextStyle(
                  fontSize: 12
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}