import 'package:flutter/material.dart';
import '../constants/styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('SIGN UP', style: TextStyles.headline4),
            const SizedBox(height: 32),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'EMAIL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'USERNAME',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'PASSWORD',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: Text('SIGN UP', style: TextStyles.button),
            ),
            const SizedBox(height: 16),
            Text(
              'BY SIGNING UP, YOU UNDERSTAND AND AGREED WITH OUR TERMS AND SERVICE',
              style: TextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/signin'),
              child: Text(
                'ALREADY HAVE AN ACCOUNT? SIGN IN HERE',
                style: TextStyles.bodyText1.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}