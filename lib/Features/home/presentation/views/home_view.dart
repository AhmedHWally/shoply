import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply/Features/authentation/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:shoply/Features/cart/presentation/views/cart_view.dart';
import 'package:shoply/Features/home/presentation/views/widgets/homeview_body.dart';
import 'package:shoply/Features/home/presentation/manager/products_cubit/products_cubit.dart';
import 'package:shoply/Features/user/presentation/user_view.dart';
import '../../../../constans.dart';
import '../manager/offers_cubit/offers_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;
  final screens = [const HomeViewBody(), const CartView(), const UserView()];
  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).loadProducts();
    BlocProvider.of<AuthCubit>(context).getUserData();
    BlocProvider.of<OffersCubit>(context).loadOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final items = <Widget>[
      Icon(
        Icons.home,
        color: Colors.white,
        shadows: [buildShadow()],
      ),
      Icon(
        Icons.shopping_cart,
        color: Colors.white,
        shadows: [buildShadow()],
      ),
      Icon(
        Icons.person,
        color: Colors.white,
        shadows: [buildShadow()],
      ),
    ];
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kBackGroundImage), fit: BoxFit.fill)),
        child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: CurvedNavigationBar(
              onTap: (currentIndex) {
                if (currentIndex == 1) {
                  precacheImage(const AssetImage(kAddToCartImage), context);
                }
                setState(() => index = currentIndex);
              },
              items: items,
              height: 50,
              backgroundColor: Colors.transparent,
              color: kSecondaryColor,
            ),
            backgroundColor: Colors.transparent,
            body: screens[index]));
  }

  Shadow buildShadow() =>
      const Shadow(offset: Offset(1, 1), color: kIconCollor, blurRadius: 1);
}
