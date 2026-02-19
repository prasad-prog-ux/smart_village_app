  import 'package:flutter/material.dart';

  class ForgotPasswordScreen extends StatefulWidget {
    const ForgotPasswordScreen({super.key});

    @override
    State<ForgotPasswordScreen> createState() =>
        _ForgotPasswordScreenState();
  }

  class _ForgotPasswordScreenState
      extends State<ForgotPasswordScreen> {

    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return "Email required";
      }
      final regex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
      if (!regex.hasMatch(value)) {
        return "Enter valid email";
      }
      return null;
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [

            Image.asset(
              "assets/images/hero.png",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.9),
                    Colors.green.shade700.withOpacity(0.85),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            SafeArea(
              child: Stack(
                children: [

                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  Center(
                    child: Container(
                      width: 340,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius:
                        BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.25),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [

                            const Text(
                              "Reset Password",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.bold),
                            ),

                            const SizedBox(height: 20),

                            TextFormField(
                              controller:
                              emailController,
                              validator:
                              validateEmail,
                              decoration:
                              _inputDecoration(
                                  "Email"),
                            ),

                            const SizedBox(height: 25),

                            ElevatedButton(
                              style:
                              _buttonStyle(),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Reset Link Sent"),
                                    ),
                                  );

                                  Future.delayed(const Duration(seconds: 1), () {
                                    Navigator.pop(context);
                                  });
                                }
                              },

                              child: const Text(
                                  "Send Reset Link"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    InputDecoration _inputDecoration(String label) {
      return InputDecoration(
        filled: true,
        fillColor: Colors.green.shade50,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide:
          const BorderSide(color: Colors.green, width: 2),
        ),
      );
    }

    ButtonStyle _buttonStyle() {
      return ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade700,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 6,
      );
    }
  }
