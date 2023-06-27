import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:shoply/Features/authentation/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:shoply/Features/authentation/presentation/views/forgetpassword_view.dart';
import 'package:shoply/Features/authentation/presentation/views/signup_view.dart';

import 'package:shoply/Features/home/presentation/views/home_view.dart';
import 'package:shoply/constans.dart';
import 'package:shoply/core/utils/custom_page_route.dart';
import 'custom_elevated_button.dart';
import 'custom_or_row.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({
    super.key,
  });
  static final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
  bool isLoading = false;

  String? email, password;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeView()));
            isLoading = false;
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            isLoading = false;
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            opacity: 0,
            progressIndicator:
                const CircularProgressIndicator(color: kPrimaryColor),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: height * 0.375,
                  width: width,
                  child: Image.asset(
                    kLoginImage,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Form(
                    key: _formLoginKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          textInputType: TextInputType.emailAddress,
                          onSaved: (userEmail) {
                            email = userEmail;
                            return null;
                          },
                          hintText: 'email',
                          iconShape: Icons.alternate_email,
                          isSecure: false,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          textInputType: TextInputType.visiblePassword,
                          onSaved: (userPassword) {
                            password = userPassword;
                            return null;
                          },
                          hintText: 'password',
                          iconShape: Icons.lock,
                          isSecure: true,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  width: width,
                  height: height,
                  text: 'Login',
                  onPressed: () async {
                    if (_formLoginKey.currentState!.validate()) {
                      _formLoginKey.currentState!.save();
                      await BlocProvider.of<AuthCubit>(context)
                          .loginUser(email: email!, password: password!);
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgetPasswordView()));
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: kPrimaryColor, fontSize: 16),
                    )),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: width * 0.3,
                  child: const CustomORRow(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: width * 0.05,
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage(kGoogleLogo),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                          radius: width * 0.05,
                          backgroundImage: const AssetImage(kFaceBookLogo)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          precacheImage(
                              const AssetImage(kSignUpImage), context);
                          Navigator.of(context).push(
                              CustomAuthPageRoute(child: const SignUpView()));
                        },
                        child: const Text(
                          'Signup now',
                          style: TextStyle(color: kPrimaryColor),
                        ))
                  ],
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
