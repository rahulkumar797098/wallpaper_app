
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase/auth/authentication_helper.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Visibility of password
  bool isVisible = false;

  // Controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmPasswordController = TextEditingController();

  // Instance of AuthService
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    // Dispose controllers when not needed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmPasswordController.dispose();
    super.dispose();
  }

  // Function to handle sign-up
  Future<void> _signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = passwordConfirmPasswordController.text.trim();

    // Check if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Call the sign-up method from AuthService
    final result = await _authService.signUp(email, password);

    if (result == null) {
      // Navigate to LoginScreen upon successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // Show error message if sign-up fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.toString())
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 620,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 600,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                      color: Color(0xff97fbb7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/computer.png",
                              height: 100,
                              width: 200,
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Name Box
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              label: const Text(
                                "Enter Your Name",
                                style: TextStyle(fontSize: 20),
                              ),
                              hintStyle: const TextStyle(fontSize: 25),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xfbf8d581),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.account_circle_sharp,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Email Box
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              label: const Text(
                                "Enter your e-mail",
                                style: TextStyle(fontSize: 20),
                              ),
                              hintStyle: const TextStyle(fontSize: 25),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xfbf8d581),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.email_sharp,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Password
                          TextField(
                            controller: passwordController,
                            obscureText: !isVisible,
                            decoration: InputDecoration(
                              label: const Text(
                                "Password",
                                style: TextStyle(fontSize: 20),
                              ),
                              hintStyle: const TextStyle(fontSize: 25),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xfbf8d581),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 30,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Confirm Password
                          TextField(
                            controller: passwordConfirmPasswordController,
                            obscureText: !isVisible, // Match visibility with password field
                            decoration: InputDecoration(
                              label: const Text(
                                "Confirm Password",
                                style: TextStyle(fontSize: 20),
                              ),
                              hintStyle: const TextStyle(fontSize: 25),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xfbf8d581),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 30,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 100,
                    child: SizedBox(
                      width: 200,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          elevation: 20,
                          side: const BorderSide(width: 1, color: Colors.green),
                          shadowColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 25, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "You have an account?",
                    style: TextStyle(fontSize: 20),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 25, color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
