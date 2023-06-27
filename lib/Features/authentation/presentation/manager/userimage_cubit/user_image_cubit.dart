import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'user_image_state.dart';

class UserImageCubit extends Cubit<UserImageState> {
  UserImageCubit() : super(UserImageInitial());
  XFile? imageData;
  File? pickedImage;
  final firebasefirestore = FirebaseFirestore.instance;
  Future<void> pickImage() async {
    emit(UserImageLoading());
    try {
      final picker = ImagePicker();
      imageData = await picker.pickImage(
          source: ImageSource.gallery, maxWidth: 512, maxHeight: 512);
      pickedImage = File((imageData as XFile).path);

      emit(UserImagePicked());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadImage() async {
    if (pickedImage == null) {
      emit(UserImageSkipped());
      return;
    } else {
      try {
        emit(PickImageLoading());
        String user = FirebaseAuth.instance.currentUser!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child("$user.jpg");
        await ref.putFile(pickedImage!);
        final url = await ref.getDownloadURL();
        firebasefirestore
            .collection('users')
            .doc(user)
            .update({'imageUrl': url});
        emit(UserImageSaved());
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }
}
