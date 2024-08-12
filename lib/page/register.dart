import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:miniprojectapp/page/login.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _addmoneyController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

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
              decoration: BoxDecoration(
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
              decoration: BoxDecoration(
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
                  icon: Icon(Icons.chevron_left, size: 30), // ขนาดของไอคอน
                  color: Color(0xFF471AA0), // สีของ chevron
                  onPressed: () {
                    Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
                  },
                ),
                SizedBox(width: 8), // ช่องว่างระหว่างไอคอนและข้อความ
                Text(
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
            top: 110, // ปรับตำแหน่งตามที่คุณต้องการ
            left: 20, // ปรับตำแหน่งตามที่คุณต้องการ
            child: Row(
              children: [
                Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF471AA0), // สีของข้อความ
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 130), // ช่องว่างระหว่างข้อความและไอคอน
                Container(
                  padding: EdgeInsets.all(8), // ขนาดของวงกลมรอบไอคอน
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFF471AA0), // สีของเส้นวงกลม
                      width: 2, // ความหนาของเส้นวงกลม
                    ),
                  ),
                  child: Icon(
                    Icons.person_add, // ใช้ไอคอน add person
                    size: 70, // ขนาดของไอคอน
                    color: Color(0xFF471AA0), // สีของไอคอน
                  ),
                ),
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
                SizedBox(
                    height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_4_outlined,
                        color: Color(0xFF471AA0)), // ไอคอนด้านซ้าย
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                  ),
                ),
                SizedBox(
                    height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
                TextField(
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_pin_outlined,
                        color: Color(0xFF471AA0)), // ไอคอนด้านซ้าย
                    labelText: 'Fullname',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                  ),
                ),
                SizedBox(
                    height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
                TextField(
                  controller: _addmoneyController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.monetization_on,
                        color: Color(
                            0xFF471AA0)), // เปลี่ยนไอคอนด้านซ้ายเป็นไอคอนสัญลักษณ์เงิน
                    labelText: 'Addmoney',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                  ),
                ),

                SizedBox(
                    height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined,
                        color: Color(0xFF471AA0)), // ไอคอนด้านซ้าย
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                  ),
                ),
                SizedBox(height: 35), // เพิ่มระยะห่างระหว่างกล่องข้อความ
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText, // ใช้สถานะในการควบคุมการมองเห็น
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF471AA0)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF9747FF),
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
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Color(0xFF9747FF),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      // Add your login logic here
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF44CEA8)),
                    ),
                    child: Text('Sign in'),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account ? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: Color(0xFF471AA0),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
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
}
