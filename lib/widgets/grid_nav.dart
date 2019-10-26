import 'package:ctrip_flutter_app/model/common_model.dart';
import 'package:ctrip_flutter_app/model/grid_nav_model.dart';
import 'package:ctrip_flutter_app/widgets/webview.dart';
import 'package:flutter/material.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNav;
  GridNav({Key key, this.gridNav}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6.0),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNav == null) return items;
    if (gridNav.hotel != null) {
      items.add(_gridNavItem(context, gridNav.hotel, true));
    }
    if (gridNav.flight != null) {
      items.add(_gridNavItem(context, gridNav.flight, true));
    }
    if (gridNav.travel != null) {
      items.add(_gridNavItem(context, gridNav.travel, true));
    }
    return items;
  }

  Widget _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    List<Widget> expandItems = [];
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor}'));

    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

    items.forEach((item) {
      expandItems.add(Expanded(
        flex: 1,
        child: item
      ));
    });

    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor]
        )
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
      context,
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.network(
            model.icon,
            fit: BoxFit.contain,
            width: 121,
            height: 88,
            alignment: AlignmentDirectional.bottomCenter,
          ),
          Container(
            margin: EdgeInsets.only(top: 11),
            child: Text(model.title, style: TextStyle(fontSize: 14, color: Colors.white),),
          )
        ],
      ),
      model
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(
            context,
            topItem,
            true,
          ),
        ),
        Expanded(
          child: _item(
            context,
            bottomItem,
            false,
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //撑满宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
              left: borderSide,
              bottom: first ? borderSide : BorderSide.none)
            ),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          item)
      ),
    );
  }

  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => WebView(
            url: model.url,
            statusBarColor: model.statusBarColor,
            hideAppbar: model.hideAppBar,
            title: model.title,
          )
        ));
      },
      child: widget,
    );
  }
}