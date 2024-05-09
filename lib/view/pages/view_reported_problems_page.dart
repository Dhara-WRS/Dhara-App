import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epics_pj/cofig/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaterProblemsPage extends StatefulWidget {
  const WaterProblemsPage({Key? key}) : super(key: key);

  @override
  _WaterProblemsPageState createState() => _WaterProblemsPageState();
}

class _WaterProblemsPageState extends State<WaterProblemsPage> {
  late Stream<QuerySnapshot> _waterProblemsStream;

  @override
  void initState() {
    super.initState();
    _waterProblemsStream =
        FirebaseFirestore.instance.collection('reported_problem').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Problems'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _waterProblemsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No water problems found.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              GeoPoint? location = data['location'] as GeoPoint?;
              print(location?.latitude);

              // You can build and return a custom card widget here`
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: AppColor.primary.withOpacity(.3),
                  title: Text(data['problem_description'] ?? ''),
                  subtitle: Text(location != null
                      ? 'Latitude: ${location.latitude}, Longitude: ${location.longitude}'
                      : ''),
                  // Inside the onTap handler of ListTile
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Water Problem Details'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(data['image_url']),
                                SizedBox(height: 10),
                                Text(
                                    'Description: ${data['problem_description']}'),

                                // Add other details like image and geo location here
                                Text(
                                    'Reported on: ${DateFormat.yMMMMd().add_jms().format(data['timestamp'].toDate())}'),
                                Text('Reported by: ${data['user_name']}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
