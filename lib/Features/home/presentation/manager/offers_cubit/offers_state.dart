part of 'offers_cubit.dart';

@immutable
abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersSuccess extends OffersState {
  final List<String> imagesUrls;
  OffersSuccess(this.imagesUrls);
}

class OffersFaliure extends OffersState {}
