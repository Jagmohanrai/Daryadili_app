import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  TextEditingController donationItem = TextEditingController();
  TextEditingController donationCondition = TextEditingController();
  TextEditingController donationdesc = TextEditingController();
  TextEditingController donername = TextEditingController();
  TextEditingController donerAdd = TextEditingController();
  TextEditingController donationPincode = TextEditingController();

  final FirebaseFirestore dbRef = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  final List<String> _locations = ["Perishable", "Non-Perishable"];
  String? _selectedLocation; // Option 2

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
            DropdownButton(
              hint: const Text('Type of Donation'),
              value: _selectedLocation,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue as String?;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: Text(location),
                  value: location,
                );
              }).toList(),
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
              inputFormatters: [LengthLimitingTextInputFormatter(6)],
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
                var uniqueCode = getRandomString(5);
                print(uniqueCode);
                dbRef.collection("donations").add({
                  "doner_id": _auth.currentUser?.uid,
                  "doner_name": donername.text,
                  "doner_add": donerAdd.text,
                  "doner_pincode": donationPincode.text,
                  "donation_item": donationItem.text,
                  "donation_type": _selectedLocation,
                  "donation_condition": donationCondition.text,
                  "donation_desc": donationdesc.text,
                  "unique_code": uniqueCode,
                  "availability": true
                }).then((value) {
                  dbRef
                      .collection("User")
                      .doc(_auth.currentUser?.uid)
                      .collection("donations")
                      .doc(value.id)
                      .set({"donation": value.id}).then((value) {
                    Navigator.pop(context);
                    print("Donation Noted Succesfully");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Donation Listed Succesfully"),
                      ),
                    );
                  });
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
