import 'package:ctrip_flutter_app/widgets/search_bar.dart';
import 'package:ctrip_flutter_app/pages/user_register.dart';
import 'package:flutter/material.dart';


class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget get logintitle {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Center(child: Text(
        '携程账号登录',
        style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Raleway' 
        ),
      ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: false,
            rightText: "注册",
            leftButtonClick: () => Navigator.pop(context),
            rightButtonClick: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => RegisterPage()
            )),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logintitle,
                
              ],
            ),
          )
        ],
      ),
    );
  }
}