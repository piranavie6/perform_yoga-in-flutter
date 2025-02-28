import 'package:flutter/material.dart';
import 'home_page.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  ErrorPage({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Some error!!!!!!!!!!!!!!!! ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to Home page
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
