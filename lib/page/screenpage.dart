import 'package:LOTTO168/page/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/img/Lotto.png', // ระบุ path ของไฟล์โลโก้
              width: 150, // กำหนดขนาดโลโก้
              height: 100,
            ),
            const Text(
              'LOTTO 168\nซื้อง่าย สบายใจ พร้อมบิด',
              textAlign: TextAlign.center, // จัดข้อความให้อยู่ตรงกลาง
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Revalia', // ใช้ฟอนต์ Revalia
                color: Color(0xFF471AA0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
