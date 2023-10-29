import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 247,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/contexts/context_2.png'),
              fit: BoxFit.cover,
            ),
          ),
        )
      ]),
    );
  }
}
