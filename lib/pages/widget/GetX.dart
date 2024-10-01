// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:turtledrive/pages/HomeUser.dart';

class Getx extends StatefulWidget {
  const Getx({super.key});

  @override
  State<Getx> createState() => _GetxState();
}

class _GetxState extends State<Getx> {
  String? username; // ตัวแปรสำหรับเก็บชื่อผู้ใช้

  @override
  void initState() {
    super.initState();
    // เริ่มต้น GetStorage
    GetStorage.init().then((_) {
      // อ่านชื่อผู้ใช้เมื่อเริ่มต้น
      setState(() {
        username = readUsername(); // อ่านชื่อผู้ใช้
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (username != null) // แสดงชื่อผู้ใช้ถ้ามี
              Text("Username: $username"),
            SizedBox(height: 20), // ช่องว่าง
            TextField(
              onChanged: (value) {
                username = value; // อัปเดตค่า username เมื่อมีการเปลี่ยนแปลง
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
            SizedBox(height: 20), // ช่องว่าง
            FilledButton(
              onPressed: () {
                // บันทึกชื่อผู้ใช้ก่อนนำทาง
                if (username != null) {
                  saveUsername(username!); // บันทึกชื่อผู้ใช้

                  // นำทางไปยัง Homeuser
                  Get.to(() => Homeuser());
                }
              },
              child: const Text('Go to Home User'),
            ),
          ],
        ),
      ),
    );
  }

  // บันทึกชื่อผู้ใช้
  void saveUsername(String username) {
    final storage = GetStorage();
    storage.write('username', username);
    log('Username saved: $username'); // ใช้ log แสดงชื่อที่บันทึก
  }

  // อ่านชื่อผู้ใช้
  String? readUsername() {
    final storage = GetStorage();
    return storage.read('username');
  }
}
