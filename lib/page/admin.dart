import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:miniprojectapp/config/config.dart';
import 'package:miniprojectapp/page/login.dart';
import 'package:http/http.dart' as http;
import 'package:miniprojectapp/response/adminselotto_get_res.dart';
import 'package:miniprojectapp/response/lotto_get_res.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPage createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  late AdminGetLottoRes lenlotto;
  late Future<void> loadData;
  List<LottoGetRes> lottoGetRes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData = loadDataAstnc();
  }

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
          FutureBuilder(
              future: loadData,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return _buildStatistics(
                    lenlotto.lenuser.toString(), lenlotto.lenall.toString());
              }),
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

  Widget _buildStatistics(String lenuser, String lenall) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatBox('สลากถูกซื้อไปแล้ว', ':\t$lenuser'),
          _buildStatBox('สลากทั้งหมด', ':\t$lenall'),
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
          FutureBuilder(
            future: loadData,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
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
          ),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RandomButton(
                      onClose: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      onRefresh: () {
                        _handleRefresh();
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

  void _handleRefresh() {
    // ดีเลย์การรีเฟรชข้อมูล 5 วินาที
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        loadData = loadDataAstnc();
      });
    });
  }

  //add reset system
  String _formatNumber(String number) {
    return number.split('').join(' ');
  }

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
                onRefresh: () {
                  _handleRefresh();
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

  Future<void> loadDataAstnc() async {
    // await Future.delayed(const Duration(seconds: 2), () => print("BBB"));
    var value = await Configuration.getConfig();
    String url = value['apiEndPoint'];

    var json = await http.get(Uri.parse('$url/adminlotto/lotto'));
    lenlotto = adminGetLottoResFromJson(json.body);

    var jsonlotto = await http.get(Uri.parse('$url/lotto/seprize'));
    lottoGetRes = lottoGetResFromJson(jsonlotto.body);
  }
}

//============================================ S T A R T  F R O M  T H I S ================================
class RandomButton extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onRefresh;
  const RandomButton({Key? key, required this.onClose, required this.onRefresh})
      : super(key: key);

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
                    onPressed: () {
                      check(context, _selectedCheckbox, widget.onRefresh);
                      Navigator.of(context).pop();
                    },
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

  void check(BuildContext context, int se, VoidCallback onRefresh) async {
    // แสดง Dialog ขณะกำลังดำเนินการ
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: const BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: const Text(
            'กำลังดำเนินการ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        content: const Text(
          'กรุณารอสักครู่...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );

    try {
      // รับค่า Configuration
      var value = await Configuration.getConfig();
      String url = value['apiEndPoint'];

      // เลือกเส้นที่เหมาะสมตามค่า se
      String endpoint;
      if (se == 1) {
        endpoint = '/adminlotto/ranprizeuser'; // เส้นที่ 1
      } else if (se == 0) {
        endpoint = '/adminlotto/ranprizeall'; // เส้นที่ 2
      } else {
        throw Exception('Invalid value for se: $se');
      }

      // ส่งคำขอไปยัง API
      var response = await http.get(Uri.parse('$url$endpoint'));

      // ตรวจสอบสถานะการตอบสนอง
      if (response.statusCode == 200 || response.statusCode == 201) {
        // สุ่มสำเร็จ
        Navigator.pop(context); // ปิด Dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: const Text(
                'สำเร็จ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            content: const Text(
              'สุ่มสำเร็จ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // ปิด Dialog
                  onRefresh(); // เรียกฟังก์ชันรีเฟรช
                },
                child: const Text('ตกลง'),
              ),
            ],
          ),
        );
      } else {
        // การตอบสนองไม่สำเร็จ
        Navigator.pop(context); // ปิด Dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: const Text(
                'ข้อผิดพลาด',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            content: const Text(
              'Admin ได้ทำการสุ่มไปแล้วไม่สามารถสุ่มได้อีกนอกจากทาง Admin จะรีระบบ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // ปิด Dialog
                },
                child: const Text('ตกลง'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // การจัดการข้อผิดพลาด
      Navigator.pop(context); // ปิด Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const Text(
              'ข้อผิดพลาด',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          content: Text(
            'กรุณาเลือกระหว่าง สุ่มทั้งหมด หรือ สุ่มจากสลากที่ซื้อ',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
              },
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
    }
  }
}

