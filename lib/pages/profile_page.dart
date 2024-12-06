import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController githubController = TextEditingController();

  // Initial profile details
  String email = 'magallanesraymart@gmail.com';
  String phone = '0950 665 3665';
  String address = 'Sagbayan, Bohol, Philippines';
  String github = 'https://github.com/dreadnought2099';

  // To store the original values for cancel functionality
  String originalEmail = '';
  String originalPhone = '';
  String originalAddress = '';
  String originalGithub = '';

  @override
  void initState() {
    super.initState();
    // Store the initial values when the page is loaded
    originalEmail = email;
    originalPhone = phone;
    originalAddress = address;
    originalGithub = github;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Profile',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/RMAGALLANEZ.jpeg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Raymart Magallanes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Cinematographer',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Profile Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            isEditing
                ? _buildEditableProfileDetail('Email:', emailController)
                : _buildProfileDetail('Email:', email),
            isEditing
                ? _buildEditableProfileDetail('Phone:', phoneController)
                : _buildProfileDetail('Phone:', phone),
            isEditing
                ? _buildEditableProfileDetail('Address:', addressController)
                : _buildProfileDetail('Address:', address),
            isEditing
                ? _buildEditableProfileDetail('GitHub:', githubController)
                : _buildProfileDetail('GitHub:', github),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        // Save the new values
                        email = emailController.text;
                        phone = phoneController.text;
                        address = addressController.text;
                        github = githubController.text;
                      }
                      isEditing = !isEditing; // Toggle edit mode
                    });
                  },
                  child: Text(
                    isEditing ? 'Save Profile' : 'Edit Profile',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueAccent),
                  ),
                ),
                if (isEditing) const SizedBox(width: 10),
                if (isEditing)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Revert to original values
                        emailController.text = originalEmail;
                        phoneController.text = originalPhone;
                        addressController.text = originalAddress;
                        githubController.text = originalGithub;
                        isEditing = false; // Toggle to view mode
                      });
                    },
                    child: const Text(
                      'Cancel',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.blueAccent),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableProfileDetail(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your $label',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
