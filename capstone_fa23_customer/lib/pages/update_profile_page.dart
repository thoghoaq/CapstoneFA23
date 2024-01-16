import 'package:capstone_fa23_customer/helpers/datetime_helper.dart';
import 'package:capstone_fa23_customer/helpers/province_api_helper.dart';
import 'package:capstone_fa23_customer/providers/account_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  final bool? firstLogin;
  const UpdateProfilePage({super.key, this.firstLogin});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _nameTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final _birthDayTextController = TextEditingController();
  final _provinceTextController = TextEditingController();
  final _districTextController = TextEditingController();
  final _wardTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  int? _provinceCode;
  int? _districtCode;

  @override
  void initState() {
    super.initState();
    if (widget.firstLogin == true) {
      initParam(context.read<AccountProvider>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(title: "Hồ sơ"),
      body: SingleChildScrollView(
        child: Consumer<AccountProvider>(
          builder: (context, provider, child) {
            if (widget.firstLogin != true) {
              if (provider.isLoading) {
                provider.fetchAccountInformation();
                return const Center(child: CircularProgressIndicator());
              }
            }
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
                Text(
                    provider.profile.name ??
                        provider.username ??
                        provider.phoneNumber ??
                        "",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                DTextBox(
                  label: "Họ và tên",
                  hintText: "Vui lòng nhập họ và tên",
                  controller: _nameTextController,
                ),
                const SizedBox(height: 20),
                DTextBox(
                  label: "Số điện thoại",
                  hintText: "Vui lòng nhập số điện thoại",
                  controller: _phoneNumberTextController,
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
                DAutoCompleteTextBox(
                  provinceTextController: _provinceTextController,
                  hintText: 'Vui lòng nhập tỉnh / thành phố',
                  label: 'Tỉnh / Thành phố',
                  itemBuilder: (context, item) {
                    var it = item as Map<int, String>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        it.values.first,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    var sug = suggestion as Map<int, String>;
                    _provinceTextController.text = sug.values.first;
                    _provinceCode = sug.keys.first;
                    _districTextController.clear();
                    _wardTextController.clear();
                  },
                  suggestionsCallback: (pattern) async {
                    return ProvinceApiHelper().getListProvince(pattern);
                  },
                ),
                const SizedBox(height: 20),
                DAutoCompleteTextBox(
                  provinceTextController: _districTextController,
                  hintText: 'Vui lòng nhập quận / huyện',
                  label: 'Quận / Huyện',
                  itemBuilder: (context, item) {
                    var it = item as Map<int, String>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        it.values.first,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    var sug = suggestion as Map<int, String>;
                    _districTextController.text = sug.values.first;
                    _districtCode = sug.keys.first;
                    _wardTextController.clear();
                  },
                  suggestionsCallback: (pattern) async {
                    return ProvinceApiHelper()
                        .getListDistrict(_provinceCode!, pattern);
                  },
                ),
                const SizedBox(height: 20),
                DAutoCompleteTextBox(
                  provinceTextController: _wardTextController,
                  hintText: 'Vui lòng nhập phường / xã',
                  label: 'Phường / Xã',
                  itemBuilder: (context, item) {
                    var it = item as Map<int, String>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        it.values.first,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    var sug = suggestion as Map<int, String>;
                    _wardTextController.text = sug.values.first;
                  },
                  suggestionsCallback: (pattern) async {
                    return ProvinceApiHelper()
                        .getListWard(_provinceCode!, _districtCode!, pattern);
                  },
                ),
                const SizedBox(height: 20),
                DTextBox(
                  label: "Địa chỉ",
                  hintText: "Vui lòng nhập địa chỉ",
                  controller: _addressTextController,
                ),
                const SizedBox(height: 35),
                DPrimaryButton.bigwide(
                    text: "Cập nhật",
                    onPressed: () async {
                      bool result = await provider.updateProfile(
                        _nameTextController.text,
                        DateTimeHelper.parse(_birthDayTextController.text),
                        _provinceTextController.text,
                        _districTextController.text,
                        _wardTextController.text,
                        _addressTextController.text,
                        _phoneNumberTextController.text,
                      );
                      if (result) {
                        Fluttertoast.showToast(msg: "Cập nhật thành công");
                      }
                    }),
                const SizedBox(height: 35),
              ],
            );
          },
        ),
      ),
    );
  }

  void initParam(AccountProvider provider) {
    if (provider.profile.name != null) {
      _nameTextController.text = provider.profile.name!;
    }
    if (provider.profile.phoneContact != null) {
      _phoneNumberTextController.text = provider.profile.phoneContact!;
    }
    if (provider.profile.address != null) {
      _addressTextController.text = provider.profile.address!;
    }
    if (provider.profile.province != null) {
      _provinceTextController.text = provider.profile.province!;
    }
    if (provider.profile.district != null) {
      _districTextController.text = provider.profile.district!;
    }
    if (provider.profile.ward != null) {
      _wardTextController.text = provider.profile.ward!;
    }
    if (provider.profile.birthDay != null) {
      _birthDayTextController.text =
          DateTimeHelper.getDate(provider.profile.birthDay!);
    }
  }
}
