import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404 Not Found'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              'Oops! Page not found',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 16),
          Icon(Icons.error_outline, size: 64),
        ],
      ),
    );
  }
}
