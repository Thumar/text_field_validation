import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfoColl ',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyContactPage(title: 'Create Contact Page'),
    );
  }
}

class MyContactPage extends StatefulWidget {
  MyContactPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyContactPageState createState() => _MyContactPageState();
}

class _MyContactPageState extends State<MyContactPage> {
  final _formKey = GlobalKey<FormState>();
  User user = new User();

  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  TextFi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Form(
              key: _formKey,
              autovalidate: false,
              child: new ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                children: <Widget>[
                  Center(
                      child: Text(
                    "Create Contact",
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  )),
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.person),
                        hintText: 'Enter your name',
                        labelText: 'Name'),
                    inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.name = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        hintText: 'Enter your email address',
                        labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.email = value;
                    },
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.phone),
                        hintText: 'Enter your phone number',
                        labelText: 'Phone'),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      new WhitelistingTextInputFormatter(
                          new RegExp(r'^[0-9]*$')),
                      new LengthLimitingTextInputFormatter(10)
                    ],
                    validator: (value) {
                      if (!phoneRegex.hasMatch(value)) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.phoneNo = value;
                    },
                  ),

                  TextFormField(
                    key: _passwordFieldKey,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.security),
                      hintText: 'Select your password',
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.compare),
                        hintText: 'Please re-enter password',
                        labelText: 'Conform Password'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value != _passwordFieldKey.currentState.value) {
                        return 'Password do not match';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      user.password = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print("Process data");
                          _formKey.currentState.save();
                          print('Name: ${user.name}');
                          print('Email: ${user.email}');
                          print('Phone No: ${user.phoneNo}');
                          print('Password: ${user.password}');
                        } else {
                          print('Error');
                        }
                      },
                      child: Text('Create'),
                    ),
                  )
                ],
              ))),
    );
  }

  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");


}

class User {
  String name;
  String email;
  String phoneNo;
  String password;
}
