import 'package:flutter/material.dart';
import 'package:sample2/Screens/Dict/dict.dart';
import 'package:sample2/Screens/Login/login_screen.dart';
import 'package:sample2/Screens/Signup/components/background.dart';
import 'package:sample2/Screens/Signup/components/or_divider.dart';
import 'package:sample2/Screens/Signup/components/social_icon.dart';
import 'package:sample2/components/already_have_an_account_acheck.dart';
import 'package:sample2/components/rounded_button.dart';
import 'package:sample2/components/rounded_input_field.dart';
import 'package:sample2/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample2/authmodule/services/auth.dart';
import 'package:sample2/authmodule/shared/loading.dart';
import 'package:validators/validators.dart';
// class SignUpScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(),
//     );
//   }
// }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  // final Function toggleView;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : Scaffold(
            body: Background(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "SIGNUP",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SvgPicture.asset(
                        "assets/icons/signup.svg",
                        height: size.height * 0.35,
                      ),
                      RoundedInputField(
                        hintText: "Your Email",
                        validator: (val) =>
                            !isEmail(val!) ? 'Enter an valid email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      RoundedPasswordField(
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      RoundedButton(
                        text: "SIGNUP",
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'please supply a valid email';
                              });
                            } else {
                              setState(() => loading = false);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const DictPage();
                                  },
                                ),
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginScreen();
                              },
                            ),
                          );
                        },
                      ),
                      OrDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocalIcon(
                            iconSrc: "assets/icons/facebook.svg",
                            press: () {},
                          ),
                          SocalIcon(
                            iconSrc: "assets/icons/twitter.svg",
                            press: () {},
                          ),
                          SocalIcon(
                            iconSrc: "assets/icons/google-plus.svg",
                            press: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
