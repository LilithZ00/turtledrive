// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turtledrive/pages/Login.dart';

class Homeuser extends StatefulWidget {
  const Homeuser({super.key});

  @override
  State<Homeuser> createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  String? username; // ตัวแปรสำหรับเก็บชื่อผู้ใช้

  @override
  void initState() {
    super.initState();
    // อ่านชื่อผู้ใช้เมื่อหน้าโหลด
    username = readUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home User'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Home Page Content"),
              if (username != null) // แสดงชื่อผู้ใช้หากมี
                Text("Username: $username"),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Column(
                      children: [
                        Icon(Icons.home, color: Colors.black, size: 30),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Column(
                      children: [
                        Icon(Icons.all_inbox, color: Colors.black, size: 30),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Column(
                      children: [
                        Icon(Icons.exit_to_app, color: Colors.black, size: 30),
                      ],
                    ),
                    onPressed: () => signOut(),
                  ),
                ])));
  }

  void signOut() {
    final storage = GetStorage();
    storage.remove('isLoggedIn'); // ลบสถานะการเข้าสู่ระบบ
    storage.remove('username'); // ลบชื่อผู้ใช้
    Get.off(() => const LoginPage()); // นำทางไปยังหน้า LoginPage
  }

  // อ่านชื่อผู้ใช้จาก GetStorage
  String? readUsername() {
    final storage = GetStorage();
    return storage.read('username');
  }
}
