import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(50, 102, 152, 1),
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

String _alertText = "Informe seus dados primeiro!";

class _MyPageState extends State<MyPage> {
  TextEditingController altura = TextEditingController();
  TextEditingController peso = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField() {
    peso.text = "";
    altura.text = "";
    setState(() {
      // _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calcularIMC() {
    setState(() {
      double weight = double.parse(peso.text);
      double height = double.parse(altura.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _alertText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _alertText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _alertText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _alertText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _alertText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _alertText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                _alertText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          });
      _resetField();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Calculadora de IMC'),
        ),
      ),
      body: SingleChildScrollView(
          // padding: EdgeInsets.fromLTRB(10.0, 120, 10.0, 30.0),
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_pin,
                      size: 120,
                      color: Color.fromRGBO(50, 102, 152, 1),
                    ),
                    Text(
                      'SEU\nIMC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(50, 102, 152, 1),
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(color: Color.fromRGBO(0, 0, 0, 0), height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      icon: Icon(Icons.accessibility),
                      border: OutlineInputBorder(),
                      labelText: 'Sua altura em Cm'),
                  controller: altura,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  },
                ),
                Divider(color: Color.fromRGBO(0, 0, 0, 0), height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      icon: Icon(Icons.play_for_work),
                      border: OutlineInputBorder(),
                      labelText: 'Seu peso'),
                  controller: peso,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  },
                ),
                Divider(color: Color.fromRGBO(0, 0, 0, 0), height: 7),
                RaisedButton(
                  child: Text(
                    'Calcular',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      calcularIMC();
                    }
                  },
                  color: Color.fromRGBO(50, 102, 152, 1),
                  textColor: Colors.white,
                  disabledColor: Color.fromRGBO(50, 102, 152, 0.5),
                  disabledTextColor: Colors.white,
                ),
              ],
            ),
          )),
    );
  }
}
