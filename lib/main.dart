import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  String text = '0';
  double numOne = 0;
  double numTwo = 0;

  String result = '0';
  String finalResult = '0';

  String opr = '';
  String preOpr = '';

  List<String> tab = new List();

  MediaQueryData queryData;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
                Row(
                     children: <Widget>[
                          SizedBox(height: queryData.size.width * 0.19),
                           Container(
                                width: queryData.size.width,
                                height: queryData.size.width * 0.27,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      fontSize: queryData.size.width * 0.23,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.end,
                    ),
                  ),
                 ),
                ]
               ),
                /* Expanded(
                            child: Text(text,
                                style: TextStyle(color: Colors.white, fontSize: 60),
                                maxLines: 1,
                                textAlign: TextAlign.right))
                      ],
                    ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    button("C", Color(0xffa6a4a6), 1),
                    button("+/-", Color(0xffa6a4a6), 1),
                    button("%", Color(0xffa6a4a6), 1),
                    button("/", Color(0xffff9800), 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    button("7", Color(0xff353133), 1),
                    button("8", Color(0xff353133), 1),
                    button("9", Color(0xff353133), 1),
                    button("X", Color(0xffff9800), 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    button("4", Color(0xff353133), 1),
                    button("5", Color(0xff353133), 1),
                    button("6", Color(0xff353133), 1),
                    button("-", Color(0xffff9800), 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    button("1", Color(0xff353133), 1),
                    button("2", Color(0xff353133), 1),
                    button("3", Color(0xff353133), 1),
                    button("+", Color(0xffff9800), 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    button("0", Color(0xff353133), 0),
                    button(".", Color(0xff353133), 1),
                    button("=", Color(0xffff9800), 1),
                  ],
                )
                ],
              ),
    )
    );
  }

  Widget button(String btntxt, Color color, int num) {
    Container container;
    if (num == 0) {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            if (btntxt != "C" && btntxt != "=" && btntxt != "+/-") {
              setState(() {
                if (text != "0")
                  text += btntxt;
                else
                  text = btntxt;
              });
            }
            calculate(btntxt);
          },
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          color: color,
          padding: EdgeInsets.only(left: 81, top: 20, right: 81, bottom: 20),
          shape: StadiumBorder(),
        ),
      );
    } else {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            if (btntxt != "C" && btntxt != "=" && btntxt != "+/-") {
              setState(() {
                if (text != "0")
                  text += btntxt;
                else
                  text = btntxt;
              });
            }
            calculate(btntxt);
          },
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          color: color,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
        ),
      );
    }

    return container;
  }

  void calculate(txtbtn) {
    if (txtbtn == "+/-") {
      tab[0] = (-1 * double.parse(text)).toString();
      setState(() {
        text = decimalRemove((-1 * double.parse(text)).toString());
      });
    }

    else if (txtbtn == "C") {
      numOne = 0;
      numTwo = 0;
      result = '';
      opr = '';
      finalResult = '0';
      setState(() {
        text = '0';
      });
      if (tab.isNotEmpty) {
        tab.clear();
      }
    } else if (txtbtn == '=') {
      if (tab.isNotEmpty) {
        if (tab.length > 2) {
          List<String> tab2 = List();
          for (int i = 0; i < tab.length; i++) {
            tab2.add(tab[i]);
            if (tab2.length >= 3) {
              numOne = double.parse(tab2[0]);
              numTwo = double.parse(tab2[2]);
              opr = tab2[1];
              tab2.clear();
              switch (opr) {
                case '+':
                  result =
                      (numOne + numTwo).toString();
                  break;
                case '-':
                  result =
                      (numOne - numTwo).toString();
                  break;
                case 'X':
                  result =
                      (numOne * numTwo).toString();
                  break;
                case '/':
                  result =
                      (numOne / numTwo).toString();
                  break;
                case '%':
                  result =
                      (numOne % numTwo).toString();
                  break;
              }
              tab2.add(result);
              finalResult = result;
              result = '';
            }
          }
          numOne = 0;
          numTwo = 0;
          opr = '';

          tab.clear();
          tab.add(tab2[0]);
          setState(() {
            text = decimalRemove(finalResult);
          });
        } else {
          if (tab.length == 2) tab.removeAt(1);
          setState(() {
            finalResult = tab[0];
            text = decimalRemove(finalResult);
          });
        }
      } else {
        setState(() {
          text = decimalRemove(finalResult);
        });
      }
    } else {
      if (tab.isEmpty) {
        if (IsOperant(txtbtn)) tab.add(txtbtn);
      } else {
        if (IsOperant(txtbtn)) {
          if (IsOperant(tab[tab.length - 1]))
            tab[tab.length - 1] += txtbtn;
          else
            tab.add(txtbtn);
        } else
          tab.add(txtbtn);
      }
    }
  }

  bool IsOperant(String txtbtn) {
    bool isoper = false;

    if (txtbtn != '+' &&
        txtbtn != '-' &&
        txtbtn != 'X' &&
        txtbtn != '/' &&
        txtbtn != '%') isoper = true;

    return isoper;
  }

  String decimalRemove(String _result) {
    if (_result.contains('.')) {
      List<String> split = _result.split('.');
      //[11, 0]
      if (!(int.parse(split[1]) > 0))
        return split[0];
    }
    return _result;
  }

}