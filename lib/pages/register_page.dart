import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_api/models/login_request_model.dart';
import 'package:flutter_login_api/models/register_request_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../service/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: HexColor("#283B71"),
      body: ProgressHUD(
        child: Form(child: _registerUI(context), key: globalFormKey),
        key: UniqueKey(),
        inAsyncCall: isAPIcallProcess,
        opacity: 0.3,
      ),
    ));
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/kubo.jpg",
                        fit: BoxFit.contain,
                        width: 80,
                      ),
                    )
                  ]),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
              child: Text(
                "Register",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
            FormHelper.inputFieldWidget(context, "username", "Username",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Username cant be empty";
              }
              return null;
            }, (onSaveVal) {
              username = onSaveVal;
            },
                prefixIcon: Icon(Icons.person),
                borderColor: Colors.white,
                borderFocusColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                prefixIconColor: Colors.white,
                showPrefixIcon: true),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FormHelper.inputFieldWidget(
                  context, "password", "Password", (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Password cant be empty";
                }
                return null;
              }, (onSaveVal) {
                password = onSaveVal;
              },
                  borderColor: Colors.white,
                  borderFocusColor: Colors.white,
                  textColor: Colors.white,
                  hintColor: Colors.white.withOpacity(0.7),
                  borderRadius: 10,
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: Colors.white,
                  showPrefixIcon: true,
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      color: Colors.white.withOpacity(0.7),
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FormHelper.inputFieldWidget(context, "email", "Email",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Email cant be empty";
                }
                return null;
              }, (onSaveVal) {
                email = onSaveVal;
              },
                  prefixIcon: Icon(Icons.person),
                  borderColor: Colors.white,
                  borderFocusColor: Colors.white,
                  textColor: Colors.white,
                  hintColor: Colors.white.withOpacity(0.7),
                  borderRadius: 10,
                  prefixIconColor: Colors.white,
                  showPrefixIcon: true),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FormHelper.submitButton("Register", () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  RegisterRequestModel model = RegisterRequestModel(
                      username: username, password: password, email: email);
                  APIService.register(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });

                    if (response.data != null) {
                      FormHelper.showSimpleAlertDialog(
                          context,
                          Config.name,
                          "Registration Success, please Login to the account",
                          "OK", () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      });
                    } else {
                      FormHelper.showSimpleAlertDialog(
                          context, Config.name, response.message, "OK", () {
                        Navigator.pop(context);
                      });
                    }
                  });
                }
              },
                  btnColor: HexColor("#283B71"),
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 10),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "OR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 25, top: 10),
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        children: <TextSpan>[
                      TextSpan(text: "Don't have account? "),
                      TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, "/register");
                            }),
                    ])),
              ),
            ),
          ]),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
