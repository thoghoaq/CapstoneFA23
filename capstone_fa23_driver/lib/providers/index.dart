import 'package:capstone_fa23_driver/providers/account_provider.dart';
import 'package:capstone_fa23_driver/providers/orders_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AccountProvider()),
  ChangeNotifierProvider(create: (_) => OrderProvider())
];
