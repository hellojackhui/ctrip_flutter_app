import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String placeholder;
  final String value;
  final bool pwdhide;
  final Function onchange;
  final Function rightBtnCallback;
  final String rightText;
  final bool autofocus;

  const LoginInput({Key key, this.placeholder, this.value, this.pwdhide, this.onchange, this.rightText = "找回密码", this.autofocus, this.rightBtnCallback}) : super(key: key);
  
  @override
  _LoginInputState createState() => _LoginInputState();
}


class _LoginInputState extends State<LoginInput> {
  TextEditingController _controller = new TextEditingController();
  String inputText = "";
  bool clearicon = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.value != null) {
      _controller.text = widget.value;
    }
  }

  Widget _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  void _onchange(String value) {
    if (value.length <= 0) {
      setState(() {
        clearicon = false;
      });
    } else {
      setState(() {
        clearicon = true;
      });
    }
    if (widget.onchange != null) {
      widget.onchange(value);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 5, 10.0, 5),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextField(
                controller: _controller,
                onChanged: _onchange,
                autofocus: widget.autofocus,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w300
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  hintText: widget.placeholder,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                ),
              )
            ),
            clearicon ? 
              _wrapTap(Icon(Icons.clear, size: 22, color: Colors.grey,), () {
                setState(() {
                  _controller.clear();
                  _onchange('');
                });
              })
            : null,
            _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.indigoAccent[100],
                      width: 1.0,
                      style: BorderStyle.solid
                    ),
                  )
                ),
                child: Text(
                  widget.rightText,
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightBtnCallback
            ),
            
          ],
        ),
      )
    );
  }
}