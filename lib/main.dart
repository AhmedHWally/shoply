import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoply/Features/authentation/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:shoply/Features/authentation/presentation/views/login_view.dart';
import 'package:shoply/Features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:shoply/Features/favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:shoply/Features/home/presentation/manager/products_cubit/products_cubit.dart';
import 'package:shoply/Features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:shoply/Features/home/presentation/views/home_view.dart';

import 'Features/onBoarding/presentation/views/onboarding_view.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Features/order/presentation/manager/order_cubit/order_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  final isAuth = prefs.getString('isAuth') ?? '';
  runApp(MyApp(showHome: showHome, isAuth: isAuth));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.showHome, this.isAuth});
  final bool? showHome;
  final String? isAuth;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProductsCubit()),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        )
      ],
      child: MaterialApp(
        routes: {'login': (context) => const LoginView()},
        home: showHome as bool
            ? isAuth == ''
                ? const LoginView()
                : const HomeView()
            : const OnBoardingView(),
      ),
    );
  }
}
