import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_registration/view/screens/trainee_details_screen.dart';

import '../../constants/constants.dart';

class ViewAllTraineeScreen extends StatefulWidget {
  ViewAllTraineeScreen({super.key});

  @override
  State<ViewAllTraineeScreen> createState() => _ViewAllTraineeScreenState();
}

class _ViewAllTraineeScreenState extends State<ViewAllTraineeScreen> {
  final TextEditingController searchController = TextEditingController();

  final Stream<QuerySnapshot<Map<String, dynamic>>> _traineeCollection =
      FirebaseFirestore.instance
          .collection("Trainee")
          .orderBy("name")
          .snapshots();

  bool isShowUsers = false;

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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: TextField(
              controller: searchController,
              onSubmitted: (_) {
                setState(() {
                  isShowUsers = true;
                });
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: 'Search...',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream: _traineeCollection,
              builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        title: Text(documentSnapshot['name']),
                        subtitle: Text(documentSnapshot['phone']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TraineeDetailScreen(
                                documentSnapshot: documentSnapshot,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
