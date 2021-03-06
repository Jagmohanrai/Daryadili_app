import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daryadili/donationPages/donation_list_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'donationPages/my_donations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _dbref = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _dbref.collection("User").doc(_auth.currentUser!.uid).get().then((value) {
      setState(() {
        userData = value.data();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (userData?["user"] == "Doner(Want to Donate)") {
      return const Scaffold(
        body: MyDonations(),
      );
    } else if (userData?["user"] == "NGO(Looking for Donations)") {
      return const Scaffold(body: DonationListPage());
    } else {
      return const Scaffold(body: SizedBox());
    }
    // return Scaffold(
    //   drawer: Drawer(
    //     child: ListView(
    //       children: [
    //         const SizedBox(
    //           height: 15,
    //         ),
    //         Card(
    //           child: ListTile(
    //             onTap: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => const MyDonations()));
    //             },
    //             leading: const CircleAvatar(
    //               child: Icon(Icons.request_quote),
    //             ),
    //             title: const Text("My Donations"),
    //           ),
    //         ),
    //         Card(
    //           child: ListTile(
    //             onTap: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => RequestedDonations()));
    //             },
    //             leading: CircleAvatar(
    //               child: Icon(Icons.accessibility_new_sharp),
    //             ),
    //             title: Text("Requested Donations"),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    //   appBar: AppBar(
    //     title: const Text("DaryaDili"),
    //     actions: [
    //       IconButton(
    //         onPressed: () {
    //           _auth.signOut();
    //           Navigator.pushReplacement(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => const LoginPage(),
    //             ),
    //           );
    //         },
    //         icon: const Icon(
    //           Icons.logout,
    //         ),
    //       ),
    //     ],
    //   ),
    //   body: Center(
    //     child: userData != null
    //         ? Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => const DonationPage(),
    //                     ),
    //                   );
    //                 },
    //                 child: Container(
    //                   alignment: Alignment.center,
    //                   height: 150,
    //                   width: 300,
    //                   decoration: BoxDecoration(
    //                     color: Colors.blue,
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: const [
    //                       Text(
    //                         "Want to Donate Something",
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(
    //                           fontSize: 20,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 15,
    //                       ),
    //                       Text(
    //                         "For Doners: \n(Resturants and individuals)",
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(
    //                           fontSize: 16,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 15,
    //               ),
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => const DonationListPage(),
    //                     ),
    //                   );
    //                 },
    //                 child: Container(
    //                   alignment: Alignment.center,
    //                   height: 150,
    //                   width: 300,
    //                   decoration: BoxDecoration(
    //                     color: Colors.blue,
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: const [
    //                       Text(
    //                         "Looking for donation",
    //                         textAlign: TextAlign.left,
    //                         style: TextStyle(
    //                           fontSize: 20,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 15,
    //                       ),
    //                       Text(
    //                         "For NGOs\n And Other Helping Orgs",
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(
    //                           fontSize: 16,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           )
    //         : const CircularProgressIndicator(),
    //   ),
    // );
  }
}
