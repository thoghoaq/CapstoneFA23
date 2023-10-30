import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateProfilePage extends StatelessWidget {
  UpdateProfilePage({super.key});

  String get _name => "Armayoga";
  final TextEditingController _usernameController = TextEditingController(
    text: "Armayoga",
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
      appBar: const DAppBar(title: "Chỉnh sửa hồ sơ"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            SizedBox(
              height: 100,
              width: 100,
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
                        image:
                            Image.asset('assets/images/contexts/avatar_2.png'),
                        radius: 98,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: SvgPicture.asset(
                              'assets/images/icons/plus_circle.svg',
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn)),
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(_name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            DUploadImage(
              label: "CCCD / CMT",
              hint: "Mặt trước",
              onTap: () {},
            ),
            const SizedBox(height: 10),
            DUploadImage(
              hint: "Mặt sau",
              onTap: () {},
            ),
            const SizedBox(height: 20),
            DUploadImage(
              label: "Giấy phép lái xe",
              hint: "Mặt trước",
              onTap: () {},
            ),
            const SizedBox(height: 10),
            DUploadImage(
              hint: "Mặt sau",
              onTap: () {},
            ),
            const SizedBox(height: 20),
            DUploadImage(
              label: "Phiếu đăng ký xe",
              hint: "Mặt trước",
              onTap: () {},
            ),
            const SizedBox(height: 10),
            DUploadImage(hint: "Mặt sau", onTap: () {}),
            const SizedBox(height: 35),
            DPrimaryButton.bigwide(text: "Cập nhật", onPressed: () {}),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
