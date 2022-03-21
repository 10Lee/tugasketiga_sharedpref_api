import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasminggu4/globals/style.dart';
import 'package:tugasminggu4/views/home.dart';
import 'package:tugasminggu4/views/register.dart';
import 'package:tugasminggu4/widgets/input_field_widget.dart';
import 'package:tugasminggu4/widgets/myrichtext.dart';
import 'package:tugasminggu4/widgets/pass_field_widget.dart';

import 'login.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  late SharedPreferences pref;

  String name = '', pass = '';

  void getDataToForm() async {
    pref = await SharedPreferences.getInstance();

    name = pref.getString('name') ?? 'no name';
    pass = pref.getString('pass') ?? 'no pass';

    print("$name $pass");
  }

  void validateLogin() async {
    pref = await SharedPreferences.getInstance();

    if (name == _nameController.text && pass == _passController.text) {
      print('login success');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Home()));
    } else {
      print('login failed');
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Not Match'),
            content: Text('You input data that not match of any account'),
            actions: [
              TextButton(
                  onPressed: () {
                    _nameController.text = '';
                    _passController.text = '';
                    Navigator.pop(context);
                  },
                  child: Text('Try again')),
              TextButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterView(),
                        ),
                        (Route<dynamic> route) => false,
                      ),
                  child: Text('Register new account'))
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    getDataToForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          color: Colors.pink,
          child: Center(
            child: ListView(
              children: [
                Center(
                  child: Text(
                    'Login',
                    style: kHeadingTextWhite,
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20.0),
                  width: double.infinity,
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        RegularInputWidget(
                          controller: _nameController,
                          valid: "Name must be filled",
                          label: "Name",
                          decorate: kInputDecoration.copyWith(
                            fillColor: Colors.pinkAccent,
                            hintText: "Enter your name",
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        PassInputWidget(
                          controller: _passController,
                          label: "Password",
                          valid: "Password field must be filled",
                          decorate: kInputDecoration.copyWith(
                            fillColor: Colors.pinkAccent,
                            hintText: "Enter your password",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () {
                            if (_globalKey.currentState!.validate()) {
                              validateLogin();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Center(
                              child: Text(
                                'Login now',
                                style: kTitleTextWhite.copyWith(
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        MyRichText(
                          describe: 'Don\'t have an account? ',
                          linkText: 'Click here',
                          link: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RegisterView()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
