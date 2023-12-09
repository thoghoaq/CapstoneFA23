import 'package:capstone_fa23_customer/core/enums/shipping_progress.dart';
import 'package:capstone_fa23_customer/core/enums/transaction_status.dart';
import 'package:capstone_fa23_customer/core/models/order_model.dart';
import 'package:capstone_fa23_customer/helpers/datetime_helper.dart';
import 'package:capstone_fa23_customer/partials/modals/order_details.dart';
import 'package:capstone_fa23_customer/partials/contact_list_title.dart';
import 'package:capstone_fa23_customer/partials/progress_line.dart';
import 'package:capstone_fa23_customer/providers/orders_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TrackingOrderPage extends StatefulWidget {
  final String id;
  final bool isFeedback;
  const TrackingOrderPage(
      {super.key, required this.id, required this.isFeedback});

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  final _feedbackTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String get _orderName => "Đơn hàng ${widget.id}";
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: DAppBar(
          title: _orderName,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const DIconCircle(
                  icon: Icon(
                Icons.notifications,
                size: 16,
              )),
              color: Theme.of(context).colorScheme.background,
            ),
          ],
        ),
        body: FutureBuilder(
          future: provider.getOrder(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Đã có lỗi xảy ra"),
              );
            }
            Order data = snapshot.data!;
            ShippingProgress status = ShippingProgress.getMapTransactionStatus(
                data.currentOrderStatus);
            bool inProgress = [
              TransactionStatus.created,
              TransactionStatus.pickOff,
              TransactionStatus.processing,
              TransactionStatus.shipping
            ].contains(provider.order.currentOrderStatus);
            dynamic order = {
              "id": widget.id,
              // "icon": "assets/images/contexts/brand_1.png",
              "title": "Được gửi bởi ${data.senderName}",
              "subtitle": "${data.senderPhoneNumber}",
              "description": inProgress
                  ? "Ngày nhận dự kiến: ${DateTimeHelper.getDateTime(data.expectedShippingDate)}"
                  : "Đã nhận hàng",
              "status": data.currentOrderStatus,
              "note": data.note
            };
            return Consumer<OrderProvider>(
              builder: (context, value, child) {
                return Builder(builder: (context) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        const SizedBox(
                          height: 16,
                        ),
                        ContactListTile(
                          avatar: Image.asset(
                              "assets/images/contexts/avatar_2.png"),
                          title: "${provider.order.driverName} (Tài xế)",
                          subtitle: provider.order.driverPhoneNumber,
                        ),
                        if (provider.order.currentOrderStatus ==
                                TransactionStatus.delivered &&
                            widget.isFeedback)
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 32),
                                DAvatarCircle(
                                    image: Image.asset(
                                        "assets/images/contexts/avatar_2.png"),
                                    radius: 115),
                                const SizedBox(height: 16),
                                Text(
                                  "Để lại đánh giá của bạn về shipper",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 16),
                                RatingBar.builder(
                                  initialRating: rate,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: DColors.yellow,
                                  ),
                                  glow: false,
                                  unratedColor: DColors.gray5,
                                  onRatingUpdate: (rating) {
                                    rate = rating;
                                  },
                                ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  width: 337,
                                  child: DTextFormField(
                                      hintText: "Đánh giá",
                                      maxLines: 2,
                                      validator: (p0) {
                                        if (p0 == null || p0.isEmpty) {
                                          return "Vui lòng nhập đánh giá";
                                        }
                                        return null;
                                      },
                                      controller: _feedbackTextController),
                                ),
                                const SizedBox(height: 48),
                              ])
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 96),
                              SizedBox(
                                  width: 231, child: Image.asset(status.image)),
                              const SizedBox(height: 48),
                              Text(
                                status.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                              Text(
                                status.description,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ProgressLine(
                          percent: status.percent,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            children: [
                              if (order["icon"] != null)
                                DAvatarCircle(
                                    image: Image.asset(order["icon"]),
                                    radius: 41),
                              SizedBox(width: order["icon"] != null ? 16 : 0),
                              Expanded(
                                child: SizedBox(
                                  height: 66,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        order["title"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        order["subtitle"] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      Text(
                                        order["description"] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(color: DColors.gray3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (inProgress)
                                Container(
                                  width: 75,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: DColors.softGreen,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "20-30 Phút",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.apply(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        if (provider.order.currentOrderStatus ==
                                TransactionStatus.delivered &&
                            widget.isFeedback)
                          DOutlinedButton.small(
                            text: "Gửi đánh giá",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var r = int.parse(rate.toString()).toString();
                                await provider.feedBack(
                                    r, _feedbackTextController.text);
                              }
                            },
                          )
                        else
                          DOutlinedButton.small(
                            text: "Xem chi tiết",
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return OrderDetailsModal(
                                    order: order,
                                  );
                                },
                                isScrollControlled: true,
                              );
                            },
                          ),
                        const SizedBox(height: 32),
                      ]),
                    ),
                  );
                });
              },
            );
          },
        ));
  }
}
