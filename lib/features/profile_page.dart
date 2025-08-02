import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String token;

  const ProfilePage({super.key, required this.token});
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String role = "";
  String country = "";
  String gender = "";
  bool _isEditing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  /// اللي بتعمل fetch لداتا اليوزر
  Future<void> _loadProfileData() async {
    final url = Uri.parse(
      "https://medease-server.up.railway.app/api/users/one",
    );
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );

    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final data = body['data']; // 🟰 خدت الداتا الحقيقية من جوة

      setState(() {
        nameController.text = data["name"] ?? "";
        role = data["role"] ?? "";
        country = data["country"] ?? "";
        phoneController.text = data["phone"] ?? "";
        gender = data["gender"] ?? "";
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("profile data error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.cancel : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(nameController.text, style: _boldTextStyle),
                      Text(role, style: _lightTextStyle),
                      SizedBox(height: 20),
                      _buildEditableField(
                        "User name",
                        nameController,
                        _isEditing,
                      ),
                      _buildProfileField("Country", country),
                      _buildEditableField(
                        "Phone number",
                        phoneController,
                        _isEditing,
                      ),
                      _buildProfileField("Gender", gender),
                      SizedBox(height: 20),
                      Image.network(
                        "https://res.cloudinary.com/dweffiohi/image/upload/v1745583748/wn6wqxmsalbweclrngrn.jpg",
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        controller: TextEditingController(text: value),
      ),
    );
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller,
    bool isEditing,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: !isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  static const TextStyle _boldTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle _lightTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );
}
