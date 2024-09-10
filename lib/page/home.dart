import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui'; // Import for the BackdropFilter
import 'package:LOTTO168/page/login.dart';
import 'package:LOTTO168/response/useruid_get_res.dart';
import 'package:flutter/material.dart';
import 'package:LOTTO168/config/config.dart';
import 'package:LOTTO168/page/Widget.dart';
import 'package:LOTTO168/page/lotto.dart';
import 'package:LOTTO168/page/user.dart';
import 'package:LOTTO168/page/wallet.dart';
import 'package:http/http.dart' as http;
import 'package:LOTTO168/response/lotto_get_res.dart';

class HomePage extends StatefulWidget {
  int uid = 0;
  HomePage({super.key, required this.uid});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String activePage = 'home'; // State variable to track the active page
  List<LottoGetRes> lottoGetRes = [];
  List<UseruidGetRes> usergetRes = [];
  late Future<void> loadData;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData = loadDataAstnc();
    startCheckingUserStatus();
  }

  @override
  void dispose() {
    // หยุดการทำงานของ Timer เมื่อหน้า widget ถูกปิด
    _timer?.cancel();
    super.dispose();
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
                  top: 10, // Moved further from the top
                  left: -30, // Moved further from the left
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
                    filter: ImageFilter.blur(
                        sigmaX: 2.0, sigmaY: 2.0), // Adjust blur intensity
                    child: Container(
                      color: Colors.white
                          .withOpacity(0.1), // Semi-transparent overlay
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text at the Top-Left
          const Positioned(
            top: 60,
            left: 30,
            child: Text(
              'LOTTO168',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Revalia', // Use Revalia font
                color: Colors.white,
              ),
            ),
          ),
          // Prize Announcement Section
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ประกาศผลรางวัล',
                    style: TextStyle(
                      fontFamily: 'Revalia', // Use Revalia font
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FutureBuilder(
                    future: loadData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                            child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                      }
                      if (lottoGetRes == null || lottoGetRes.isEmpty) {
                        // หากไม่มีข้อมูล ให้แสดงรางวัลที่ 1 ถึง 5 พร้อมค่าเริ่มต้น
                        return Column(
                          children: List.generate(5, (index) {
                            // กำหนดข้อความรางวัลและจำนวนเงินตามลำดับ
                            String prizeNumber = (index + 1).toString();
                            String prizeText = '';
                            if (prizeNumber == '1') {
                              prizeText = '2000 บาท';
                            } else if (prizeNumber == '2') {
                              prizeText = '1500 บาท';
                            } else if (prizeNumber == '3') {
                              prizeText = '1000 บาท';
                            } else if (prizeNumber == '4') {
                              prizeText = '500 บาท';
                            } else if (prizeNumber == '5') {
                              prizeText = '250 บาท';
                            }

                            return _buildPrizeRow(
                              'รางวัลที่ $prizeNumber',
                              prizeText,
                              _formatNumber('??????'), // ค่าเริ่มต้นของหมายเลข
                            );
                          }),
                        );
                      }
                      return Column(
                        children: lottoGetRes.map<Widget>(
                          (lotto) {
                            String prizeText = '';
                            if (lotto.prize == '1') {
                              prizeText = '2000 บาท';
                            } else if (lotto.prize == '2') {
                              prizeText = '1500 บาท';
                            } else if (lotto.prize == '3') {
                              prizeText = '1000 บาท';
                            } else if (lotto.prize == '4') {
                              prizeText = '500 บาท';
                            } else if (lotto.prize == '5') {
                              prizeText = '250 บาท';
                            }
                            return _buildPrizeRow(
                              'รางวัลที่ ${lotto.prize}', // หรือใช้การจัดรูปแบบที่เหมาะสม
                              prizeText,
                              _formatNumber(lotto.number),
                            );
                          },
                        ).toList(),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavBar(
              activePage: 'home',
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
              onItemTapped: (index) {},
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(String number) {
    return number.split('').join(' ');
  }

  Widget _buildNavItem(String assetPath, String label,
      {bool isActive = false, VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border:
                  isActive ? Border.all(color: Colors.red, width: 2.0) : null,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.asset(
              assetPath,
              color: Colors.white,
              width: 60, // Adjust width as needed
              height: 30, // Adjust height as needed
            ),
          ),
          const SizedBox(height: 4), // Spacing between icon and text
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15, // Adjust font size as needed
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeRow(String title, String amount, String number) {
    List<String> numberList = number.split(' ');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xff44CEA8), // Green color
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color with opacity
              offset: const Offset(0, 4), // Shadow offset (x, y)
              blurRadius: 8.0, // Shadow blur radius
              spreadRadius: 0.0, // Shadow spread radius
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Column for the title and amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            // Spacing between the text and the grey container
            const SizedBox(width: 10.0),
            // Grey container taking up nearly the full width
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: numberList.map((number) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        number,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startCheckingUserStatus() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      Cheackuser(); // เรียกฟังก์ชันเช็คข้อมูลผู้ใช้ทุกๆ 10 วินาที
    });
  }

  Future<void> loadDataAstnc() async {
    // await Future.delayed(const Duration(seconds: 2), () => print("BBB"));
    var value = await Configuration.getConfig();
    String url = value['apiEndPoint'];

    var json = await http.get(Uri.parse('$url/lotto/seprize'));
    lottoGetRes = lottoGetResFromJson(json.body);
  }

  Future<void> Cheackuser() async {
    var value = await Configuration.getConfig();
    String url = value['apiEndPoint'];

    var jsonuser = await http.get(Uri.parse('$url/users/${widget.uid}'));
    var userResponse = jsonDecode(jsonuser.body);

    // ตรวจสอบว่ามีข้อมูลหรือไม่
    if (userResponse is Map<String, dynamic> &&
        userResponse['success'] == false) {
      // ไม่มีข้อมูล นำทางไปยังหน้า Login และหยุดการเช็ค
      _timer?.cancel();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginPage(), // เปลี่ยนเป็นหน้า Login ของคุณ
        ),
        (route) => false, // ลบหน้าเดิมทั้งหมดออกจาก stack
      );
    } else if (userResponse is List && userResponse.isNotEmpty) {
      // มีข้อมูลผู้ใช้ ดำเนินการต่อได้
      print('User exists: ${userResponse[0]['username']}');
    } else {
      // กรณีอื่น ๆ ที่ไม่ตรงกับทั้งสองแบบ
      print('Unexpected response format');
    }
  }
}
