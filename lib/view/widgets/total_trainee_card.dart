import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class TotalTraineeCard extends StatelessWidget {
  const TotalTraineeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.people),
          SizedBox(
            height: 4,
          ),
          Text(
            "Total trainee enroled",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Spacer(),
          Text(
            "156",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
