import 'package:flutter/material.dart';
import 'package:gym_registration/view/screens/home_screen.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100),
                  const Icon(
                    Icons.fitness_center_rounded,
                    size: 80,
                    color: Colors.white70,
                  ),
                  Card(
                    color: Colors.white.withOpacity(0.80),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.black),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock, color: Colors.black),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (nameController.text == "naqeeb" &&
                                    passwordController.text == "123456") {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen(),
                                    ),
                                  );
                                } else {
                                  if (nameController.text == "" ||
                                      passwordController.text == "") {
                                    showToast('Please enter value in textfield',
                                        context: context,
                                        animation: StyledToastAnimation.fade,
                                        reverseAnimation:
                                            StyledToastAnimation.fade,
                                        position: StyledToastPosition.top,
                                        backgroundColor: Colors.purple,
                                        borderRadius:
                                            BorderRadius.circular(50.0));
                                  } else {
                                    showToast('Invalid Credentials ',
                                        context: context,
                                        animation: StyledToastAnimation.fade,
                                        reverseAnimation:
                                            StyledToastAnimation.fade,
                                        position: StyledToastPosition.top,
                                        backgroundColor: Colors.purple,
                                        borderRadius:
                                            BorderRadius.circular(20.0));
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
