import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services package for input formatting
import 'package:image_picker/image_picker.dart';

class Registerdriver extends StatefulWidget {
  const Registerdriver({super.key});

  @override
  State<Registerdriver> createState() => _RegisterdriverState();
}

class _RegisterdriverState extends State<Registerdriver> {
  File? _image; // Variable to hold the selected image
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to validate inputs before registration
  String? _validateInputs() {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _licensePlateController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      return "Please fill in all fields."; // Please fill in all fields
    }

    // Email validation
    if (!_emailController.text.endsWith('@gmail.com')) {
      return "Invalid email format"; // Invalid email format
    }

    // Check if there are characters before @gmail.com
    String email = _emailController.text;
    if (email.indexOf('@gmail.com') <= 0) {
      return "Invalid email format"; // No characters before @gmail.com
    }

    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      return "Passwords don't match"; // Passwords don't match
    }

    // Check if image is selected
    if (_image == null) {
      return "Please select a picture."; // Please select a picture
    }

    // Validate license plate format
    String licensePlate = _licensePlateController.text;
    if (!RegExp(r'^[ก-ฮA-Za-z]\d+$').hasMatch(licensePlate) &&
        !RegExp(r'^[A-Za-z]\d+$').hasMatch(licensePlate)) {
      return "License plate must start with a Thai or English letter followed by digits.";
    }

    return null; // All validations passed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver'),
        backgroundColor: const Color.fromRGBO(226, 219, 191, 1),
      ),
      body: Stack(
        children: [
          // Background color container
          Container(
            color: const Color.fromRGBO(226, 219, 191, 1),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/image/logohaft.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form fields
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Profile Image Selection
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Choose from gallery'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Take a picture'),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color.fromARGB(255, 173, 173, 173),
                      child: _image != null
                          ? ClipOval(
                              child: Image.file(
                                _image!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Username field
                const Text('Username'),
                const SizedBox(height: 8),
                TextField(
                  controller: _usernameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')) // Disallow spaces
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const SizedBox(height: 20),
                // Email field
                const Text('Email'),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')) // Disallow spaces
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const SizedBox(height: 20),
                // Phone number field
const Text('Phone Number'),
const SizedBox(height: 8),
TextField(
  controller: _phoneController,
  keyboardType: TextInputType.number, // Set keyboard type to number
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly, // Allow only digits
    FilteringTextInputFormatter.deny(RegExp(r'\s')) // Disallow spaces
  ],
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white.withOpacity(0.7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
  ),
),

                const SizedBox(height: 20),
                // License Plate field
                const Text('License Plate'),
                const SizedBox(height: 8),
                TextField(
                  controller: _licensePlateController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')), // Disallow spaces
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[ก-ฮA-Za-z0-9]*$'), // Allow Thai letters, English letters, and digits
                    ),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const SizedBox(height: 20),
                // Password field
                const Text('Password'),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')) // Disallow spaces
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const SizedBox(height: 20),
                // Confirm password field
                const Text('Confirm Password'),
                const SizedBox(height: 8),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')) // Disallow spaces
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                const SizedBox(height: 30),
                // Register button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String? validationMessage = _validateInputs();
                      if (validationMessage != null) {
                        // Show error dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text(validationMessage),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Add your registration logic here
                        log("User registered successfully!");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Register (driver)',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
