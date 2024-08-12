import 'package:flutter/material.dart';

class registerPage extends StatelessWidget {
  const registerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // วงกลมพื้นหลัง
          Positioned(
            top: -70,
            right: 15,
            child: Container(
              width: 142,
              height: 142,
              decoration: BoxDecoration(
                color: Color(0xFF471AA0), // สีม่วงเข้ม
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -15,
            right: -65,
            child: Container(
              width: 142,
              height: 142,
              decoration: BoxDecoration(
                color: Color(0xFFC17E7E), // สีชมพูอ่อน
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // ปุ่ม Back พร้อมข้อความ
          Positioned(
            top: 40, // ตำแหน่งเริ่มต้น
            left: 10, // ตำแหน่งเริ่มต้น
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // จัดตำแหน่งเริ่มต้นซ้าย
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 15),
                  color: Color(0xFF471AA0), // สีของ chevron
                  onPressed: () {
                    Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
                  },
                ),
                // ขยับข้อความลงมาพร้อมกับขยับไปทางขวา
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 50), // เพิ่มระยะห่างด้านบนและด้านซ้าย
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF471AA0), // สีของข้อความ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // เนื้อหาหลักของหน้า
          Center(
            child: Text('Register Page Content'),
          ),
        ],
      ),
    );
  }
}
