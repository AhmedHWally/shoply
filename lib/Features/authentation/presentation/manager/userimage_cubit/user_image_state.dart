part of 'user_image_cubit.dart';

@immutable
abstract class UserImageState {}

class UserImageInitial extends UserImageState {}

class UserImageLoading extends UserImageState {}

class PickImageLoading extends UserImageState {}

class UserImagePicked extends UserImageState {}

class UserImageSkipped extends UserImageState {}

class UserImageSaved extends UserImageState {}
