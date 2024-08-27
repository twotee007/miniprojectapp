import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:miniprojectapp/page/login.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPage createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundLayer(),
          _buildMainContent(),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  // 1. พื้นหลัง
  Widget _buildBackgroundLayer() {
    return Positioned.fill(
      child: Stack(
        children: [
          _buildDarkPurpleCircle(),
          _buildLightPurpleCircle(),
          _buildBlurEffect(),
        ],
      ),
    );
  }

  Widget _buildDarkPurpleCircle() {
    return Positioned(
      top: 10,
      left: -30,
      child: Container(
        width: 299.87,
        height: 293.07,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF471AA0),
        ),
      ),
    );
  }

  Widget _buildLightPurpleCircle() {
    return Positioned(
      top: 110,
      left: 110,
      child: Container(
        width: 332.67,
        height: 325.13,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFCC7B7B),
        ),
      ),
    );
  }

  Widget _buildBlurEffect() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
    );
  }

  // 2. เนื้อหาหลัก
  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          _buildStatistics(),
          _buildPrizeAnnouncement(),
          _buildResetButton()
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(top: 30, left: 30),
      child: Text(
        'ADMIN\nLOTTO168',
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Revalia',
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatBox('สลากถูกซื้อไปแล้ว', ':\t999'),
          _buildStatBox('สลากทั้งหมด', ':\t999'),
        ],
      ),
    );
  }

  Widget _buildPrizeAnnouncement() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ออกรางวัล',
            style: TextStyle(
              fontFamily: 'Revalia',
              fontSize: 28.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5.0),
          _buildPrizeRow('รางวัลที่ 1', '2000 บาท'),
          _buildPrizeRow('รางวัลที่ 2', '1500 บาท'),
          _buildPrizeRow('รางวัลที่ 3', '1000 บาท'),
          _buildPrizeRow('รางวัลที่ 4', '500 บาท'),
          _buildPrizeRow('รางวัลที่ 5', '250 บาท'),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RandomButton(
                      onClose: () {
                        Navigator.of(context).pop(); // ปิด Dialog
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff44CEA8), // สีพื้นหลังของปุ่ม
                foregroundColor: Colors.black, // สีของข้อความและไอคอน
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/img/randomIcon.png', // แทนที่ด้วยพาธของรูปภาพของคุณ
                    width: 40,
                    height: 35,
                  ),
                  SizedBox(width: 10), // ระยะห่างระหว่างรูปภาพกับข้อความ
                  Text('สุ่มออกรางวัล'),
                ],
              )),
        ],
      ),
    );
  }
  //add reset system

  Widget _buildResetButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ResetButtonn(
                onClose: () {
                  Navigator.of(context).pop(); // ปิด Dialog
                },
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromARGB(255, 193, 126, 126), // สีพื้นหลังของปุ่ม
          foregroundColor: Colors.white, // สีของข้อความและไอคอน
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/img/reset.png',
              width: 40,
              height: 35,
            ),
            const SizedBox(width: 10),
            const Text("รีเซ็ตระบบใหม่"),
          ],
        ),
      ),
    );
  }

  // 3. แถบนำทางด้านล่าง
  Widget _buildBottomNavigationBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: const Color(0xFF735DB8),
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              'ออกจากระบบ',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // วิดเจ็ตย่อยต่างๆ
  Widget _buildStatBox(String label, String value) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Revalia'),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16.0, fontFamily: 'Revalia'),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeRow(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xff44CEA8),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 8.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        '0',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Revalia',
        ),
      ),
    );
  }
}

//============================================ S T A R T  F R O M  T H I S ================================
class RandomButton extends StatefulWidget {
  final VoidCallback onClose;

  const RandomButton({Key? key, required this.onClose}) : super(key: key);

  @override
  _RandomButtonState createState() => _RandomButtonState();
}

class _RandomButtonState extends State<RandomButton> {
  int _selectedCheckbox = -1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: const Text(
                'สุ่มออกรางวัล',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.5, // ปรับขนาดของ Checkbox ที่นี่
                    child: Checkbox(
                      value: _selectedCheckbox == 0,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _selectedCheckbox = 0;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color.fromRGBO(
                              70, 189, 108, 1); // สีเมื่อถูกเลือก
                        }
                        return const Color.fromRGBO(
                            115, 93, 184, 1); // สีเมื่อไม่ถูกเลือก
                      }),
                    ),
                  ),
                  const Text('สุ่มจากสลากทั้งหมด'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.5, // ปรับขนาดของ Checkbox ที่นี่
                    child: Checkbox(
                      value: _selectedCheckbox == 1,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _selectedCheckbox = 1;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color.fromRGBO(
                              70, 189, 108, 1); // สีเมื่อถูกเลือก
                        }
                        return const Color.fromRGBO(
                            115, 93, 184, 1); // สีเมื่อไม่ถูกเลือก
                      }),
                    ),
                  ),
                  const Text('สุ่มจากสลากที่ลูกค้าซื้อ'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red[400], // สีพื้นหลังที่ต้องการ
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 75,
                  child: IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: widget.onClose,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[400], // สีพื้นหลังที่ต้องการ
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 75,
                  child: IconButton(
                    icon:
                        const Icon(Icons.check, color: Colors.white, size: 30),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class PopupButton extends StatelessWidget {
  final VoidCallback onClose;

  PopupButton({required this.onClose});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Color(0xFF8E44AD), // Purple color from the image
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Text(
                'รีเซ็ตระบบใหม่',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'สร้างสลากจำนวน:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "ขั้นต่ำ 100",
                      border: UnderlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'การรีเซ็ตระบบใหม่จะทำให้ข้อมูล\nลูกค้าและสลากหายทั้งหมด\nคุณแน่ใจหรือไม่?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                          Icons.close, Color(0xFFE74C3C), onClose),
                      _buildActionButton(Icons.check, Color(0xFF2ECC71), () {
                        // เพิ่มการกระทำเมื่อกดปุ่มยืนยันที่นี่
                        onClose(); // ปิด popup หลังจากยืนยัน
                      }),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[400], // สีพื้นหลังที่ต้องการ
          borderRadius:
              BorderRadius.circular(20) // รูปทรง (ใช้ Circle เพื่อให้เป็นวงกลม)
          // รูปทรง (ใช้ Circle เพื่อให้เป็นวงกลม)
          ),
      width: 75,
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}

class ResetButtonn extends StatelessWidget {
  final VoidCallback onClose;

  ResetButtonn({required this.onClose});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Color(0xFF8E44AD), // Purple color from the image
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Text(
                'รีเซ็ตระบบใหม่',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'สร้างสลากจำนวน:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "ขั้นต่ำ 100",
                      border: UnderlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'การรีเซ็ตระบบใหม่จะทำให้ข้อมูล\nลูกค้าและสลากหายทั้งหมด\nคุณแน่ใจหรือไม่?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButtonn(
                          Icons.close, Color(0xFFE74C3C), onClose),
                      _buildActionButtonn(Icons.check, Color(0xFF2ECC71), () {
                        // เพิ่มการกระทำเมื่อกดปุ่มยืนยันที่นี่
                        onClose(); // ปิด popup หลังจากยืนยัน
                      }),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtonn(
      IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[400], // สีพื้นหลังที่ต้องการ
          borderRadius:
              BorderRadius.circular(20) // รูปทรง (ใช้ Circle เพื่อให้เป็นวงกลม)
          // รูปทรง (ใช้ Circle เพื่อให้เป็นวงกลม)
          ),
      width: 75,
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
