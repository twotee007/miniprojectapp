import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final String activePage;
  final ValueChanged<String> onNavItemTapped;

  const BottomNavBar({
    Key? key,
    required this.activePage,
    required this.onNavItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: const Color(0xFF735DB8), // Light purple
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              'assets/img/Home.png',
              'หน้าหลัก',
              isActive: activePage == 'home',
              onPressed: () {
                if (activePage != 'home') {
                  onNavItemTapped('home');
                }
              },
            ),
            _buildNavItem(
              'assets/img/Lotto2.png',
              'ซื้อสลาก',
              isActive: activePage == 'lotto',
              onPressed: () {
                if (activePage != 'lotto') {
                  onNavItemTapped('lotto');
                }
              },
            ),
            _buildNavItem(
              'assets/img/Wallet.png',
              'วอเรท/สลาก',
              isActive: activePage == 'wallet',
              onPressed: () {
                if (activePage != 'wallet') {
                  onNavItemTapped('wallet');
                }
              },
            ),
            _buildNavItem(
              'assets/img/User.png',
              'ข้อมูล',
              isActive: activePage == 'user',
              onPressed: () {
                if (activePage != 'user') {
                  onNavItemTapped('user');
                }
              },
            ),
          ],
        ),
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
              border: isActive
                  ? Border.all(
                      color: const Color.fromARGB(255, 219, 215, 215),
                      width: 2.0)
                  : null,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.asset(
              assetPath,
              color: Colors.white,
              width: 60,
              height: 30,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
