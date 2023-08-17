import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../screens/register_new_trainee_screen.dart';

class RegisterTraineeCard extends StatelessWidget {
  const RegisterTraineeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 140,
        height: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            kBoxShadow,
          ],
        ),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Register a new Trainee",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_circle_right_rounded,
                color: Colors.white,
                size: 30,
              )
            ]),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterNewTraineeScreen(),
          ),
        );
      },
    );
  }
}
