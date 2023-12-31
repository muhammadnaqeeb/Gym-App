import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_registration/constants/extension.dart';
import 'package:gym_registration/controller/firebase/firestore_methods.dart';
import 'package:gym_registration/view/widgets/custom_textfield.dart';
import 'package:gym_registration/view/widgets/primary_button.dart';

import '../../constants/constants.dart';

class RegisterNewTraineeScreen extends StatefulWidget {
  const RegisterNewTraineeScreen({super.key});

  @override
  State<RegisterNewTraineeScreen> createState() =>
      _RegisterNewTraineeScreenState();
}

class _RegisterNewTraineeScreenState extends State<RegisterNewTraineeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController registrationFeeController =
      TextEditingController();
  final TextEditingController feeController = TextEditingController();

  bool isCardio = false;
  bool isLoading = false;
  registerTrainee() async {
    if (nameController.text == "" ||
        weightController.text == "" ||
        phoneController.text == "" ||
        registrationFeeController.text == "" ||
        feeController.text == "") {
      Fluttertoast.showToast(
          msg: 'Please Enter All fields', backgroundColor: kPrimaryColor);

      return;
    }
    if (registrationFeeController.text.contains(".") ||
        feeController.text.contains(".")) {
      Fluttertoast.showToast(
          msg: 'Fee should not be decimal number',
          backgroundColor: kPrimaryColor);
      return;
    }

    setState(() {
      isLoading = true;
    });
    String res = await FirestoreMethods().registerTrainee(
      name: nameController.text.capitalize(),
      phone: phoneController.text,
      gender: true,
      isCardio: isCardio,
      registrationFee: int.parse(registrationFeeController.text),
      weight: double.parse(weightController.text),
      fee: int.parse(feeController.text),
    );
    if (res == "success") {
      Fluttertoast.showToast(
          msg: 'Trainee successfully added', backgroundColor: kPrimaryColor);

      nameController.text = "";
      weightController.text = "";
      phoneController.text = "";
      registrationFeeController.text = "";
      feeController.text = "";
    } else {
      Fluttertoast.showToast(
          msg: "Error occurs $res", backgroundColor: kPrimaryColor);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          )),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter details for new Trainee",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: nameController,
                icon: const Icon(Icons.person_2_rounded),
                label: "Name",
                hintText: "Enter Name",
                obscureText: false,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                controller: weightController,
                icon: const Icon(Icons.monitor_weight),
                label: "Weight",
                hintText: "Enter Weight",
                obscureText: false,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                controller: phoneController,
                icon: const Icon(Icons.numbers_rounded),
                label: "Phone #",
                hintText: "Enter Phone Number",
                obscureText: false,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                controller: registrationFeeController,
                icon: const Icon(Icons.money_rounded),
                label: "Registration Fee",
                hintText: "Registration Fee",
                obscureText: false,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                controller: feeController,
                icon: const Icon(Icons.money_rounded),
                label: "Fee",
                hintText: "Enter 1st month fee amount",
                obscureText: false,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Checkbox(
                      value: isCardio,
                      onChanged: (v) {
                        setState(() {
                          isCardio = v!;
                        });
                      }),
                  const Text("Is Cardio?"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: "Register",
                        onPress: registerTrainee,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
