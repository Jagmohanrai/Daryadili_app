import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DonationListPage extends StatefulWidget {
  const DonationListPage({Key? key}) : super(key: key);

  @override
  _DonationListPageState createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  List<DocumentSnapshot>? data;
  final FirebaseFirestore dbRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Available Donation List"),
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
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (streamSnapshot.hasData) {
                        return streamSnapshot.data!.docs[index]
                                    ["availability"] ==
                                true
                            ? Card(
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Item: ${streamSnapshot.data!.docs[index]["donation_item"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      "Type: ${streamSnapshot.data!.docs[index]["donation_type"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      "Description: ${streamSnapshot.data!.docs[index]["donation_desc"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      "Condition: ${streamSnapshot.data!.docs[index]["donation_condition"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      "Address: ${streamSnapshot.data!.docs[index]["doner_add"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Text(
                                                      "Doner Name: ${streamSnapshot.data!.docs[index]["doner_name"]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    Center(
                                                      child: InkWell(
                                                        onTap: () {
                                                          dbRef
                                                              .collection(
                                                                  "donations")
                                                              .doc(
                                                                  streamSnapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .id)
                                                              .update({
                                                            "availability":
                                                                false
                                                          }).then((value) {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 50,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                          child: const Text(
                                                            "Want Donation",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
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
                                  title: Text(streamSnapshot.data!.docs[index]
                                      ["donation_item"]),
                                  subtitle: Text(
                                    streamSnapshot.data!.docs[index]
                                        ["donation_condition"],
                                  ),
                                  trailing: Text(
                                    streamSnapshot.data!.docs[index]
                                        ["doner_pincode"],
                                  ),
                                ),
                              )
                            : const SizedBox();
                      } else {
                        return const SizedBox();
                      }
                    }),
              );
            } else {
              return const SizedBox();
            }
          },
        )
        //  data != null
        //     ? ListView.builder(
        //         itemBuilder: (context, index) {
        //           final value = data![index].data();
        //           return  const ListTile(
        //             title: Text("dummy"),
        //           );
        //         },
        //         itemCount: data!.length,
        //       )
        //     : const Center(
        //         child: CircularProgressIndicator(),
        //       ),
        );
  }
}
