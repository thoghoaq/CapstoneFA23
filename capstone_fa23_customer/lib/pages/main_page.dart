import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  final Widget child;
  const MainPage({
    super.key,
    required this.child,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/icons/home.svg'),
      label: 'Home',
      activeIcon: DActiveNavigationBarIcon(
          icon: SvgPicture.asset('assets/images/icons/home.svg')),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/icons/bag.svg'),
      label: 'Transaction',
      activeIcon: DActiveNavigationBarIcon(
          icon: SvgPicture.asset('assets/images/icons/bag.svg')),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/icons/message.svg'),
      label: 'Chat',
      activeIcon: DActiveNavigationBarIcon(
          icon: SvgPicture.asset('assets/images/icons/message.svg')),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/icons/profile.svg'),
      label: 'Profile',
      activeIcon: DActiveNavigationBarIcon(
          icon: SvgPicture.asset('assets/images/icons/profile.svg')),
    ),
  ];

  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: DBottomNavigationBar(
        items: _items,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/transaction');
                break;
              case 3:
                context.go('/profile');
                break;
              default:
            }
          });
        },
      ),
    );
  }
}
