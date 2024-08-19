import 'dart:developer';
import 'dart:ui'; // Import for the BackdropFilter
import 'package:flutter/material.dart';
import 'package:miniprojectapp/page/Widget.dart';
import 'package:miniprojectapp/page/lotto.dart';
import 'package:miniprojectapp/page/user.dart';
import 'package:miniprojectapp/page/wallet.dart';

class HomePage extends StatefulWidget {
  int uid = 0;
  HomePage({super.key, required this.uid});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String activePage = 'home'; // State variable to track the active page

  @override
  void initState() {
    // TODO: implement initState
    log(widget.uid.toString());
    super.initState();
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
                  _buildPrizeRow('รางวัลที่ 1', '2000 บาท'),
                  _buildPrizeRow('รางวัลที่ 2', '1500 บาท'),
                  _buildPrizeRow('รางวัลที่ 3', '1000 บาท'),
                  _buildPrizeRow('รางวัลที่ 4', '500 บาท'),
                  _buildPrizeRow('รางวัลที่ 5', '250 บาท'),
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
            ),
          ),
        ],
      ),
    );
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
            style: TextStyle(
              color: Colors.white,
              fontSize: 15, // Adjust font size as needed
            ),
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
}
