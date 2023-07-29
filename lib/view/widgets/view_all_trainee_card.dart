import 'package:flutter/material.dart';

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
        child: Column(
          children: [
            Row(
              children: const [
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
            const SizedBox(
              height: 10,
            ),
            const Text(
              "This include all the trainee including weight lifting and cardio",
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
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
        print('View all trainee click');
      },
    );
  }
}
