import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import for TapGestureRecognizer
import 'register.dart'; // Import your register page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'LOTTO168',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF471AA0),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/img/Lotto.png',
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sign in',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF471AA0),
              ),
            ),
            SizedBox(height: 25), // เพิ่มระยะห่างระหว่างข้อความและกล่องข้อความ
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_4_outlined, color: Color(0xFF471AA0)), // ไอคอนด้านซ้าย
                labelText: 'Email or Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Color(0xFF9747FF),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Color(0xFF9747FF),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color(0xFF9747FF),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
              ),
            ),
            SizedBox(height: 35), // เพิ่มระยะห่างระหว่างกล่องข้อความ
            TextField(
              controller: _passwordController,
              obscureText: _obscureText, // ใช้สถานะในการควบคุมการมองเห็น
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Color(0xFF471AA0)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFF9747FF),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // สลับสถานะการมองเห็น
                    });
                  },
                ),
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Color(0xFF9747FF),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Color(0xFF9747FF),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color(0xFF9747FF),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0), // เพิ่มระยะห่างภายในกล่องข้อความ
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Add your forget password logic here
                },
                child: Text(
                  'Forget password?',
                  style: TextStyle(
                    color: Color(0xFF471AA0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // Add your login logic here
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF44CEA8)),
                ),
                child: Text('Sign in'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: Color(0xFF471AA0),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => registerPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
