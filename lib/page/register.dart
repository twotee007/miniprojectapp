import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:LOTTO168/config/config.dart';
import 'package:LOTTO168/page/login.dart';
import 'package:LOTTO168/request/register_post_req.dart';
import 'package:http/http.dart' as http;

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  _registerPageState createState() => _registerPageState();
}

class BackgroundCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Circles
        Positioned(
          top: -70,
          right: 15,
          child: Container(
            width: 142,
            height: 142,
            decoration: const BoxDecoration(
              color: Color(0xFF471AA0), // Dark Purple
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -15,
          right: -65,
          child: Container(
            width: 142,
            height: 142,
            decoration: const BoxDecoration(
              color: Color(0xFFC17E7E), // Light Pink
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class _registerPageState extends State<registerPage> {
  var usernameController = TextEditingController();
  var fullnameController = TextEditingController();
  var addmoneyController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool _obscureTextPassword = true; // สำหรับช่อง Password
  bool _obscureTextConfirmPassword = true; // สำหรับช่อง Confirm Password

  String text = '';
  String url = '';
  void initState() {
    super.initState();
    Configuration.getConfig().then(
      (value) {
        log(value['apiEndPoint']);
        url = value['apiEndPoint'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // วงกลมพื้นหลัง
          BackgroundCircles(),
          // ปุ่ม Back พร้อมข้อความ
          Positioned(
            top: 40, // ตำแหน่งเริ่มต้น
            left: 10, // ตำแหน่งเริ่มต้น
            child: Row(
              children: [
                IconButton(
                  icon:
                      const Icon(Icons.chevron_left, size: 30), // ขนาดของไอคอน
                  color: const Color(0xFF471AA0), // สีของ chevron
                  onPressed: () {
                    Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
                  },
                ),

                const SizedBox(width: 8), // ช่องว่างระหว่างไอคอนและข้อความ
                const Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF471AA0), // สีของข้อความ
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // ใช้ SingleChildScrollView เพื่อให้เลื่อนเนื้อหาได้
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF471AA0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                        height:
                            25), // ระยะห่างระหว่างหัวข้อและกล่องข้อความ // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_4_outlined,
                            color: Color(0xFF471AA0)), // ไอคอนด้านซ้าย
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                      ),
                    ),
                    const SizedBox(
                        height:
                            25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
                    TextField(
                      controller: fullnameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_pin_outlined,
                            color: Color(0xFF471AA0)), // ไอคอนด้านซ้าย
                        labelText: 'Fullname',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                      ),
                    ),
                    const SizedBox(
                        height:
                            25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
                    TextField(
                      controller: addmoneyController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.monetization_on,
                            color: Color(
                                0xFF471AA0)), // เปลี่ยนไอคอนด้านซ้ายเป็นไอคอนสัญลักษณ์เงิน
                        labelText: 'Addmoney',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            6), // กำหนดให้ใส่ได้ไม่เกิน 6 ตัวอักษร
                      ],
                    ),

                    const SizedBox(
                        height:
                            25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Color(0xFF471AA0)), // ไอคอนด้านซ้าย
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: passwordController,
                      obscureText:
                          _obscureTextPassword, // ใช้สถานะในการควบคุมการมองเห็น
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFF471AA0)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFF9747FF),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextPassword =
                                  !_obscureTextPassword; // สลับสถานะการมองเห็น
                            });
                          },
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ), // เพิ่มระยะห่างภายในกล่องข้อความ
                      ),
                    ),
                    const SizedBox(
                        height: 25), // เพิ่มระยะห่างระหว่างกล่องข้อความ
                    TextField(
                      controller:
                          confirmPasswordController, // ใช้ confirmPasswordController
                      obscureText:
                          _obscureTextConfirmPassword, // ใช้สถานะในการควบคุมการมองเห็น
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFF471AA0)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureTextConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFF9747FF),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextConfirmPassword =
                                  !_obscureTextConfirmPassword; // สลับสถานะการมองเห็น
                            });
                          },
                        ),
                        labelText:
                            'Confirm Password', // เปลี่ยนเป็น Confirm Password
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Color(0xFF9747FF),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ), // เพิ่มระยะห่างภายในกล่องข้อความ
                      ),
                    ),

                    const SizedBox(height: 10),
                    Center(
                      child: Text(text),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          signup();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF44CEA8)),
                        ),
                        child: const Text('Sign in'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account ? ",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign in',
                              style: const TextStyle(
                                color: Color(0xFF471AA0),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, bool>> checkUserExists(
      String username, String email) async {
    try {
      final response = await http.post(
        Uri.parse('$url/users/check'), // Endpoint สำหรับการตรวจสอบความซ้ำซ้อน
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode({'username': username, 'email': email}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return {
          'usernameExists': result['usernameExists'] ?? false,
          'emailExists': result['emailExists'] ?? false,
        };
      } else {
        log('Error: ${response.statusCode}');
        return {'usernameExists': false, 'emailExists': false};
      }
    } catch (err) {
      log(err.toString());
      return {'usernameExists': false, 'emailExists': false};
    }
  }

  void signup() async {
    // ตรวจสอบข้อมูลก่อนการสมัคร
    if (usernameController.text.isEmpty ||
        fullnameController.text.isEmpty ||
        addmoneyController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      setState(() {
        text = "กรุณากรอกข้อมูลให้ครบทุกช่อง";
      });
      return;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(addmoneyController.text)) {
      setState(() {
        text = "กรุณากรอกจำนวนเงินเป็นตัวเลขเท่านั้น";
      });
      return;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      setState(() {
        text = "กรุณากรอก Email ให้ถูกต้อง";
      });
      return;
    } else if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        text = "รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน";
      });
      return;
    }

    // แสดง spinner รอผลการตรวจสอบข้อมูลซ้ำซ้อน
    showDialog(
      context: context,
      barrierDismissible: false, // ป้องกันการปิดป๊อปอัป
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(), // Spinner รอผลการโหลด
        );
      },
    );

    // เรียกใช้ฟังก์ชันตรวจสอบความซ้ำซ้อน
    Map<String, bool> checkResults;

    try {
      checkResults =
          await checkUserExists(usernameController.text, emailController.text);
    } catch (e) {
      Navigator.of(context).pop(); // ปิด spinner เมื่อมีข้อผิดพลาด
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'เกิดข้อผิดพลาดในการตรวจสอบข้อมูล.',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.of(context).pop(); // ปิด spinner หลังตรวจสอบข้อมูลเสร็จ

    if (checkResults['usernameExists'] == true) {
      setState(() {
        text = "ชื่อผู้ใช้นี้มีอยู่แล้วในระบบ";
      });
      return;
    } else if (checkResults['emailExists'] == true) {
      setState(() {
        text = "อีเมลนี้มีอยู่แล้วในระบบ กรุณาใช้ email อื่น";
      });
      return;
    }

    // สร้างโมเดลข้อมูลสำหรับการสมัคร
    var model = RegisterPostReq(
      username: usernameController.text,
      password: passwordController.text,
      fullname: fullnameController.text,
      wallet: int.parse(addmoneyController.text), // Convert String to int
      email: emailController.text,
      img:
          "https://e7.pngegg.com/pngimages/340/946/png-clipart-avatar-user-computer-icons-software-developer-avatar-child-face-thumbnail.png",
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(), // Spinner แสดงสถานะการโหลด
        );
      },
    );

    try {
      final response = await http.post(
        Uri.parse('$url/users/adduser'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: registerPostReqToJson(model),
      );

      Navigator.of(context).pop(); // ปิด Dialog การโหลด

      if (response.statusCode == 201) {
        // Registration successful
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else {
        // Handle other status codes
        log('Error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'เกิดข้อผิดพลาด กรุณาลองอีกครั้ง.',
              style: TextStyle(color: Colors.red),
            ),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (err) {
      Navigator.of(context).pop(); // ปิด Dialog การโหลด
      log(err.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'เกิดข้อผิดพลาดในการเชื่อมต่อกับเซิร์ฟเวอร์.',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
