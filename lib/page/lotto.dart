import 'dart:developer';
import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:miniprojectapp/config/config.dart';
import 'package:miniprojectapp/page/Widget.dart';
import 'package:miniprojectapp/page/home.dart';
import 'package:miniprojectapp/page/user.dart';
import 'package:miniprojectapp/page/wallet.dart';
import 'package:http/http.dart' as http;
import 'package:miniprojectapp/response/lotto_get_res.dart';

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
  late Future<void> loadData;
  String searchMessage = 'ทั้งหมด';

  // Add TextEditingController for each input field
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    log(widget.uid.toString());
    loadData = loadDataAstnc();
    searchMessage = 'ทั้งหมด';
    for (var controller in controllers) {
      controller.addListener(() {
        searchLotto();
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Search logic based on the input numbers
  void searchLotto() {
    setState(() {
      // Collect input digits from the controllers
      List<String> inputDigits = controllers.map((e) => e.text).toList();

      // Check if all input fields are empty
      if (inputDigits.every((digit) => digit.isEmpty)) {
        // Reset to show all lotto results
        loadData = loadDataAstnc();
        searchMessage = 'ทั้งหมด'; // Reset message
        lottoGetRes = []; // Clear previous search results
      } else {
        // Generate the search pattern with asterisks
        searchMessage = 'ผลลัพธ์เลขที่ต้องการ=> ' +
            inputDigits.map((digit) => digit.isEmpty ? '*' : digit).join(' ');

        // Filter lotto results based on input digits
        lottoGetRes = lottoGetRes.where((lotto) {
          String formattedNumber = lotto.number;

          // Check if the formatted number matches the input digits at specific positions
          for (int i = 0; i < inputDigits.length; i++) {
            if (inputDigits[i].isNotEmpty &&
                (formattedNumber.length <= i ||
                    formattedNumber[i] != inputDigits[i])) {
              return false; // Exclude if not matching
            }
          }
          return true; // Include if matching
        }).toList();

        // Update the search message if no results are found
        if (lottoGetRes.isEmpty) {
          searchMessage = 'ไม่พบเลขที่ท่านต้องการ';
          // You might want to provide an option to refresh or retry the search
          // or automatically revert to showing all results after some time
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              // Clear input fields
              for (var controller in controllers) {
                controller.clear();
              }
              // Re-fetch data to reset the view
              loadData = loadDataAstnc();
              searchMessage = 'ทั้งหมด'; // Reset message
            });
          });
        }
      }
    });
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
                      Text(
                        ':12345฿', // Replace with the dynamic amount
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Revalia',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
                      fontSize: 20,
                      fontFamily: 'RhodiumLibre',
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
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView(
                            padding: EdgeInsets.only(bottom: 100),
                            children: lottoGetRes
                                .map(
                                  (lotto) => _buildLotteryCard(
                                      _formatNumber(lotto.number), lotto.price),
                                )
                                .toList(),
                          );
                        }),
                  ),
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

  Widget _buildLotteryCard(String numbers, int price) {
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
                              // Action for purchase button
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
  }

  void getlotto() {}
}
