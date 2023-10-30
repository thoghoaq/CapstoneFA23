import 'package:capstone_fa23_driver/partials/profile_list_tile.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String get _name => "Armayoga";

  bool _status = true;

  void toggleStatus() {
    setState(() {
      _status = !_status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(title: "Hồ sơ"),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: DAvatarCircle(
                image: Image.asset('assets/images/contexts/avatar_2.png'),
                radius: 100,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(_name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                ProfileListTile(
                  title: Text("Chỉnh sửa hồ sơ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: DColors.defaultText,
                  ),
                  onTap: () {
                    context.push('/profile/update');
                  },
                  showBottomDivider: false,
                ),
                ProfileListTile(
                  title: Text("Trạng thái",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  trailing: Icon(
                    _status ? Icons.toggle_on : Icons.toggle_off_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 43,
                  ),
                  onTap: () {
                    toggleStatus();
                  },
                  showBottomDivider: false,
                ),
                ProfileListTile(
                  title: Text("Đổi mật khẩu",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: DColors.defaultText,
                  ),
                  onTap: () {
                    context.push("/profile/changePassword");
                  },
                  showBottomDivider: false,
                ),
                ProfileListTile(
                  title: Text("Đăng xuất",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: DColors.red,
                              )),
                  onTap: () {
                    context.go('/login');
                  },
                  showBottomDivider: false,
                  trailing: const Icon(
                    Icons.navigate_next,
                    color: DColors.red,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
