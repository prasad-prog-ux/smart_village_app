import 'package:flutter/material.dart';
import 'login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() =>
      _LandingScreenState();
}

class _LandingScreenState
    extends State<LandingScreen>
    with SingleTickerProviderStateMixin {

  double opacity = 0;
  double scale = 0.8;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1;
        scale = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Background Hero Image
          Image.asset(
            "assets/images/hero.png",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.9),
                  Colors.green.shade700
                      .withOpacity(0.85),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Content
          Center(
            child: AnimatedOpacity(
              duration:
              const Duration(milliseconds: 800),
              opacity: opacity,
              child: AnimatedScale(
                duration:
                const Duration(milliseconds: 800),
                scale: scale,
                child: Container(
                  margin:
                  const EdgeInsets.symmetric(
                      horizontal: 30),
                  padding:
                  const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color:
                    Colors.white.withOpacity(0.15),
                    borderRadius:
                    BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min,
                    children: [

                      // Logo
                      Image.asset(
                        "assets/logo.png",
                        height: 100,
                      ),

                      const SizedBox(height: 20),

                      // App Name
                      const Text(
                        "Gram Setu",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight:
                          FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Tagline
                      const Text(
                        "Digital Bridge for Rural India",
                        textAlign:
                        TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                          Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 35),

                      // Button
                      ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.white,
                          foregroundColor:
                          Colors.green,
                          padding:
                          const EdgeInsets
                              .symmetric(
                              horizontal:
                              40,
                              vertical:
                              15),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                                30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const LoginScreen(),
                            ),
                          );
                        },
                        child:
                        const Text(
                            "Get Started"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
