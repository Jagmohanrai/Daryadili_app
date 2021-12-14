import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  TextEditingController donationItem = TextEditingController();
  TextEditingController donationType = TextEditingController();
  TextEditingController donationCondition = TextEditingController();
  TextEditingController donationdesc = TextEditingController();
  TextEditingController donername = TextEditingController();
  TextEditingController donerAdd = TextEditingController();
  TextEditingController donationPincode = TextEditingController();

  final FirebaseFirestore dbRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Details for Donation"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text("Donation Item Details:",
                style: TextStyle(
                  fontSize: 20,
                )),
            const SizedBox(height: 20),
            TextField(
              controller: donationItem,
              decoration: const InputDecoration(
                labelText: "Donation Item",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: donationType,
              decoration: const InputDecoration(
                labelText: "Type of Donation item",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: donationCondition,
              decoration: const InputDecoration(
                labelText: "Condition of Donation item",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 5,
              controller: donationdesc,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Doner's Personal Details:",
                style: TextStyle(
                  fontSize: 20,
                )),
            const SizedBox(height: 20),
            TextField(
              controller: donername,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: donerAdd,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: donationPincode,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Pincode",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                dbRef.collection("donations").add({
                  "doner_name": donername.text,
                  "doner_add": donerAdd.text,
                  "doner_pincode": donationPincode.text,
                  "donation_item": donationItem.text,
                  "donation_type": donationType.text,
                  "donation_condition": donationCondition.text,
                  "donation_desc": donationdesc.text,
                }).then((value) {
                  Navigator.pop(context);
                  print("Donation Noted Succesfully");
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Make Donation",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
