import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPageAdmin(),
    );
  }
}

class LoginPageAdmin extends StatefulWidget {
  @override
  _LoginPageAdminState createState() => _LoginPageAdminState();
}

class _LoginPageAdminState extends State<LoginPageAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final querySnapshot = await _firestore
                          .collection('admin')
                          .where('email', isEqualTo: _emailController.text)
                          .where('password',
                              isEqualTo: _passwordController.text)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        // Login successful
                        print('Login successful');
                        Navigator.of(context)
                            .pushReplacementNamed("mainAdminPage");
                      } else {
                        // Login failed
                        print('Login failed');
                      }
                    } catch (e) {
                      print('Error: $e');
                    }
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
