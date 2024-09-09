import 'dart:convert';
import 'dart:developer';
import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:LOTTO168/config/config.dart';
import 'package:LOTTO168/page/Widget.dart';
import 'package:LOTTO168/page/home.dart';
import 'package:LOTTO168/page/user.dart';
import 'package:LOTTO168/page/wallet.dart';
import 'package:http/http.dart' as http;
import 'package:LOTTO168/response/lotto_get_res.dart';
import 'package:LOTTO168/response/useruid_get_res.dart';

class LottoPage extends StatefulWidget {
  int uid = 0;
  LottoPage({super.key, required this.uid});
  @override
  _LottoPurchasePageState createState() => _LottoPurchasePageState();
  List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
}

class _LottoPurchasePageState extends State<LottoPage> {
  String activePage = 'lotto'; // Track the active page
  List<LottoGetRes> lottoGetRes = [];
  List<UseruidGetRes> usergetRes = [];
  late Future<void> loadData;
  String searchMessage = 'ทั้งหมด';
  TextEditingController walletctl = TextEditingController();
  // Add TextEditingController for each input field
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  @override
  void initState() {
    super.initState();
    log(widget.uid.toString());
    loadData = loadDataAstnc();
    searchMessage = 'ทั้งหมด';
    // for (var controller in controllers) {
    //   controller.addListener(() {
    //     // searchLotto();
    //   });
    // }
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  // Search logic based on the input numbers
  void searchLotto() async {
    // setState(() {
    //   // Collect input digits from the controllers
    List<String> inputDigits = controllers.map((e) => e.text).toList();
    String numbersearch = '';
    for (var i = 0; i < inputDigits.length; i++) {
      if (inputDigits[i].isNotEmpty) {
        numbersearch += inputDigits[i];
      } else {
        numbersearch += '_';
      }
    }
    var value = await Configuration.getConfig();
    var url = value['apiEndPoint'];
    var jsonBody = {
      "numlotto": numbersearch,
    };
    try {
      var res = await http.post(
        Uri.parse('$url/lotto/searchlotto'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(jsonBody),
      );
      log('Response Status Code: ${res.statusCode}');
      if (res.statusCode == 201 || res.statusCode == 200) {
        // แปลง JSON ให้เป็น List<LottoGetRes>
        List<LottoGetRes> lottosearch = lottoGetResFromJson(res.body);

        setState(() {
          lottoGetRes = lottosearch;
          searchMessage = 'เลขที่ท่านต้องการ=> ' +
              inputDigits.map((digit) => digit.isEmpty ? '*' : digit).join(' ');
        });

        if (lottoGetRes.isNotEmpty) {
          log('results found it');
        } else {
          log('No results found');
          setState(() {
            searchMessage = 'โปรดค้นหาใหม่';
          });
        }
        if (numbersearch == '______') {
          setState(() {
            loadData = loadDataAstnc();
            searchMessage = 'ทั้งหมด';
          });
        }
      } else {
        log('Error: ${res.statusCode}');
        setState(() {
          searchMessage = 'ทั้งหมด';
        });
      }
    } catch (err) {
      log('Error during searchLotto: $err');
      setState(() {
        searchMessage = 'เกิดข้อผิดพลาด: $err';
      });
    }
    numbersearch = '';
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
          // Pink Result Bar at the Top
          Positioned(
            top: 18,
            left: 0,
            right: 0,
            child: Container(
              color: Color(0xFF735DB8), // Pink color
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LOTTO168',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Revalia',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/Card Wallet.png', // Path to your Wallet icon
                        width: 35,
                        height: 35,
                      ),
                      SizedBox(width: 0),
                      FutureBuilder(
                          future: loadData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            walletctl.text = usergetRes[0].wallet.toString();
                            return Text(
                              ':${walletctl.text.isNotEmpty ? walletctl.text : '0'}฿',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Revalia',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Background and other UI elements...

          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(
                  top: 100, left: 20, right: 20, bottom: 70),
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
                  Text(
                    'ค้นหาเลขเด็ด!',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RhodiumLibre',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: screenWidth - 40,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF735DB8),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'เลือกหมายเลขที่ต้องการ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Revalia',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            return Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: TextField(
                                controller: controllers[index],
                                focusNode: focusNodes[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Revalia',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                onChanged: (value) {
                                  // Move to the next field if a digit is entered
                                  if (value.length == 1 &&
                                      index < controllers.length - 1) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index + 1]);
                                  }
                                  // Move to the previous field if the current field is emptied
                                  else if (value.isEmpty && index > 0) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index - 1]);
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Clear all input fields
                                  for (var controller in controllers) {
                                    controller.clear();
                                  }

                                  // Reset the search message and show all results
                                  setState(() {
                                    searchMessage = 'ทั้งหมด'; // Reset message
                                    loadData =
                                        loadDataAstnc(); // Reset results to show all data
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF744CEA8),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  textStyle: TextStyle(fontSize: 16),
                                ),
                                child: Text(
                                  'ทั้งหมด',
                                  style: TextStyle(
                                    fontFamily: 'Revalia',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Trigger the search
                                  searchLotto();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF44CEA8),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  textStyle: TextStyle(fontSize: 16),
                                ),
                                child: Text(
                                  'ค้นหา',
                                  style: TextStyle(
                                    fontFamily: 'Revalia',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  // Display all available lotto options
                  Text(
                    searchMessage,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Revalia',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Display the selected Lotto numbers and purchase options
                  Expanded(
                    child: FutureBuilder(
                      future: loadData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'เกิดข้อผิดพลาดในการโหลดข้อมูล',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          );
                        }

                        // Check if the data is empty
                        if (lottoGetRes.isEmpty) {
                          // Show the appropriate message based on whether a search was performed or not
                          if (searchMessage == 'ทั้งหมด') {
                            // No data available in the system
                            return const Center(
                              child: Text(
                                'รางวัลออกแล้วรอการรีเซ็ตใหม่',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            );
                          } else {
                            // Data is empty but a search was performed
                            return Center(
                              child: Text(
                                'ไม่พบเลขที่ท่านต้องการ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            );
                          }
                        }

                        // If there are results, display them
                        return ListView(
                          padding: const EdgeInsets.only(bottom: 100),
                          children: lottoGetRes
                              .map(
                                (lotto) => _buildLotteryCard(
                                  _formatNumber(lotto.number),
                                  lotto.price,
                                  lotto.lid,
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),

          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
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

  String _formatNumber(String number) {
    return number.split('').join(' ');
  }

  Widget _buildLotteryCard(String numbers, int price, int lid) {
    List<String> numberList = numbers.split(' ');

    return Card(
      margin: EdgeInsets.symmetric(vertical: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Color(0xFFC17E7E),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/img/file.png',
                  width: 75,
                  height: 75,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: numberList.map((number) {
                          return Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF471AA0), // Border color
                                width: 2, // Border thickness
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                number,
                                style: TextStyle(
                                  fontSize: 16, // Font size
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF471AA0), // Font color
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      // Price and Purchase Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$price บาท',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'RhodiumLibre',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF471AA0), // Price color
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              userbuylotto(context, widget.uid, lid, numbers);
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF32B967), // Green color
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(
                                  1), // Adjust padding to control the size
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size:
                                    20, // Adjust the size of the add icon here
                              ),
                            ),
                            label: Text(
                              'ซื้อสลาก',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'RhodiumLibre',
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFFC17E7E), // Button color
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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

    var json = await http.get(Uri.parse('$url/lotto'));
    lottoGetRes = lottoGetResFromJson(json.body);

    var jsonuser = await http.get(Uri.parse('$url/users/${widget.uid}'));
    usergetRes = useruidGetResFromJson(jsonuser.body);
  }

  void userbuylotto(
      BuildContext context, int uid, int lid, String numbers) async {
    // Show confirmation dialog
    bool confirm = await showDialog(
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
            'ซื้อสลาก',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'คุณยืนยันจะซื้อสลากเลข\n: $numbers\nหรือไม่?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 199, 91, 84),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // เปลี่ยนเป็นขอบโค้งมน
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false); // กด 'ยกเลิก'
                  },
                  child: const Icon(Icons.close, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 104, 175, 106),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // เปลี่ยนเป็นขอบโค้งมน
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true); // กด 'ยืนยัน'
                  },
                  child: const Icon(Icons.check, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // If user confirms
    if (confirm) {
      // Show a dialog to indicate the purchase is being processed
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

      var value = await Configuration.getConfig();
      String url = value['apiEndPoint'];

      var jsonBody = {
        "uid": uid,
        "lid": lid,
      };

      try {
        var res = await http.put(
          Uri.parse('$url/lotto/userbuylotto'),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode(jsonBody),
        );

        Navigator.pop(context); // Close the processing dialog

        if (res.statusCode == 201 || res.statusCode == 200) {
          // Show success dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                      255, 142, 76, 175), // เปลี่ยนสีให้เข้ากับความสำเร็จ
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
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'บันทึกข้อมูลเรียบร้อย',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 199, 91, 84),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // ปิด Dialog
                        },
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          // Handle successful purchase
          log('Purchase successful for user $uid with lottery ID $lid');
          setState(() {
            // Reload data or update UI
            loadData = loadDataAstnc();
          });
        } else {
          // Show error dialog
          // Show error dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 199, 91,
                      84), // Customize this color for error indication
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
              contentPadding: const EdgeInsets.all(16.0),
              content: Text(
                'ยอดเงินของท่านไม่เพียงพอ',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              actionsPadding: const EdgeInsets.only(bottom: 8.0),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 199, 91,
                          84), // Same color as title background for consistency
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close the error dialog
                    },
                    child: const Text('ปิด',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          );

          log('Error purchasing lottery: ${res.statusCode}');
        }
      } catch (err) {
        Navigator.pop(context); // Close the processing dialog

        // Show error dialog
        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text('ข้อผิดพลาด', textAlign: TextAlign.center),
            content: Text('เกิดข้อผิดพลาด: $err', textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the error dialog
                },
                child: const Text('ปิด'),
              ),
            ],
          ),
        );
        log('Error during userbuylotto: $err');
      }
    }
  }
}
