import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/api/payment_service.dart';
import 'package:rs_books/api/ship_order_service.dart';
import 'package:rs_books/controllers/address_controller.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/data/order.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/models/address_model.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/styled_widgets/buttons/styled_buttons.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/centered_view.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool errorHappend = false;
  bool orderInProgress = false;
  Order _createOrder(String orderId, double orderTotal, AddressModel address) {
    final orderCreationTime = DateTime.now();
    final Order order = Order(
      orderId: orderId,
      orderCreationTime: orderCreationTime,
      orderTotal: orderTotal,
      address: address,
    );
    return order;
  }

  @override
  Widget build(BuildContext context) {
    final paymentService = PayementService();
    final shipOrderService = ShipOrder();
    final AppTheme theme = context.watch();
    final isSmallestScreen = ResponsiveWidget.isSmallestScreen(context);
    return Consumer<CartController>(
      builder: (BuildContext context, CartController cart, Widget? child) {
        return Consumer<AddressController>(
          builder: (
            BuildContext context,
            AddressController addressController,
            Widget? child,
          ) {
            return CenteredView(
              child: Card(
                child: orderInProgress == true
                    ? const CircularProgressIndicator()
                    : Container(
                        constraints: const BoxConstraints(
                          maxWidth: 800,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Order Summary',
                                style: TextStyles.h3,
                              ),
                            ),
                            Divider(
                              thickness: 2,
                              color: theme.accent1,
                            ),
                            VSpace.sm,
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                margin: EdgeInsets.all(Insets.med),
                                child: Padding(
                                  padding: EdgeInsets.all(Insets.med),
                                  child: Flex(
                                    direction: isSmallestScreen
                                        ? Axis.vertical
                                        : Axis.horizontal,
                                    mainAxisAlignment: isSmallestScreen
                                        ? MainAxisAlignment.spaceAround
                                        : MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: isSmallestScreen ? 0 : 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Shipping Details:',
                                              style: TextStyles.title1.copyWith(
                                                color: theme.greyMedium,
                                              ),
                                            ),
                                            VSpace.xs,
                                            Text(
                                              addressController.address
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyles.body1,
                                            ),
                                            VSpace.sm,
                                            SecondaryButton(
                                              onPressed: () {
                                                context
                                                    .goNamed(CheckOutPageRoute);
                                              },
                                              label: 'Edit Address',
                                              backgroundColor: theme.accent1
                                                  .withOpacity(0.8),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isSmallestScreen) VSpace.med,
                                      SizedBox(
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Text(
                                              'Order Total',
                                              style: TextStyles.title1.copyWith(
                                                color: theme.greyMedium,
                                              ),
                                            ),
                                            VSpace.xs,
                                            SizedBox(
                                              child: Text(
                                                '₹ ${cart.total}',
                                                style: TextStyles.h3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                VSpace.lg,
                                PrimaryButton(
                                  onPressed: () async {
                                    try {
                                      setState(() {
                                        errorHappend = false;
                                        orderInProgress = true;
                                      });
                                      final receiptId =
                                          '#${addressController.currentAddress!.contactNo!}${DateTime.now().microsecond}';
                                      // a new orderId != receiptId is returned by razropay
                                      // creates a order entity on razorpay
                                      final String orderId =
                                          await paymentService.createOrder(
                                        cart.total,
                                        receiptId,
                                      );
                                      if (orderId.isNotEmpty) {
                                        // creates local order object
                                        final order = _createOrder(
                                          orderId,
                                          cart.total,
                                          addressController.currentAddress!,
                                        );
                                        paymentService.executeOrder(
                                          order,
                                          onSuccess: (
                                            Map<String, dynamic> paymentInfo,
                                          ) async {
                                            final trackingId =
                                                await shipOrderService
                                                    .createQuickShipment(
                                              order,
                                              cart,
                                              paymentInfo,
                                            );
                                            setState(() {
                                              orderInProgress = false;
                                            });
                                            context.goNamed(
                                              OrderSuccessPageRoute,
                                              extra: trackingId,
                                            );
                                            cart.clearCart();
                                          },
                                          onCancel: () {
                                            setState(() {
                                              orderInProgress = false;
                                            });
                                          },
                                          onFailure: () {
                                            setState(() {
                                              errorHappend = true;
                                              orderInProgress = false;
                                            });
                                          },
                                        );
                                      } else {
                                        setState(() {
                                          errorHappend = true;
                                          orderInProgress = false;
                                        });
                                      }
                                    } on Exception catch (e) {
                                      print('error #### $e');
                                      setState(() {
                                        errorHappend = false;
                                        orderInProgress = true;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      Insets.sm,
                                    ),
                                    child: Text(
                                      "MAKE PAYMENT",
                                      style: TextStyles.h2,
                                    ),
                                  ),
                                ),
                                VSpace.sm,
                                Visibility(
                                  visible: errorHappend,
                                  child: Text(
                                    "Order failed, Please try again!",
                                    style: TextStyles.callout1
                                        .copyWith(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                            // const Spacer(),
                          ],
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
