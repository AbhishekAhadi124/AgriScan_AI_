import 'package:agri_scan/core/utlis/pref_utils.dart';
import 'package:agri_scan/features/profile/controllers/profile_controllers.dart';
import 'package:agri_scan/features/profile/models/user_profile_model.dart'
    as model;
import 'package:agri_scan/features/profile/profile.dart';
import 'package:agri_scan/features/widgets/textfields.dart';
import 'package:agri_scan/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileEdit> {
  bool isEditing = false;
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveProfile() async {
    final Map<String, dynamic> requestData = {
      'name': nameC.text,
      'email': emailC.text,
    };
    profileController
        .submitProfileData(model.UserProfile.fromJson(requestData))
        .then((res) async {
          if (res) {
            // successSnackbar(msg: 'Profile has been updated.');
            await profileController.fetchProfileData();
            Get.find<PrefUtils>().updateUser(
              profileController.profileData.value,
            );
          } else {
            // errorSnackbar(msg: 'Failed to update profile.');
          }
        });
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate to LoginScreen (replaces current screen)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          },
          tooltip: 'Back to Profile',
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.offAllNamed(MyRoutes.loginRoute);
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        buildTextField(
                          keyboardType: TextInputType.name,
                          controller: nameC,
                          labeltext: 'Username',
                          enabled: true,
                          context: context,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7.5),
                    Row(
                      children: [
                        buildTextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailC,
                          labeltext: 'Email',
                          enabled: true,
                          context: context,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (!isEditing)
              ElevatedButton.icon(
                onPressed: () {
                  isEditing = true;
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            else ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: saveProfile,
                      icon: const Icon(Icons.save),
                      label: const Text('Save Changes'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        isEditing = false;
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
