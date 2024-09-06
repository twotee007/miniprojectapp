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

class _registerPageState extends State<registerPage> {
  var usernameController = TextEditingController();
  var fullnameController = TextEditingController();
  var addmoneyController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _obscureText = true;
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
          Positioned(
            top: -70,
            right: 15,
            child: Container(
              width: 142,
              height: 142,
              decoration: const BoxDecoration(
                color: Color(0xFF471AA0), // สีม่วงเข้ม
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
                color: Color(0xFFC17E7E), // สีชมพูอ่อน
                shape: BoxShape.circle,
              ),
            ),
          ),

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

          // ข้อความ Sign up พร้อมไอคอน
          Positioned(
            top: 130, // ปรับตำแหน่งตามที่คุณต้องการ
            left: 20, // ปรับตำแหน่งตามที่คุณต้องการ
            child: Row(
              children: [
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF471AA0), // สีของข้อความ
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ช่องว่างระหว่างข้อความและไอคอน
              ],
            ),
          ),

          // เนื้อหาหลักของหน้า
          Positioned(
            top: 200, // ปรับตำแหน่งเริ่มต้นของกล่องข้อความ
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                const SizedBox(
                    height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
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
                    height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
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
                    height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
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
                const SizedBox(height: 25), // เพิ่มระยะห่างระหว่างกล่องข้อความ
                TextField(
                  controller: passwordController,
                  obscureText: _obscureText, // ใช้สถานะในการควบคุมการมองเห็น
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF471AA0)),
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
        ],
      ),
    );
  }

  void signup() {
    setState(() {
      if (usernameController.text.isEmpty ||
          fullnameController.text.isEmpty ||
          addmoneyController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        text = "กรุณากรอกข้อมูลให้ครบทุกช่อง";
        return;
      } else if (!RegExp(r'^[0-9]+$').hasMatch(addmoneyController.text)) {
        // ตรวจสอบว่า addmoneyController มีแต่ตัวเลขเท่านั้น
        text = "กรุณากรอกจำนวนเงินเป็นตัวเลขเท่านั้น";
        return;
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
          .hasMatch(emailController.text)) {
        // ถ้ารูปแบบอีเมลไม่ถูกต้อง
        text = "กรุณากรอก Email ให้ถูกต้อง";
      } else {
        var model = RegisterPostReq(
          username: usernameController.text,
          password: passwordController.text,
          fullname: fullnameController.text,
          wallet: int.parse(addmoneyController.text), // Convert String to int
          email: emailController.text,
          img:
              "https://e7.pngegg.com/pngimages/340/946/png-clipart-avatar-user-computer-icons-software-developer-avatar-child-face-thumbnail.png",
        );
        http
            .post(
          Uri.parse('$url/users/adduser'),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: registerPostReqToJson(model),
        )
            .then((response) {
          if (response.statusCode == 201) {
            // Registration successful
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          } else if (response.statusCode == 409) {
            // User already exists (HTTP status 409 Conflict)
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('การลงทะเบียนล้มเหลว'),
                  content: const Text(
                      'ชื่อผู้ใช้นี้มีอยู่แล้วในระบบ กรุณาใช้ชื่อผู้ใช้อื่น.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('ตกลง'),
                    ),
                  ],
                );
              },
            );
          } else {
            // Handle other status codes
            log('Error: ${response.statusCode}');
          }
        }).catchError((err) {
          log(err.toString());
        });
      }
    });
  }
}
