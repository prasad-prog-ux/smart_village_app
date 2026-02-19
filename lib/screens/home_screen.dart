import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  spreadRadius: 3,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Icon(Icons.account_circle,
                    size: 80,
                    color: Colors.green),

                SizedBox(height: 15),

                Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5),

                Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.grey),
                ),

                SizedBox(height: 25),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ForgotPasswordScreen()),
                      );
                    },
                    child: Text("Forgot Password?"),
                  ),
                ),

                SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New to app? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignupScreen()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
