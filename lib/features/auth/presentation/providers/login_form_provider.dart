import 'package:teslo_shop/features/shared/shared.dart';

class LoginFormState {
  final bool isPosting;
  final bool isFromPosted;
  final bool isValid;
  final Email email;
  final Password password;
  LoginFormState(
      {this.isPosting = false,
      this.isFromPosted = false,
      this.isValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure()});
}
