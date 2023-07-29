import 'package:flutter/material.dart';
import 'package:gym_registration/constants/constants.dart';
import 'package:gym_registration/view/widgets/total_trainee_card.dart';

import '../widgets/register_trainee_card.dart';
import '../widgets/view_all_trainee_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.fitness_center_rounded,
          color: Colors.black,
        ),
        title: const Text(
          "FJ Power House",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Get fit, and stay healthy with FJ Power House'),
                  TextSpan(
                      text: ' !',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                Expanded(child: TotalTraineeCard()),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RegisterTraineeCard(),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const ViewAllTraineeCard()
          ],
        ),
      ),
    );
  }
}
