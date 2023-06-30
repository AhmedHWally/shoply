import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:shoply/Features/authentation/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:shoply/Features/authentation/presentation/views/pick_userimage_view.dart';
import '../../../../../constans.dart';
import 'custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class SignUpViewBody extends StatelessWidget {
  SignUpViewBody({
    super.key,
  });
  static final GlobalKey<FormState> _formSignUpKey = GlobalKey<FormState>();
  String? email, password, username;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            isLoading = true;
          } else if (state is RegisterSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const PickUserImageView()));
            isLoading = false;
          } else if (state is RegisterFailure) {
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
                    kSignUpImage,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: width * 0.5,
                  child: const Divider(color: kPrimaryColor, thickness: 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formSignUpKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          textInputType: TextInputType.text,
                          onSaved: (currentusername) {
                            username = currentusername;
                            return null;
                          },
                          hintText: 'user name',
                          iconShape: Icons.person,
                          isSecure: false,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
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
                  text: 'SignUP',
                  onPressed: () async {
                    if (_formSignUpKey.currentState!.validate()) {
                      _formSignUpKey.currentState!.save();
                      await BlocProvider.of<AuthCubit>(context).registerUser(
                          email: email!,
                          password: password!,
                          username: username!);
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: width * 0.5,
                  child: const Divider(color: kPrimaryColor, thickness: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'SignIn now',
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
