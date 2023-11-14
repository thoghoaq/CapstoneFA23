import 'package:capstone_fa23_customer/helpers/datetime_helper.dart';
import 'package:capstone_fa23_customer/providers/account_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _birthDayTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(title: "Hồ sơ"),
      body: SingleChildScrollView(
        child: Consumer<AccountProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              provider.fetchAccountInformation();
              return const Center(child: CircularProgressIndicator());
            }
            _birthDayTextController.text =
                DateTimeHelper.getDate(provider.profile.birthDay);
            return Column(
              children: [
                SizedBox(
                  height: 286,
                  child: Stack(
                    children: [
                      // Background
                      Stack(
                        children: [
                          Container(
                            height: 247,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/contexts/context_2.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                  'assets/images/icons/edit.svg'),
                            ),
                          )
                        ],
                      ),
                      // Avatar
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: DAvatarCircle(
                                    image: Image.asset(
                                        'assets/images/contexts/avatar_1.jpg'),
                                    radius: 78,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: SvgPicture.asset(
                                          'assets/images/icons/plus_circle.svg'),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(provider.profile.name,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                DTextBox(
                  label: "Họ và tên",
                  hintText: "Vui lòng nhập họ và tên",
                  controller: TextEditingController(
                    text: provider.profile.name,
                  ),
                ),
                const SizedBox(height: 20),
                DTextBox(
                  label: "Số điện thoại",
                  hintText: "Vui lòng nhập số điện thoại",
                  controller: TextEditingController(
                    text: provider.profile.phoneContact,
                  ),
                ),
                const SizedBox(height: 20),
                DTextBox(
                  label: "Ngày sinh",
                  hintText: "Vui lòng nhập ngày sinh",
                  controller: _birthDayTextController,
                  onTap: () async {
                    var selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2001, 1, 1),
                        firstDate: DateTime(1990, 1, 1),
                        lastDate: DateTime.now());
                    if (selectedDate != null) {
                      _birthDayTextController.text = DateTimeHelper.getDate(
                          selectedDate.toIso8601String());
                    }
                  },
                ),
                const SizedBox(height: 20),
                DTextBox(
                  label: "Địa chỉ",
                  hintText: "Vui lòng nhập địa chỉ",
                  controller: TextEditingController(
                    text: provider.profile.address,
                  ),
                ),
                const SizedBox(height: 35),
                DPrimaryButton.bigwide(text: "Cập nhật", onPressed: () {}),
                const SizedBox(height: 35),
              ],
            );
          },
        ),
      ),
    );
  }
}
