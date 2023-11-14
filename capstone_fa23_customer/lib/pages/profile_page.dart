import 'package:capstone_fa23_customer/partials/profile_list_tile.dart';
import 'package:capstone_fa23_customer/providers/account_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
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
                        image:
                            Image.asset('assets/images/contexts/avatar_1.jpg'),
                        radius: 78,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Consumer<AccountProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                provider.fetchAccountInformation();
                return const Center(child: CircularProgressIndicator());
              }
              return Text(provider.profile.name,
                  style: Theme.of(context).textTheme.headlineMedium);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Tài khoản",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  ProfileListTile(
                    title: Text("Hồ sơ",
                        style: Theme.of(context).textTheme.displayMedium),
                    leading: SvgPicture.asset("assets/images/icons/person.svg"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: DColors.gray3,
                    ),
                    onTap: () {
                      context.push('/profile/update');
                    },
                  ),
                  ProfileListTile(
                    title: Text("Vô hiệu hóa / Xóa tài khoản",
                        style: Theme.of(context).textTheme.displayMedium),
                    leading: SvgPicture.asset(
                        "assets/images/icons/verification.svg"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: DColors.gray3,
                    ),
                    onTap: () {},
                  ),
                  ProfileListTile(
                    title: Text("Đổi mật khẩu",
                        style: Theme.of(context).textTheme.displayMedium),
                    leading:
                        SvgPicture.asset("assets/images/icons/password.svg"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: DColors.gray3,
                    ),
                    onTap: () {
                      context.push("/profile/change-password");
                    },
                  ),
                  ProfileListTile(
                    title: Text("Đăng xuất",
                        style: Theme.of(context).textTheme.displayMedium?.apply(
                              color: DColors.red,
                            )),
                    leading: SvgPicture.asset("assets/images/icons/exit.svg"),
                    onTap: () {
                      context.go('/login');
                    },
                    showBottomDivider: false,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
