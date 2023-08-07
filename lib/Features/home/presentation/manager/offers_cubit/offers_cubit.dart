import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());
  final offersCollection = FirebaseFirestore.instance;
  // ignore: prefer_final_fields
  List<String> _offerImagesUrls = [];
  void loadOffers() async {
    try {
      emit(OffersLoading());
      QuerySnapshot offerImages =
          await offersCollection.collection('offers').get();
      for (var doc in offerImages.docs) {
        _offerImagesUrls
            .add((doc.data() as Map<String, dynamic>)['offerImageUrl']);
      }
      print([..._offerImagesUrls]);
      emit(OffersSuccess([..._offerImagesUrls]));
    } on FirebaseException catch (e) {
      emit(OffersFaliure());
      print(e);
    } catch (e) {
      emit(OffersFaliure());
    }
  }
}
