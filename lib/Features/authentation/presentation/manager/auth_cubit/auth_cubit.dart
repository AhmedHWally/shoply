import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoply/Features/authentation/data/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final firebasefirestore = FirebaseFirestore.instance;
  UserModel currentlyLogedInUser = UserModel(name: '', email: '');
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      prefs.setString('isAuth', user.user!.uid);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      prefs.setString('isAuth', '');
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong password'));
      } else if (ex.code == 'invalid-email') {
        emit(LoginFailure(errorMessage: 'invalid-email'));
      } else if (ex.code == 'network-request-failed') {
        emit(LoginFailure(errorMessage: 'network failure'));
      }
    } catch (e) {
      prefs.setString('isAuth', '');
      emit(LoginFailure(errorMessage: 'some thing went wrong'));
    }
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required String username}) async {
    emit(RegisterLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      firebasefirestore.collection('favorites').doc(user.user!.uid).set({});
      firebasefirestore
          .collection('users')
          .doc(user.user!.uid)
          .set({'email': email, 'username': username, 'imageUrl': ''});
      prefs.setString('isAuth', user.user!.uid);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      prefs.setString('isAuth', '');
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'weak password'));
      } else if (ex.code == 'invalid-email') {
        emit(RegisterFailure(errorMessage: 'invalid-email'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'email already exists'));
      } else if (ex.code == 'network-request-failed') {
        emit(RegisterFailure(errorMessage: 'network failure'));
      }
    } catch (e) {
      prefs.setString('isAuth', '');
      emit(RegisterFailure(errorMessage: 'some thing went wrong'));
    }
  }

  Future<void> getUserData() async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    var snapshot = await firebasefirestore.collection('users').doc(user).get();
    Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
    UserModel currentUser = UserModel(
        name: userData['username'],
        email: userData['email'],
        image: userData['imageUrl']);
    currentlyLogedInUser = currentUser;
  }

  Future<void> resetPassword(String email) async {
    try {
      emit(ResetPasswordStarted());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      emit(ResetPasswordSuccessed());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(ResetPasswordFailed(errMessage: 'user not found'));
      } else if (ex.code == 'invalid-email') {
        emit(ResetPasswordFailed(errMessage: 'invalid-email'));
      }
    } catch (e) {
      emit(ResetPasswordFailed(errMessage: 'some thing went wrong'));
    }
  }
}
