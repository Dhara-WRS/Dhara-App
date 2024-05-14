import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

Future<void> uploadImage(XFile imageFile) async {
  var url = 'http://165.22.255.126:5000/upload';
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers['Content-Type'] = 'multipart/form-data';

  var fileBytes = await imageFile.readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes(
    'image',
    fileBytes,
    filename: 'image.jpg',
    contentType: MediaType('image', 'jpeg'),
  );
  request.files.add(multipartFile);

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print(
        'Image uploaded successfully',
      );
      log("Http Response: ${response.body}");
    } else {
      print('Failed to upload image: ${response.body}');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}

Future<void> uploadCoordinates(Position position) async {
  try {
    var response = await http.post(
      Uri.parse("https://eo50kupab21we1w.m.pipedream.net"),
      headers: {"Content-Type": "application/json"},
      body:
          '{"name": "VIT bhopal university, Kothri Kalan", "Latitude": ${position.latitude}, "Longitude": ${position.longitude}}',
    );

    if (response.statusCode == 200) {
      log("Location name sent successfully!");
    } else {
      log("Failed to send location name. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error sending location: $e");
  }
}
