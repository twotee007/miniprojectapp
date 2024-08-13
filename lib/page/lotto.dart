import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:miniprojectapp/page/Widget.dart';
import 'package:miniprojectapp/page/home.dart';
import 'package:miniprojectapp/page/wallet.dart';
import 'package:miniprojectapp/page/user.dart';

class LottoPage extends StatelessWidget {
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
          // Main Content
          Center(
            child: Text(
              'หน้า Lotto',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          // Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavBar(
              activePage: 'lotto',
              onNavItemTapped: (page) {
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
