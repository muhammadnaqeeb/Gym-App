import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final CollectionReference _traineeCollection =
      FirebaseFirestore.instance.collection("Trainee");
  final CollectionReference _feePaymentCollection =
      FirebaseFirestore.instance.collection("Fee_Payment");

  Future<String> registerTrainee({
    required String name,
    required String phone,
    required bool gender,
    required bool isCardio,
    required int registrationFee,
    required double weight,
    required int fee,
  }) async {
    String res = "some error occur";
    try {
      String traineeID = const Uuid().v4();

      Map<String, dynamic> traineeData = {
        "name": name,
        "phone": phone,
        "dateEnrol": DateTime.now(),
        "gender": gender,
        "isCardio": isCardio,
        "registrationFee": registrationFee,
        "weight": weight,
      };
      Map<String, dynamic> traineefeeData = {
        "traineeID": traineeID,
        "amount_paid": fee,
        "payment_date": DateTime.now(),
      };

      // Add the student with the custom ID to the collection
      await _traineeCollection.doc(traineeID).set(traineeData);

      await _feePaymentCollection.add(traineefeeData);
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addFee({
    required String traineeID,
    required int amountPaid,
  }) async {
    String res = "some error";

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Fee_Payment")
          .where("traineeID", isEqualTo: traineeID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

        // Create a map with the fields you want to update and their new values
        Map<String, dynamic> updatedData = {
          'amount_paid': amountPaid,
          'payment_date': DateTime.now()
        };

        // Perform the update using the update method
        await documentSnapshot.reference.update(updatedData);

        res = "success";
      } else {
        res = "No Doc found error";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
