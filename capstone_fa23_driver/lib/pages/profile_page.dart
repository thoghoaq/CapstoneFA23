import 'package:capstone_fa23_driver/partials/profile_list_tile.dart';
import 'package:capstone_fa23_driver/providers/account_provider.dart';
import 'package:capstone_fa23_driver/providers/orders_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            Consumer<AccountProvider>(
              builder: (context, provider, child) {
                if (provider.profile == null) {
                  provider.fetchAccountInformation();
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Text(
                    provider.profile?.name ??
                        provider.username ??
                        provider.phoneNumber ??
                        "",
                    style: Theme.of(context).textTheme.headlineSmall);
              },
            ),
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
                      context.push("/profile/change-password");
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
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      if (context.mounted) {
                        context.read<AccountProvider>().clear();
                        context.read<OrderProvider>().clear();
                        context.go('/login');
                      }
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
        ));
  }
}
