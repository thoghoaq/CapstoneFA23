import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateProfilePage extends StatelessWidget {
  UpdateProfilePage({super.key});

  String get _name => "Priscilla Watson";
  final TextEditingController _usernameController = TextEditingController(
    text: "Priscilla Watson",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "+85 8297127712",
  );
  final TextEditingController _addressController = TextEditingController(
    text: "554, Lê Văn Việt, TP Thủ Đức",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(title: "Hồ sơ"),
      body: SingleChildScrollView(
        child: Column(
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
                          child:
                              SvgPicture.asset('assets/images/icons/edit.svg'),
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
                              color: Theme.of(context).colorScheme.background,
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
                                  color:
                                      Theme.of(context).colorScheme.background,
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
            Text(_name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 30),
            DTextBox(
              label: "Username",
              hintText: "Vui lòng nhập username",
              controller: _usernameController,
            ),
            const SizedBox(height: 20),
            DTextBox(
              label: "Số điện thoại",
              hintText: "Vui lòng nhập số điện thoại",
              controller: _phoneController,
            ),
            const SizedBox(height: 20),
            DTextBox(
              label: "Địa chỉ",
              hintText: "Vui lòng nhập địa chỉ",
              controller: _addressController,
            ),
            const SizedBox(height: 35),
            DPrimaryButton.bigwide(text: "Cập nhật", onPressed: () {}),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
