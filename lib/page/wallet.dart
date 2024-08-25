import 'dart:developer';
import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:miniprojectapp/config/config.dart';
import 'package:miniprojectapp/page/Widget.dart';
import 'package:miniprojectapp/page/home.dart';
import 'package:miniprojectapp/page/lotto.dart';
import 'package:miniprojectapp/page/user.dart';
import 'package:http/http.dart' as http;
import 'package:miniprojectapp/response/useruid_get_res.dart';

class WalletPage extends StatefulWidget {
  int uid = 0;
  WalletPage({super.key, required this.uid});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String activePage = 'wallet'; // Track the active page
  List<UseruidGetRes> usergetRes = [];
  TextEditingController walletCtl = TextEditingController();
  late Future<void> loadData;
  @override
  void initState() {
    // TODO: implement initState
    log(widget.uid.toString());
    super.initState();
    loadData = loadDataAstnc();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          // Title Positioned Above the White Container
          Positioned(
            top: 60, // Adjust this value as needed
            left: 30,
            right: 20,
            child: Text(
              'LOTTO168',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Revalia', // Use Revalia font
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          // Main Content Box
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(
                  top: 115,
                  left: 20,
                  right: 20,
                  bottom: 20), // Adjust margin to ensure title is not covered
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New Text Above the Wallet Information
                  Text(
                    'วอเลท & สลาก',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RhodiumLibre',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Wallet Information
                  Container(
                    width: screenWidth -
                        40, // Adjust the width to fit within the margin
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFF471AA0), // Dark purple background
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เงินคงเหลือ :',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Revalia',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: FutureBuilder(
                              future: loadData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                walletCtl.text =
                                    usergetRes[0].wallet.toString();
                                return Text(
                                  '${walletCtl.text.isNotEmpty ? walletCtl.text : '0'} บาท',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Revalia',
                                    color: Colors.white,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Total Lottery Tickets
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF32B967), // Green background
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'สลากทั้งหมด : 3 ใบ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'RhodiumLibre',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Lottery Tickets List
                  Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.only(bottom: 100), // เพิ่ม padding ตรงนี้
                      children: [
                        _buildLotteryCard(
                          '1 2 3 4 5 6',
                          'คุณถูกรางวัลที่ 1 2000 บาท',
                          true,
                        ),
                        _buildLotteryCard(
                          '1 2 3 4 5 6',
                          'น่าเสียดายคุณไม่ถูกรางวัล',
                          false,
                        ),
                        _buildLotteryCard(
                          '1 2 3 4 5 6',
                          'น่าเสียดายคุณไม่ถูกรางวัล',
                          false,
                        ),
                      ],
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
              activePage: activePage,
              onNavItemTapped: (page) {
                setState(() {
                  activePage = page;
                });
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

  Widget _buildLotteryCard(String numbers, String result, bool isWinner) {
    List<String> numberList = numbers.split(' '); // แยกตัวเลข

    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isWinner ? Color(0xFF0ED600) : Colors.red,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // โลโก้ที่อยู่ด้านซ้ายและจัดตำแหน่งให้ตรงกลาง
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/img/file.png', // Path to your logo
                    width: 75, // Adjust the size as needed
                    height: 75, // Adjust the size as needed
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/Lotto.png',
                            width: 40,
                            height: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'สลาก LOTTO168',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Revalia',
                              color: Color(0xFF5B1B92),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Numbers Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: numberList.map((number) {
                          return Container(
                            padding: EdgeInsets.all(8.0), // ลด padding
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF471AA0), // สีกรอบ
                                width: 1.5,
                                // ลดความหนาของ border
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                number,
                                style: TextStyle(
                                  fontSize: 14, // ลดขนาดตัวเลข
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF471AA0), // สีตัวเลข
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        result,
                        style: TextStyle(
                          fontSize: 14,
                          color: isWinner ? Color(0xFF0ED600) : Colors.red,
                          fontFamily: 'Revalia',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // ข้อความรับรางวัลที่สามารถกดได้
            Visibility(
              visible: isWinner,
              child: InkWell(
                onTap: () {
                  _handlePrizeClaim(); // ฟังก์ชันจัดการการคลิกที่ข้อความ
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'คลิกที่สลากแล้วรับรางวัล',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Revalia',
                      color: Color(0xFF0ED600),
                    ),
                  ),
                ),
              ),
            ),
          ],
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

  void _handlePrizeClaim() {
    // ฟังก์ชันจัดการการคลิกที่ปุ่ม
    // ทำบางสิ่งเมื่อคลิก เช่น แสดงข้อความ, อัปเดตสถานะ, หรืออื่น ๆ
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('รับรางวัล'),
          content: Text('คุณได้คลิกเพื่อรับรางวัลแล้ว!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }
}

void _handlePrizeClaim(dynamic context) {
  // ฟังก์ชันจัดการการคลิกที่ปุ่ม
  // ทำบางสิ่งเมื่อคลิก เช่น แสดงข้อความ, อัปเดตสถานะ, หรืออื่น ๆ
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('รับรางวัล'),
        content: Text('คุณได้คลิกเพื่อรับรางวัลแล้ว!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ตกลง'),
          ),
        ],
      );
    },
  );
}
