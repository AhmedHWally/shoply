import 'package:flutter/material.dart';
import 'package:shoply/Features/home/presentation/views/widgets/searchview_body.dart';

import '../../../../constans.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kBackGroundImage), fit: BoxFit.cover)),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SearchViewBody(),
        ));
  }
}
