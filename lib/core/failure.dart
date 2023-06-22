abstract class Failure {
  final dynamic e;
  final int statusCode;

  Failure({this.e, required this.statusCode});
}

class FirebaseAuthFailure extends Failure {
  FirebaseAuthFailure({dynamic e, required int statusCode})
      : super(e: e, statusCode: statusCode);
}

class UserNotFound extends Failure {
  UserNotFound({dynamic e, required int statusCode})
      : super(e: e, statusCode: statusCode);
}

class GeneralFailure extends Failure {
  GeneralFailure({dynamic e, required int statusCode})
      : super(e: e, statusCode: statusCode);
}
