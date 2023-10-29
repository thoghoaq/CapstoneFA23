import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 286,
        child: Stack(
          children: [
            Container(
              height: 247,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/contexts/context_2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: DAvatarCircle(
                    image: Image.asset('assets/images/contexts/avatar_1.jpg'),
                    radius: 78,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
