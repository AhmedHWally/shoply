import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoply/Features/authentation/presentation/views/login_view.dart';
import 'package:shoply/constans.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/widgets/custom_text_button.dart';

class OnBoardingButtonsSection extends StatelessWidget {
  const OnBoardingButtonsSection({
    super.key,
    required this.height,
    required this.onBoardingController,
    required this.isLastPage,
    required this.width,
  });

  final double height;
  final double width;
  final PageController onBoardingController;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      width: width,
      height: height * 0.09,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: isLastPage
            ? CustomTextButton(
                buttonTitle: 'Get Started',
                onPressed: () async {
                  precacheImage(const AssetImage(kLoginImage), context);

                  precacheImage(const AssetImage(kGoogleLogo), context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginView()));
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                },
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextButton(
                      onPressed: () => onBoardingController.animateToPage(2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      buttonTitle: 'Skip'),
                  Center(
                    child: SmoothPageIndicator(
                      controller: onBoardingController,
                      count: 3,
                      effect: const WormEffect(
                        dotColor: Colors.black26,
                        spacing: 16,
                        activeDotColor: kPrimaryColor,
                      ),
                      onDotClicked: (index) =>
                          onBoardingController.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut),
                    ),
                  ),
                  CustomTextButton(
                      onPressed: () => onBoardingController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      buttonTitle: 'Next')
                ],
              ),
      ),
    );
  }
}
