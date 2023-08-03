import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_registration/view/screens/home_screen.dart';
import 'package:gym_registration/view/widgets/primary_button.dart';

import '../../constants/constants.dart';

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
                image: AssetImage('assets/images/login.jpg'),
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
                  // const Icon(
                  //   Icons.fitness_center_rounded,
                  //   size: 80,
                  //   color: Colors.white70,
                  // ),
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
                            child: PrimaryButton(
                                text: "Login",
                                onPress: () {
                                  if (nameController.text == "naqeeb" &&
                                      passwordController.text == "123456") {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const HomeScreen(),
                                      ),
                                    );
                                  } else {
                                    if (nameController.text == "" ||
                                        passwordController.text == "") {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Please enter value in textfield',
                                          backgroundColor: kPrimaryColor);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Invalid Credentials ',
                                          backgroundColor: kPrimaryColor);
                                    }
                                  }
                                }),
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
