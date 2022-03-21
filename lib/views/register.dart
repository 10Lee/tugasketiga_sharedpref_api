import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasminggu4/globals/style.dart';
import 'package:tugasminggu4/views/home.dart';
import 'package:tugasminggu4/widgets/input_field_widget.dart';

import 'package:tugasminggu4/widgets/myrichtext.dart';
import 'package:tugasminggu4/widgets/pass_field_widget.dart';

import 'login.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  late SharedPreferences pref;

  void saveAccount() async {
    pref = await SharedPreferences.getInstance();

    pref.setString('name', _nameController.text);
    pref.setString('city', _cityController.text);
    pref.setString('pass', _passController.text);
    pref.setString('confirmpass', _confirmPassController.text);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Home()));
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
          color: Colors.purple,
          child: Center(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Center(
                  child: Text(
                    'Register',
                    style: kHeadingTextWhite,
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 20.0,
                  ),
                  width: double.infinity,
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        RegularInputWidget(
                          controller: _nameController,
                          valid: "Name field must be filled",
                          label: "Name",
                          decorate: kInputDecoration.copyWith(
                            fillColor: Colors.purpleAccent,
                            hintText: "Enter your name",
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RegularInputWidget(
                          controller: _cityController,
                          valid: "City field must be filled",
                          label: "City",
                          decorate: kInputDecoration.copyWith(
                            fillColor: Colors.purpleAccent,
                            hintText: "Enter where you live",
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        PassInputWidget(
                          controller: _passController,
                          valid: "Password field must be filled",
                          label: "Password",
                          decorate: kInputDecoration.copyWith(
                            fillColor: Colors.purpleAccent,
                            hintText: "Enter where you password",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password',
                              style: kTitleTextWhite,
                            ),
                            SizedBox(height: 5.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _confirmPassController,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Confirm password input must be filled";
                                  } else if (value != _passController.text) {
                                    return "Password did not match";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: kInputDecoration.copyWith(
                                    hintText: 'Re-insert your password',
                                    fillColor: Colors.purpleAccent,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            SizedBox(height: 30.0),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        InkWell(
                          onTap: () {
                            if (_globalKey.currentState!.validate()) {
                              saveAccount();
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
                                'Register now',
                                style: kTitleTextWhite.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        MyRichText(
                          describe: 'Already have an account? ',
                          linkText: 'Click here',
                          link: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => LoginView()));
                          },
                        ),
                        SizedBox(height: 50.0),
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
