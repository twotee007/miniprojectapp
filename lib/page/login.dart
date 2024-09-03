import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import for TapGestureRecognizer
import 'package:LOTTO168/config/config.dart';
import 'package:LOTTO168/page/admin.dart';
import 'package:LOTTO168/page/home.dart';
import 'package:LOTTO168/request/user_post_req.dart';
import 'package:LOTTO168/response/user_post_res.dart';
import 'register.dart'; // Import your register page
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  String url = '';
  String text = '';
  @override
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Text(
                'LOTTO168',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Revalia', // ใช้ฟอนต์ Revalia
                  color: Color(0xFF471AA0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/img/Lotto.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sign in',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF471AA0),
              ),
            ),
            const SizedBox(
                height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
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
            const SizedBox(height: 35), // เพิ่มระยะห่างระหว่างกล่องข้อความ
            TextField(
              controller: passwordController,
              obscureText: _obscureText, // ใช้สถานะในการควบคุมการมองเห็น
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Color(0xFF471AA0)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF9747FF),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // สลับสถานะการมองเห็น
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
                    vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
              ),
            ),

            Center(
              child: Text(text),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  login();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF44CEA8)),
                ),
                child: const Text('Sign in'),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(
                        color: Color(0xFF471AA0),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const registerPage(),
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
    );
  }

  void login() async {
    showDialog(
      context: context,
      barrierDismissible: false, // ป้องกันไม่ให้ปิดป๊อปอัปด้วยการแตะที่ด้านนอก
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(), // Spinner แสดงสถานะการโหลด
        );
      },
    );

    var model = UserPostReq(
      username: usernameController.text,
      password: passwordController.text,
    );

    try {
      var response = await http.post(
        Uri.parse("$url/users/login"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: userPostReqToJson(model),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<UserPostRes> users = userPostResFromJson(response.body);

        if (users.isNotEmpty) {
          Navigator.pop(context); // ปิดป๊อปอัปเมื่อการเข้าสู่ระบบสำเร็จ

          if (users[0].type == "user") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  uid: users[0].uid,
                ),
              ),
            );
          } else if (users[0].type == "admin") {
            log(users[0].fullname);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminPage(),
              ),
            );
          }
        } else {
          Navigator.pop(context); // ปิดป๊อปอัปเมื่อไม่พบข้อมูลผู้ใช้
          setState(() {
            text = "No user data found";
          });
        }
      } else {
        Navigator.pop(context); // ปิดป๊อปอัปเมื่อการเข้าสู่ระบบไม่สำเร็จ
        setState(() {
          text = "Username or Password Incorrect";
        });
      }
    } catch (err) {
      Navigator.pop(context); // ปิดป๊อปอัปเมื่อเกิดข้อผิดพลาด
      log(err.toString());
      setState(() {
        text = "An error occurred. Please try again.";
      });
    }
  }
}
