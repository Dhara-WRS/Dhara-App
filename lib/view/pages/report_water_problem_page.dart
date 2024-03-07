import 'dart:developer';
import 'dart:io';
import 'package:epics_pj/cofig/colors.dart';
import 'package:epics_pj/view/pages/login_page.dart';
import 'package:epics_pj/view/widgets/showMessage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:epics_pj/view/widgets/buttons.dart'; // Import your AppButton widget
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class ReportWaterProblemPage extends StatefulWidget {
  const ReportWaterProblemPage({Key? key}) : super(key: key);

  @override
  _ReportWaterProblemPageState createState() => _ReportWaterProblemPageState();
}

class _ReportWaterProblemPageState extends State<ReportWaterProblemPage> {
  final TextEditingController problemController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  Position? position;
  String? userName;
  String? userUID;

  XFile? _image;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Access FirebaseAuth instance to get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Get current location
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    if (user != null) {
      setState(() {
        userName = user.displayName;
        userUID = user.uid;
      });
    }
  }

  void _reportProblem(BuildContext context) async {
    String problemDescription = problemController.text;
    String contact = contactController.text;

    if (problemDescription.isNotEmpty && contact.isNotEmpty && _image != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      try {
        // Upload the image to Firebase Storage
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('problem_images')
            .child('${DateTime.now()}.jpg');
        UploadTask uploadTask = ref.putFile(File(_image!.path));
        await uploadTask.whenComplete(() async {
          String imageUrl = await ref.getDownloadURL();

          // Add the data to Firestore
          await firestore.collection('/reported_problem/').add({
            'user_uid': userUID,
            'user_name': userName,
            'problem_description': problemDescription,
            'location': GeoPoint(position!.latitude, position!.longitude),
            'contact': contact,
            'image_url': imageUrl,
            'timestamp': FieldValue.serverTimestamp(),
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Problem reported successfully!'),
          ));
        });
      } catch (e) {
        print(e);
        showMessage(e.toString(), context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong! Please try again.'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields and select an image.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _getImage() async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Describe the problem you are facing',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Button to select image
                ElevatedButton(
                  onPressed: _getImage,
                  child: Text('Select Image'),
                ),

                SizedBox(height: 20),
                // Display the selected image
                if (_image != null) Image.file(File(_image!.path)),
                TextFormField(
                  controller: problemController,
                  decoration:
                      InputDecoration(labelText: 'Describe the problem'),
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

                AppButton(
                  text: 'Report Problem',
                  onTap: () => _reportProblem(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
