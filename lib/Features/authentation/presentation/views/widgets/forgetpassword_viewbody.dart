import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../constans.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../manager/auth_cubit/auth_cubit.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordStarted) {
            isLoading = true;
          } else if (state is ResetPasswordSuccessed) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('email sent successfully')));
          } else if (state is ResetPasswordFailed) {
            isLoading = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          } else {
            isLoading = false;
          }
        },
        builder: (context, state) => ModalProgressHUD(
          opacity: 0,
          progressIndicator:
              const CircularProgressIndicator(color: kPrimaryColor),
          inAsyncCall: isLoading,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 26,
                      ))
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                        height: height * 0.35,
                        child: Image.asset(
                          kResetPasswordImage,
                          fit: BoxFit.fill,
                        )),
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const Text(
                              'Receive an email to\nreset your password.',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              hintText: 'email',
                              iconShape: Icons.alternate_email_rounded,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                                width: width * 0.5,
                                height: height * 0.055,
                                child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        backgroundColor: kButtonColor),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .resetPassword(
                                                emailController.text);
                                      }
                                    },
                                    icon: const Icon(Icons.email),
                                    label: const Text('Reset password')))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
