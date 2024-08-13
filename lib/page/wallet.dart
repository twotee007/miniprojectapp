import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:miniprojectapp/page/Widget.dart';
import 'package:miniprojectapp/page/home.dart';
import 'package:miniprojectapp/page/lotto.dart';
import 'package:miniprojectapp/page/user.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String activePage = 'wallet'; // Track the active page

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
          // Main Content
          Center(
            child: Text(
              'หน้า วอเรท/สลาก',
              style: TextStyle(fontSize: 24, color: Colors.white),
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
}
