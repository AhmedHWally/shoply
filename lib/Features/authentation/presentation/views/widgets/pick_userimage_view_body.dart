import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoply/Features/authentation/presentation/manager/userimage_cubit/user_image_cubit.dart';
import 'package:shoply/Features/home/presentation/views/home_view.dart';
import 'package:shoply/constans.dart';

class PickUserImageViewBody extends StatelessWidget {
  PickUserImageViewBody({super.key});
  bool isLoading = false;
  bool pickImageLoading = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: BlocProvider(
        create: (context) => UserImageCubit(),
        child: BlocConsumer<UserImageCubit, UserImageState>(
          listener: (context, state) {
            if (state is UserImageLoading) {
              isLoading = true;
            } else if (state is UserImagePicked) {
              isLoading = false;
            } else if (state is UserImageSkipped) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text('please pick an image or press the skip button')));
            } else if (state is UserImageSaved) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeView()));
            } else if (state is PickImageLoading) {
              pickImageLoading = true;
            } else {
              pickImageLoading = false;
            }
          },
          builder: (context, state) => ModalProgressHUD(
            inAsyncCall: pickImageLoading,
            opacity: 0,
            progressIndicator:
                const CircularProgressIndicator(color: Colors.white),
            child: SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.1, bottom: height * 0.05),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: kButtonColor,
                          )
                        : CircleAvatar(
                            radius: width < 600 ? width * 0.25 : width * 0.075,
                            backgroundColor: kButtonColor,
                            backgroundImage:
                                BlocProvider.of<UserImageCubit>(context)
                                            .pickedImage ==
                                        null
                                    ? null
                                    : FileImage(
                                        BlocProvider.of<UserImageCubit>(context)
                                            .pickedImage!)),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    height: height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: kButtonColor,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          BlocProvider.of<UserImageCubit>(context).pickImage();
                        },
                        child: const Text('pick image')),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.5,
                    height: height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: kButtonColor,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeView()));
                        },
                        child: const Text('Skip for now')),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  SizedBox(
                    width: width * 0.5,
                    height: height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            backgroundColor: kButtonColor,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          BlocProvider.of<UserImageCubit>(context)
                              .uploadImage();
                        },
                        child: const Text('Save and cotinue')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
