import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_registration/view/widgets/primary_button.dart';
import 'package:intl/intl.dart';

class TraineeDetailScreen extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const TraineeDetailScreen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text('Atribute',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('Name')),
                  DataCell(Text("${documentSnapshot['name']}")),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Phone #')),
                  DataCell(Text("${documentSnapshot['phone']}")),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Cardio')),
                  DataCell(Text(documentSnapshot['isCardio'] ? "Yes" : "No")),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Gender')),
                  DataCell(
                      Text(documentSnapshot['gender'] ? "Male" : "Femail")),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Weight')),
                  DataCell(Text("${documentSnapshot['weight']}")),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Registration Fee')),
                  DataCell(Text("${documentSnapshot['registrationFee']}")),
                ]),
                DataRow(cells: [
                  const DataCell(Text('Date of Enroll')),
                  DataCell(
                    Text(
                      DateFormat.yMMMd().format(
                        documentSnapshot['dateEnrol'].toDate(),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Last Fee Payment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Fee_Payment")
                  .where("traineeID", isEqualTo: documentSnapshot.id)
                  .snapshots(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      final DocumentSnapshot documentSnapshotPayment =
                          streamSnapshot.data!.docs[index];

                      return ListTile(
                        title: Text(
                          DateFormat.yMMMd().format(
                            documentSnapshotPayment['payment_date'].toDate(),
                          ),
                        ),
                        subtitle:
                            Text("${documentSnapshotPayment['amount_paid']}"),
                      );
                    }),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: PrimaryButton(
                  text: "Add fee",
                  onPress: () {},
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
