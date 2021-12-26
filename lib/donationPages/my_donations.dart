import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({Key? key}) : super(key: key);

  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  final FirebaseFirestore dbRef = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Donations"),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('donations').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (streamSnapshot.data!.docs[index]["doner_id"] ==
                      _auth.currentUser?.uid) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          showBottomSheet(
                              context: context,
                              builder: (context) {
                                return Card(
                                  elevation: 5,
                                  child: Container(
                                    height: 300,
                                    width: double.infinity,
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Item: ${streamSnapshot.data!.docs[index]["donation_item"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            "Type: ${streamSnapshot.data!.docs[index]["donation_type"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            "Description: ${streamSnapshot.data!.docs[index]["donation_desc"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            "Condition: ${streamSnapshot.data!.docs[index]["donation_condition"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            "Address: ${streamSnapshot.data!.docs[index]["doner_add"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            "Doner Name: ${streamSnapshot.data!.docs[index]["doner_name"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(color: Colors.white),
                                          ),
                                          Text(
                                            "Unique code: ${streamSnapshot.data!.docs[index]["unique_code"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        leading: CircleAvatar(
                            radius: 25,
                            child: Icon(
                              streamSnapshot.data!.docs[index]
                                          ["donation_type"] ==
                                      "Perishable"
                                  ? Icons.fastfood
                                  : Icons.no_food,
                            )),
                        title: Text(
                            streamSnapshot.data!.docs[index]["donation_item"]),
                        subtitle: Text(
                          streamSnapshot.data!.docs[index]
                              ["donation_condition"],
                        ),
                        trailing: Text(
                          streamSnapshot.data!.docs[index]["doner_pincode"],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            }
            return const SizedBox();
          }),
    );
  }
}
