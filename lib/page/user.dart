import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:miniprojectapp/config/config.dart';
import 'package:miniprojectapp/page/Widget.dart';
import 'package:miniprojectapp/page/home.dart';
import 'package:miniprojectapp/page/login.dart';
import 'package:miniprojectapp/page/lotto.dart';
import 'package:miniprojectapp/page/wallet.dart';
import 'package:http/http.dart' as http;
import 'package:miniprojectapp/response/useruid_get_res.dart';

class UserPage extends StatefulWidget {
  int uid = 0;
  UserPage({super.key, required this.uid});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String activePage = 'user'; // Track the active page
  List<UseruidGetRes> usergetRes = [];
  late Future<void> loadData;
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController fullnameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    log(widget.uid.toString());
    super.initState();
    loadData = loadDataAstnc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Blur Layer
          Positioned.fill(
            child: Stack(
              children: [
                // Dark Purple Circle (adjusted position)
                Positioned(
                  top: 10,
                  left: -30,
                  child: Container(
                    width: 299.87,
                    height: 293.07,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF471AA0), // Dark purple
                    ),
                  ),
                ),
                // Light Purple Circle
                Positioned(
                  top: 110,
                  left: 110,
                  child: Container(
                    width: 332.67,
                    height: 325.13,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBB84E8), // Light purple
                    ),
                  ),
                ),
                // BackdropFilter for Blurring
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main Content with White Border
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // White Border Container
                  Container(
                    margin: EdgeInsets.only(top: 130.0), // เพิ่ม margin ด้านบน
                    padding: EdgeInsets.only(
                        top: 60.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: 16.0), // เพิ่ม padding ด้านบน
                    decoration: BoxDecoration(
                      color: Colors.white, // สีพื้นหลังของกรอบ
                      borderRadius: BorderRadius.circular(20), // ขอบมนของกรอบ
                      border: Border.all(
                          color: Colors.white, width: 2), // กรอบสีขาว
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: FutureBuilder(
                        future: loadData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          fullnameCtl.text = usergetRes[0].fullname;
                          usernameCtl.text = usergetRes[0].username;
                          emailCtl.text = usergetRes[0].email;
                          return Column(
                            children: [
                              SizedBox(
                                  height:
                                      80), // เพิ่มที่ว่างด้านบนเพื่อให้รูปโปรไฟล์ต่ำลง
                              _buildTextField(
                                icon: Icons.person_4_outlined,
                                label: usernameCtl.text,
                              ),
                              SizedBox(height: 20),
                              _buildTextField(
                                icon: Icons.person_pin_outlined,
                                label: fullnameCtl.text,
                              ),
                              SizedBox(height: 20),
                              _buildTextField(
                                icon: Icons.email_outlined,
                                label: emailCtl.text,
                              ),
                              SizedBox(height: 40),
                              // ปรับขนาดปุ่ม Logout
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color(0xFFCC7B7B), // สีของปุ่ม Logout
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: Size(double.infinity,
                                      50), // ขยายความกว้างของปุ่มให้เต็มขนาด
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginPage()), // นำทางไปยัง LoginPage
                                  );
                                },
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  // Profile Picture
                  Positioned(
                    top: 60, // ปรับตำแหน่งรูปโปรไฟล์ให้ต่ำลง
                    left: MediaQuery.of(context).size.width / 2 -
                        80, // จัดกลางแนวนอน
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavBar(
              activePage: 'user',
              onNavItemTapped: (page) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    switch (page) {
                      case 'home':
                        return HomePage(uid: widget.uid);
                      case 'lotto':
                        return LottoPage(uid: widget.uid);
                      case 'wallet':
                        return WalletPage(uid: widget.uid);
                      case 'user':
                        return UserPage(uid: widget.uid);
                      default:
                        return HomePage(uid: widget.uid);
                    }
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required IconData icon, required String label}) {
    return TextField(
      readOnly: true, // ทำให้ไม่สามารถแก้ไขได้
      enabled: false, // ทำให้ไม่สามารถโต้ตอบได้
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF9747FF)),
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF9747FF), fontFamily: 'Inter'),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF9747FF)),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF9747FF)),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF9747FF)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<void> loadDataAstnc() async {
    // await Future.delayed(const Duration(seconds: 2), () => print("BBB"));
    var value = await Configuration.getConfig();
    String url = value['apiEndPoint'];

    var json = await http.get(Uri.parse('$url/users/${widget.uid}'));
    usergetRes = useruidGetResFromJson(json.body);
  }
}
