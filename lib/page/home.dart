import 'dart:ui'; // Import for the BackdropFilter
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    decoration: BoxDecoration(
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
                    decoration: BoxDecoration(
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
          Positioned(
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
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ประกาศผลรางวัล',
                    style: TextStyle(
                      fontFamily: 'Revalia', // Use Revalia font
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
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
            child: Container(
              color: Color(0xFF735DB8), // Light purple
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Replace icon with asset image
                  Image.asset(
                    'assets/images/home.png', // Replace with your asset path
                    color: Colors.white,
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                  ),
                  Image.asset(
                    'assets/images/shopping_cart.png', // Replace with your asset path
                    color: Colors.white,
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                  ),
                  Image.asset(
                    'assets/images/account_balance_wallet.png', // Replace with your asset path
                    color: Colors.white,
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                  ),
                  Image.asset(
                    'assets/images/person.png', // Replace with your asset path
                    color: Colors.white,
                    width: 24, // Adjust width as needed
                    height: 24, // Adjust height as needed
                  ),
                ],
              ),
            ),
          )
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
          color: Color(0xff44CEA8), // Green color
          borderRadius: BorderRadius.circular(12.0),
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  amount,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            // Spacing between the text and the grey container
            SizedBox(width: 10.0),
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
