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
    // BottomNavigationBarItem(
    //   icon: SvgPicture.asset('assets/images/icons/home.svg'),
    //   label: 'Home',
    //   activeIcon: DActiveNavigationBarIcon(
    //       icon: SvgPicture.asset('assets/images/icons/home.svg')),
    // ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/icons/calendar.svg'),
      label: 'Orders',
      activeIcon: DActiveNavigationBarIcon(
          icon: SvgPicture.asset('assets/images/icons/calendar.svg')),
    ),
    // BottomNavigationBarItem(
    //   icon: SvgPicture.asset('assets/images/icons/map.svg'),
    //   label: 'Map',
    //   activeIcon: DActiveNavigationBarIcon(
    //       icon: SvgPicture.asset('assets/images/icons/map.svg')),
    // ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/icons/profile.svg'),
      label: 'Profile',
      activeIcon: DActiveNavigationBarIcon(
          icon: SvgPicture.asset('assets/images/icons/profile.svg')),
    ),
  ];

  int _currentIndex = 0;

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
                context.go('/orders');
                break;
              case 1:
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
