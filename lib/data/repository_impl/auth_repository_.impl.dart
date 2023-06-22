import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petdopter/core/core.dart';
import 'package:petdopter/data/models/user_model.dart';
import 'package:petdopter/domain/entities/user_entity.dart';
import 'package:petdopter/domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositroyImpl implements AuthRepositroy {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthRepositroyImpl();

  @override
  Future<Either<UserEntity, Failure>> signInWithGmail() async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? firebaseUser = userCred.user;
      // .user;
      if (firebaseUser != null) {
        return left(UserModel(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          profileImage: firebaseUser.photoURL ?? '',
        ));
      } else {
        return right(UserNotFound(e: '', statusCode: 404));
      }
    } catch (e) {
      return right(FirebaseAuthFailure(statusCode: 500, e: e));
    }
  }

  @override
  Future<Either<bool, Failure>> loggOut() async {
    try {
      await googleSignIn.signOut();
      return left(true);
    } catch (e) {
      return right(GeneralFailure(statusCode: 200));
    }
  }
}