// class PopupButton extends StatelessWidget {
//   final VoidCallback onClose;

//   PopupButton({required this.onClose});
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 15),
//               decoration: BoxDecoration(
//                 color: Color(0xFF8E44AD), // Purple color from the image
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//               child: Text(
//                 'รีเซ็ตระบบใหม่',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Text(
//                     'สร้างสลากจำนวน:',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 10),
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: "ขั้นต่ำ 100",
//                       border: UnderlineInputBorder(),
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'การรีเซ็ตระบบใหม่จะทำให้ข้อมูล\nลูกค้าและสลากหายทั้งหมด\nคุณแน่ใจหรือไม่?',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.red, fontSize: 14),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildActionButton(
//                           Icons.close, Color(0xFFE74C3C), onClose),
//                       _buildActionButton(Icons.check, Color(0xFF2ECC71), () {
//                         // เพิ่มการกระทำเมื่อกดปุ่มยืนยันที่นี่
//                         onClose(); // ปิด popup หลังจากยืนยัน
//                       }),
//                       SizedBox(
//                         height: 10,
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButton(
//       IconData icon, Color color, VoidCallback onPressed) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.green[400], // สีพื้นหลังที่ต้องการ
//           borderRadius:
//               BorderRadius.circular(20) // รูปทรง (ใช้ Circle เพื่อให้เป็นวงกลม)
//           // รูปทรง (ใช้ Circle เพื่อให้เป็นวงกลม)
//           ),
//       width: 75,
//       child: IconButton(
//         icon: Icon(icon, color: Colors.white),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }

class ResetButtonn extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onRefresh; // เพิ่มพารามิเตอร์นี้
  ResetButtonn({required this.onClose, required this.onRefresh});
  final TextEditingController _controller = TextEditingController();
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
                    controller: _controller,
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
                        reset(context);
                        // เพิ่มการกระทำเมื่อกดปุ่มยืนยันที่นี่
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

  void reset(BuildContext context) async {
    String amountString = _controller.text;
    int? amount = int.tryParse(amountString);

    if (amount == null) {
      Navigator.pop(context); // ปิด Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const Text(
              'ข้อผิดพลาด',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          content: const Text(
            'กรุณากรอกจำนวนที่ถูกต้อง',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
              },
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
      return;
    }

    if (amount < 100) {
      Navigator.pop(context); // ปิด Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: const Text(
              'ข้อผิดพลาด',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          content: const Text(
            'กรุณาใส่จำนวนที่มากว่า 100',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
              },
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
      return;
    } else {
      try {
        var value = await Configuration.getConfig();
        String url = value['apiEndPoint'];
        var response =
            await http.get(Uri.parse('$url/adminlotto/randomlotto/$amount'));
        log('จำนวนเงินถูกต้อง');
        if (response.statusCode == 200 || response.statusCode == 201) {
          // สุ่มสำเร็จ
          Navigator.pop(context); // ปิด Dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                child: const Text(
                  'สำเร็จ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              content: const Text(
                'ทำการรีเซ็ตระบบสำเร็จ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // ปิด Dialog
                    onRefresh(); // เรียกฟังก์ชันรีเฟรช
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            ),
          );
        } else {
          // การตอบสนองไม่สำเร็จ
          Navigator.pop(context); // ปิด Dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                child: const Text(
                  'ข้อผิดพลาด',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              content: const Text(
                'Admin ได้ทำการรีระบบไปแล้วรอออกรางวัลก่อนจึงจะรีระบบได้',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // ปิด Dialog
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        // การจัดการข้อผิดพลาด
        Navigator.pop(context); // ปิด Dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: const Text(
                'ข้อผิดพลาด',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            content: Text(
              'ERROR DATABASE',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // ปิด Dialog
                },
                child: const Text('ตกลง'),
              ),
            ],
          ),
        );
      }
    }
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
