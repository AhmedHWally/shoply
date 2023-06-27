import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoply/Features/authentation/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:shoply/Features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:shoply/Features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'package:shoply/Features/user/presentation/userOrders_view.dart';
import 'package:shoply/constans.dart';
import 'package:shoply/core/widgets/custom_text.dart';

import '../../../../core/widgets/mainApp_elevated_button.dart';
import '../../../authentation/presentation/views/login_view.dart';

class UserViewBody extends StatelessWidget {
  const UserViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SizedBox(
        width: width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: CachedNetworkImage(
                  imageUrl: BlocProvider.of<AuthCubit>(context)
                              .currentlyLogedInUser
                              .image ==
                          ''
                      ? 'https://i.pinimg.com/736x/7c/ee/6f/7cee6fa507169843e3430a90dd5377d4.jpg'
                      : BlocProvider.of<AuthCubit>(context)
                          .currentlyLogedInUser
                          .image,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    backgroundImage: imageProvider,
                    radius: width < 650
                        ? MediaQuery.of(context).size.width * 0.25
                        : MediaQuery.of(context).size.width * 0.1,
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(color: kPrimaryColor),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              CustomContainer(
                subtitle: 'user name:',
                title: BlocProvider.of<AuthCubit>(context)
                    .currentlyLogedInUser
                    .name,
              ),
              CustomContainer(
                subtitle: 'email:',
                title: BlocProvider.of<AuthCubit>(context)
                    .currentlyLogedInUser
                    .email,
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: height * 0.075,
                    width: width * 0.9,
                    child: MainAppElevatedButton(
                      title: 'My Orders',
                      onPressed: () {
                        BlocProvider.of<OrderCubit>(context).getUserOrders();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserOrdersView()));
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                    height: height * 0.075,
                    width: width * 0.9,
                    child: MainAppElevatedButton(
                      title: 'log out',
                      onPressed: () async {
                        FirebaseAuth.instance.signOut();
                        BlocProvider.of<CartCubit>(context).cartItems.clear();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                        );
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('isAuth');
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      height: height * 0.075,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black),
          ),
          SizedBox(width: width * 0.05),
          Expanded(child: CustomTextBuilder(title: title))
        ],
      ),
    );
  }
}
