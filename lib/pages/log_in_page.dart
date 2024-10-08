import 'package:flutter/material.dart';
import 'package:marvel_lati/helper/const.dart';
import 'package:marvel_lati/pages/home_page.dart';
import 'package:marvel_lati/pages/register_page.dart';
import 'package:marvel_lati/providers/auth_provider.dart';
import 'package:marvel_lati/widgets/main_button.dart';
import 'package:marvel_lati/widgets/text_clickable.dart';
import 'package:marvel_lati/widgets/text_form.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 120),
                    Text(
                      'Login here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: red,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Welcome back you\'ve\n been missed!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextForm(
                        controller: _phoneController,
                        labelText: "Phone",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Phone number must be at least 10 characters';
                          }
                          return null;
                        }),
                    const SizedBox(height: 29),
                    TextForm(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }

                        return null;
                      },
                      controller: _passwordController,
                      labelText: "Password",
                      obscure: _obscureText,
                    ),
                    const SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextClickable(
                          text: "Forgot your password?",
                          function: () {},
                          color: red,
                        )),
                    const SizedBox(height: 25),
                    Mainbutton(
                        text: 'Sign in',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<AuthentProvider>(context, listen: false)
                                .login({
                              'phone': _phoneController.text,
                              'password': _passwordController.text
                            }).then((value) {
                              if (value[0]) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(value[1]['message'])));
                              }
                            });
                          }
                        }),
                    const SizedBox(height: 40),
                    TextClickable(
                        text: 'Create new account',
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPages()));
                        }),
                    const SizedBox(height: 30),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
