import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turtledrive/pages/HomeUser.dart'; // Import หน้า HomeUser
import 'package:turtledrive/pages/Login.dart'; // Import หน้า Login

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets binding
  await GetStorage.init(); // Initialize GetStorage

  final storage = GetStorage();
  final isLoggedIn = storage.read('isLoggedIn') ?? false; // ตรวจสอบสถานะเข้าสู่ระบบ

  runApp(MyApp(isLoggedIn: isLoggedIn)); // ส่งสถานะไปที่ MyApp
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: isLoggedIn ? Homeuser() : LoginPage(), // ถ้าเข้าสู่ระบบแล้วไปหน้า Homeuser
    );
  }
}

