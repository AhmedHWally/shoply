import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoply/Features/order/data/order_model.dart';
import 'package:shoply/Features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:shoply/constans.dart';
import 'package:shoply/core/widgets/mainApp_elevated_button.dart';

import '../../../../core/widgets/custom_text_field.dart';

import '../../../cart/data/models/cart_model.dart';
import '../../../cart/presentation/manager/cart_cubit/cart_cubit.dart';

class OrderViewBody extends StatelessWidget {
  OrderViewBody({super.key, required this.orderList});
  List<CartItem> orderList;
  static final GlobalKey<FormState> _orderKey = GlobalKey<FormState>();
  String? city, phone, userName;
  bool isLoading = false;

  Future<void> placeOrder(BuildContext ctx) async {
    _orderKey.currentState!.save();
    OrderModel orderData = OrderModel(
        userName: userName!,
        userAddress: city!,
        userPhoneNumber: phone!,
        total: BlocProvider.of<CartCubit>(ctx).total.toStringAsFixed(2),
        orderItems: orderList,
        dateOfOrder: DateTime.now());
    await BlocProvider.of<OrderCubit>(ctx).placeOrder(orderData);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderStart) {
          isLoading = true;
        } else if (state is OrderSuccess) {
          isLoading = false;
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            BlocProvider.of<CartCubit>(context).emptyCart();
                            Navigator.of(context).pop();
                          },
                          child: const Text('ok'))
                    ],
                    content: const Text(
                        'Your order is placed .. to check it please go to the user page'),
                  ));
        } else if (state is OrderConfirm) {
          isLoading = false;
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('no')),
                      TextButton(
                          onPressed: () async {
                            Navigator.of(ctx).pop();
                            await placeOrder(context);
                          },
                          child: const Text('yes')),
                    ],
                    content: const Text(
                        'are you sure you want to place the order ?'),
                  ));
        } else if (state is OrderFailed) {
          isLoading = false;
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('ok'))
                    ],
                    content: const Text('something went wrong'),
                  ));
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        opacity: 0,
        progressIndicator:
            const CircularProgressIndicator(color: kPrimaryColor),
        color: kPrimaryColor,
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please fill your information',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Form(
                key: _orderKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      hintText: 'user name',
                      textInputAction: TextInputAction.next,
                      iconShape: Icons.person,
                      onSaved: (name) {
                        userName = name;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      hintText: 'city',
                      textInputAction: TextInputAction.next,
                      iconShape: Icons.location_city,
                      onSaved: (location) {
                        city = location;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      hintText: 'phone number',
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      iconShape: Icons.phone,
                      onSaved: (phoneNumber) {
                        phone = phoneNumber;
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  height: height * 0.2,
                  width: width * 0.9,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: kPrimaryColor, width: 2)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Items:'),
                          Expanded(
                              child: ListView.builder(
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(orderList[index].title),
                                Text('x ${orderList[index].quantity}')
                              ],
                            ),
                            itemCount: orderList.length,
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total price:'),
                              Text(
                                  '${BlocProvider.of<CartCubit>(context).total.toStringAsFixed(2)} \$')
                            ],
                          )
                        ]),
                  )),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: width * 0.9,
                height: height * 0.075,
                child: MainAppElevatedButton(
                    title: 'Place order',
                    onPressed: () {
                      if (_orderKey.currentState!.validate()) {
                        _orderKey.currentState!.save();
                        BlocProvider.of<OrderCubit>(context).confirmOrder();
                      }
                    }),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('To cancel the order ->'),
                  SizedBox(
                    width: width * 0.25,
                    height: height * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: const Text(
                        'Go back',
                        style: TextStyle(
                            shadows: ([
                          Shadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(1, 1))
                        ])),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
