import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonationListPage extends StatefulWidget {
  const DonationListPage({Key? key}) : super(key: key);

  @override
  _DonationListPageState createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  List<DocumentSnapshot>? data;
  final FirebaseFirestore dbRef = FirebaseFirestore.instance;

  @override
  void initState() {
    CollectionReference donationRef = dbRef.collection("donations");
    donationRef.where("doner_pincode", isEqualTo: "110084").get().then((value) {
      print(value.docs[0].data());
      setState(() {
        data = value.docs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Donation List"),
      ),
      body: data != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                final value = data![index].data();
                return  ListTile(
                  title: Text("dummy"),
                );
              },
              itemCount: data!.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
