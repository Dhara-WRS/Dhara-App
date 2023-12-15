import 'package:epics_pj/cofig/colors.dart';
import 'package:epics_pj/view/widgets/showMessage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:epics_pj/view/widgets/buttons.dart'; // Import your AppButton widget

class ReportWaterProblemPage extends StatefulWidget {
  const ReportWaterProblemPage({Key? key}) : super(key: key);

  @override
  _ReportWaterProblemPageState createState() => _ReportWaterProblemPageState();
}

class _ReportWaterProblemPageState extends State<ReportWaterProblemPage> {
  final TextEditingController problemController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String? userName;
  String? userUID;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Access FirebaseAuth instance to get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userName = user.displayName;
        userUID = user.uid;
      });
    }
  }

  void _reportProblem(BuildContext context) async {
    String problemDescription = problemController.text;
    String location = locationController.text;
    String contact = contactController.text;

    if (problemDescription.isNotEmpty &&
        location.isNotEmpty &&
        contact.isNotEmpty) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Add the data to Firestore
      try {
        await firestore.collection('/reported_problem/').add({
          'user_uid': userUID,
          'user_name': userName,
          'problem_description': problemDescription,
          'location': location,
          'contact': contact,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        print(e);
        showMessage(e.toString(), context);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Problem reported successfully!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text('Report a Problem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              Text(
                'Describe the problem you are facing',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: problemController,
                decoration: InputDecoration(labelText: 'Describe the problem'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a problem description.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact Information'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact information.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Replace ElevatedButton with your AppButton
              AppButton(
                text: 'Report Problem',
                onTap: () => _reportProblem(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
