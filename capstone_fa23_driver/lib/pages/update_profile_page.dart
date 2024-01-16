import 'package:capstone_fa23_driver/helpers/datetime_helper.dart';
import 'package:capstone_fa23_driver/helpers/image_helper.dart';
import 'package:capstone_fa23_driver/helpers/province_api_helper.dart';
import 'package:capstone_fa23_driver/providers/account_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
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

  String? _avtUrl;
  bool? _avtUrlLoading;

  String? _identificationCardFrontUrl;
  String? _identificationCardBackUrl;
  String? _drivingLicenseFrontUrl;
  String? _drivingLicenseBackUrl;
  String? _vehicleRegistrationCertificateFrontUrl;
  String? _vehicleRegistrationCertificateBackUrl;

  bool? _identificationCardFrontUrlLoading;
  bool? _identificationCardBackUrlLoading;
  bool? _drivingLicenseFrontUrlLoading;
  bool? _drivingLicenseBackUrlLoading;
  bool? _vehicleRegistrationCertificateFrontUrlLoading;
  bool? _vehicleRegistrationCertificateBackUrlLoading;

  @override
  void initState() {
    super.initState();
    if (widget.firstLogin != true) {
      initParam();
    }
  }

  initParam() {
    var provider = context.read<AccountProvider>();
    if (provider.profile?.name != null) {
      _nameTextController.text = provider.profile!.name!;
    }
    if (provider.profile?.phoneContact != null) {
      _phoneNumberTextController.text = provider.profile!.phoneContact!;
    }
    if (provider.profile?.address != null) {
      _addressTextController.text = provider.profile!.address!;
    }
    if (provider.profile?.province != null) {
      _provinceTextController.text = provider.profile!.province!;
    }
    if (provider.profile?.district != null) {
      _districTextController.text = provider.profile!.district!;
    }
    if (provider.profile?.ward != null) {
      _wardTextController.text = provider.profile!.ward!;
    }
    if (provider.profile?.birthDay != null) {
      _birthDayTextController.text =
          DateTimeHelper.getDate(provider.profile!.birthDay!);
    }
    if (provider.profile?.identificationCardFrontUrl != null) {
      _identificationCardFrontUrl =
          provider.profile!.identificationCardFrontUrl!;
    }
    if (provider.profile?.identificationCardBackUrl != null) {
      _identificationCardBackUrl = provider.profile!.identificationCardBackUrl!;
    }
    if (provider.profile?.drivingLicenseFrontUrl != null) {
      _drivingLicenseFrontUrl = provider.profile!.drivingLicenseFrontUrl!;
    }
    if (provider.profile?.drivingLicenseBackUrl != null) {
      _drivingLicenseBackUrl = provider.profile!.drivingLicenseBackUrl!;
    }
    if (provider.profile?.vehicleRegistrationCertificateFrontUrl != null) {
      _vehicleRegistrationCertificateFrontUrl =
          provider.profile!.vehicleRegistrationCertificateFrontUrl!;
    }
    if (provider.profile?.vehicleRegistrationCertificateBackUrl != null) {
      _vehicleRegistrationCertificateBackUrl =
          provider.profile!.vehicleRegistrationCertificateBackUrl!;
    }
    if (provider.profile?.avatarUrl != null) {
      _avtUrl = provider.profile!.avatarUrl!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DAppBar(title: "Chỉnh sửa hồ sơ"),
        body: SingleChildScrollView(
          child: Consumer<AccountProvider>(
            builder: (context, provider, child) {
              if (widget.firstLogin != true) {
                if (provider.profile == null) {
                  provider.fetchAccountInformation();
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }

              return Column(
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
                              image: _avtUrl != null
                                  ? Image.network(_avtUrl!)
                                  : Image.asset(
                                      'assets/images/contexts/avatar_2.png'),
                              isLoading: _avtUrlLoading,
                              onTap: () async {
                                setState(() {
                                  _avtUrlLoading = true;
                                });
                                var imageUrl = await ImageHelper.pickImage();
                                setState(() {
                                  if (imageUrl != null) {
                                    _avtUrl = imageUrl;
                                  }
                                  _avtUrlLoading = false;
                                });
                              },
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
                  Text(
                      provider.profile?.name ??
                          provider.username ??
                          provider.phoneNumber ??
                          "",
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 20),
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
                  DUploadImage(
                    label: "CCCD / CMT",
                    hint: "Mặt trước",
                    imageUrl: _identificationCardFrontUrl,
                    isLoading: _identificationCardFrontUrlLoading,
                    onTap: () async {
                      setState(() {
                        _identificationCardFrontUrlLoading = true;
                      });
                      var imageUrl = await ImageHelper.pickImage();
                      setState(() {
                        if (imageUrl != null) {
                          _identificationCardFrontUrl = imageUrl;
                        }
                        _identificationCardFrontUrlLoading = false;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  DUploadImage(
                    hint: "Mặt sau",
                    imageUrl: _identificationCardBackUrl,
                    isLoading: _identificationCardBackUrlLoading,
                    onTap: () async {
                      setState(() {
                        _identificationCardBackUrlLoading = true;
                      });
                      var imageUrl = await ImageHelper.pickImage();
                      setState(() {
                        if (imageUrl != null) {
                          _identificationCardBackUrl = imageUrl;
                        }
                        _identificationCardBackUrlLoading = false;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DUploadImage(
                    label: "Giấy phép lái xe",
                    hint: "Mặt trước",
                    imageUrl: _drivingLicenseFrontUrl,
                    isLoading: _drivingLicenseFrontUrlLoading,
                    onTap: () async {
                      setState(() {
                        _drivingLicenseFrontUrlLoading = true;
                      });
                      var imageUrl = await ImageHelper.pickImage();
                      setState(() {
                        if (imageUrl != null) {
                          _drivingLicenseFrontUrl = imageUrl;
                        }
                        _drivingLicenseFrontUrlLoading = false;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  DUploadImage(
                    hint: "Mặt sau",
                    imageUrl: _drivingLicenseBackUrl,
                    isLoading: _drivingLicenseBackUrlLoading,
                    onTap: () async {
                      setState(() {
                        _drivingLicenseBackUrlLoading = true;
                      });
                      var imageUrl = await ImageHelper.pickImage();
                      setState(() {
                        if (imageUrl != null) {
                          _drivingLicenseBackUrl = imageUrl;
                        }
                        _drivingLicenseBackUrlLoading = false;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DUploadImage(
                    label: "Phiếu đăng ký xe",
                    hint: "Mặt trước",
                    imageUrl: _vehicleRegistrationCertificateFrontUrl,
                    isLoading: _vehicleRegistrationCertificateFrontUrlLoading,
                    onTap: () async {
                      setState(() {
                        _vehicleRegistrationCertificateFrontUrlLoading = true;
                      });
                      var imageUrl = await ImageHelper.pickImage();
                      setState(() {
                        if (imageUrl != null) {
                          _vehicleRegistrationCertificateFrontUrl = imageUrl;
                        }
                        _vehicleRegistrationCertificateFrontUrlLoading = false;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  DUploadImage(
                    hint: "Mặt sau",
                    imageUrl: _vehicleRegistrationCertificateBackUrl,
                    isLoading: _vehicleRegistrationCertificateBackUrlLoading,
                    onTap: () async {
                      setState(() {
                        _vehicleRegistrationCertificateBackUrlLoading = true;
                      });
                      var imageUrl = await ImageHelper.pickImage();
                      setState(() {
                        if (imageUrl != null) {
                          _vehicleRegistrationCertificateBackUrl = imageUrl;
                        }
                        _vehicleRegistrationCertificateBackUrlLoading = false;
                      });
                    },
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
                            _avtUrl!,
                            _identificationCardFrontUrl!,
                            _identificationCardBackUrl!,
                            _drivingLicenseFrontUrl!,
                            _drivingLicenseBackUrl!,
                            _vehicleRegistrationCertificateFrontUrl!,
                            _vehicleRegistrationCertificateBackUrl!);
                        if (result) {
                          Fluttertoast.showToast(msg: "Cập nhật thành công");
                          if (widget.firstLogin == true) {
                            if (mounted) {
                              context.go('/orders');
                            }
                          }
                        }
                      }),
                  const SizedBox(height: 35),
                ],
              );
            },
          ),
        ));
  }
}
