import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_registration/constants/constants.dart';
import 'package:gym_registration/controller/firebase/firestore_methods.dart';
import 'package:gym_registration/view/widgets/primary_button.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class TraineeDetailScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const TraineeDetailScreen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<TraineeDetailScreen> createState() => _TraineeDetailScreenState();
}

class _TraineeDetailScreenState extends State<TraineeDetailScreen> {
  final TextEditingController feeController = TextEditingController();

  bool isLoading = false;

  addFee() async {
    setState(() {
      isLoading = true;
    });
    Navigator.pop(context);
    String res = await FirestoreMethods().addFee(
        traineeID: widget.documentSnapshot.id,
        amountPaid: int.parse(feeController.text));

    if (res == "success") {
      Fluttertoast.showToast(
        msg: "Fee Updated Successfully!, Now Share it to Whatsapp",
        backgroundColor: kPrimaryColor,
      );
    } else {
      Fluttertoast.showToast(
        msg: "ERROR! $res",
        backgroundColor: kPrimaryColor,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
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
                    DataCell(Text("${widget.documentSnapshot['name']}")),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Phone #')),
                    DataCell(Text("${widget.documentSnapshot['phone']}")),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Cardio')),
                    DataCell(Text(
                        widget.documentSnapshot['isCardio'] ? "Yes" : "No")),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Gender')),
                    DataCell(Text(
                        widget.documentSnapshot['gender'] ? "Male" : "Femail")),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Weight')),
                    DataCell(Text("${widget.documentSnapshot['weight']}")),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Registration Fee')),
                    DataCell(
                        Text("${widget.documentSnapshot['registrationFee']}")),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Date of Enroll')),
                    DataCell(
                      Text(
                        DateFormat.yMMMd().format(
                          widget.documentSnapshot['dateEnrol'].toDate(),
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
            SizedBox(
              height: 100,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Fee_Payment")
                    .where("traineeID", isEqualTo: widget.documentSnapshot.id)
                    .snapshots(),
                builder:
                    ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                          trailing: IconButton(
                              onPressed: () {
                                String payID = const Uuid().v4();
                                String dateOfFeePay = DateFormat.yMMMd().format(
                                  documentSnapshotPayment['payment_date']
                                      .toDate(),
                                );
                                Share.share(
                                    '*FJ Power House*\n \n*Pay ID:* $payID\n*Name:* ${widget.documentSnapshot['name']} \n*Amount*: ${documentSnapshotPayment['amount_paid']}\n*Date:* $dateOfFeePay');
                              },
                              icon: const Icon(Icons.share)),
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
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: PrimaryButton(
                          text: "Add fee",
                          onPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Add Fee'),
                                    content: TextField(
                                      controller: feeController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Amount",
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    actions: <Widget>[
                                      MaterialButton(
                                        color: kPrimaryColor,
                                        textColor: Colors.white,
                                        onPressed: addFee,
                                        child: const Text('ADD'),
                                      ),
                                    ],
                                  );
                                });
                          },
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
      ),
    );
  }
}
