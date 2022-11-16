import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: calculatorApp(),
    );
  }
}
class calculatorApp extends StatefulWidget {

  @override
  State<calculatorApp> createState() => _calculatorAppState();
}

class _calculatorAppState extends State<calculatorApp> {
  //Button Widget
  Widget calcbutton(String buttontext,Color buttoncolor,Color textcolor){
    return  Container(
      child: MaterialButton(
        onPressed: (){
          calculation(buttontext);
        },
        child: Text('$buttontext',
          style: TextStyle(
            fontSize: 35,
            color: textcolor,
          ),
        ),
        shape: CircleBorder(),
        color: buttoncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Calculator'),backgroundColor: Colors.teal,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(10),
                  child: Text('$text',textAlign: TextAlign.right,
                  style: TextStyle(color:Colors.teal,
                  fontSize: 100
                  ),
                  ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('AC',Colors.teal,Colors.white),
                calcbutton('+/-',Colors.white,Colors.teal),
                calcbutton('%',Colors.white,Colors.teal),
                calcbutton('/',Colors.white,Colors.teal),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7',Colors.white,Colors.black),
                calcbutton('8',Colors.white,Colors.black),
                calcbutton('9',Colors.white,Colors.black),
                calcbutton('x',Colors.white,Colors.teal),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4',Colors.white,Colors.black),
                calcbutton('5',Colors.white,Colors.black),
                calcbutton('6',Colors.white,Colors.black),
                calcbutton('-',Colors.white,Colors.teal),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1',Colors.white,Colors.black),
                calcbutton('2',Colors.white,Colors.black),
                calcbutton('3',Colors.white,Colors.black),
                calcbutton('+',Colors.white,Colors.teal),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                MaterialButton(
                  padding: EdgeInsets.all(10),
                  onPressed: (){
                    calculation('00');
                  },
                  shape: StadiumBorder(),
                  child: Text('00',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.black),
                  ),
                  color: Colors.white,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(10),
                  onPressed: (){
                    calculation('0');
                  },
                  shape: StadiumBorder(),
                  child: Text('0',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.black),
                  ),
                  color: Colors.white,
                ),
                calcbutton('.',Colors.white,Colors.black),
                calcbutton('=',Colors.teal,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text ='0';
  double num1 = 0;
  double num2 = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(buttonText) {
    if (buttonText == 'AC') {
      text = '0';
      num1 = 0;
      num2 = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && buttonText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (buttonText == '+' || buttonText == '-' || buttonText == 'x' ||
        buttonText == '/' || buttonText == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = buttonText;
      result = '';
    }
    else if (buttonText == '%') {
      result = num1 / 100;
      finalResult = doesContainDecimal(result);
    } else if (buttonText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    }

    else if (buttonText == '+/-') {
      result.toString().startsWith('-') ?
      result = result.toString().substring(1) : result =
          '-' + result.toString();
      finalResult = result;
    }
    else {
      result = result + buttonText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }
  String add() {
    result = (num1 + num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (num1 / num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}


