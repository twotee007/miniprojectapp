import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:miniprojectapp/page/Widget.dart';
import 'package:miniprojectapp/page/home.dart';
import 'package:miniprojectapp/page/user.dart';
import 'package:miniprojectapp/page/wallet.dart';

class LottoPage extends StatefulWidget {
  @override
  _LottoPurchasePageState createState() => _LottoPurchasePageState();
}

class _LottoPurchasePageState extends State<LottoPage> {
  String activePage = 'lotto'; // Track the active page

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
          // Main Content Box
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(
                  top: 100, // Adjusted to account for the pink bar height
                  left: 20,
                  right: 20,
                  bottom: 70), // Adjust margin to ensure title is not covered
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
                  // New Text Above the Lotto Purchase Section
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
                  // Lotto Number Search
                  Container(
                    width: screenWidth - 40,
                    padding: EdgeInsets.all(20), // Padding for the container
                    decoration: BoxDecoration(
                      color: Color(0xFF735DB8), // Dark purple background
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
                        // Number Input Section
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
                              child: Center(
                                child: Text(
                                  '9',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Revalia',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(
                                        0.6), // Lighter black color
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                            height:
                                20), // Adjusted space between number input and buttons
                        // Lotto Purchase Buttons arranged horizontally
                        Row(
                          children: [
                            Expanded(
                              flex: 1, // Short button
                              child: ElevatedButton(
                                onPressed: () {
                                  // Action for clear button
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
                            SizedBox(width: 10), // Spacing between buttons
                            Expanded(
                              flex: 2, // Long button
                              child: ElevatedButton(
                                onPressed: () {
                                  // Action for search button
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
                    'ทั้งหมด',
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
                    child: ListView(
                      padding: EdgeInsets.only(bottom: 100),
                      children: [
                        _buildLotteryCard('1 2 3 4 5 6', 100),
                        _buildLotteryCard('1 2 3 4 5 6', 100),
                        _buildLotteryCard('1 2 3 4 5 6', 100),
                        _buildLotteryCard('1 2 3 4 5 6', 100),
                        _buildLotteryCard('1 2 3 4 5 6', 100),
                        _buildLotteryCard('1 2 3 4 5 6', 100),
                      ],
                    ),
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
                        return HomePage();
                      case 'lotto':
                        return LottoPage();
                      case 'wallet':
                        return WalletPage();
                      case 'user':
                        return UserPage();
                      default:
                        return HomePage();
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

  Widget _buildLotteryCard(String numbers, int price) {
    List<String> numberList = numbers.split(' '); // Split numbers

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
            // Logo on the left and aligned to the center vertically
            Row(
              children: [
                Image.asset(
                  'assets/img/file.png', // Path to your logo
                  width: 75, // Adjust the size as needed
                  height: 75, // Adjust the size as needed
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
                            'assets/img/Lotto.png', // Replace with your image
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
                            padding: EdgeInsets.all(8.0), // Adjust padding
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
}
