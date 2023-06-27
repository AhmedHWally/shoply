import 'package:flutter/material.dart';
import 'package:shoply/Features/user/presentation/widgets/user_view_body.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.transparent, body: UserViewBody());
  }
}
