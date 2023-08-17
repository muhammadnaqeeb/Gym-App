import 'package:flutter/material.dart';
import 'package:gym_registration/view/screens/all_trainee_screen.dart';

import '../../constants/constants.dart';

class ViewAllTraineeCard extends StatelessWidget {
  const ViewAllTraineeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            kBoxShadow,
          ],
        ),
        child: const Column(
          children: [
            Row(
              children: [
                Icon(Icons.all_inclusive_rounded),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "All Trainee",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "This include all the trainee including weight lifting and cardio",
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "see all",
                  style: TextStyle(color: kPrimaryColor),
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.arrow_right_alt_rounded,
                  color: kPrimaryColor,
                  size: 30,
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewAllTraineeScreen(),
          ),
        );
      },
    );
  }
}
