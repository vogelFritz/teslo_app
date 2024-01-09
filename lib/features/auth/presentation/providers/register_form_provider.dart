import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;
  RegisterFormNotifier(this.registerUserCallback) : super(RegisterFormState());

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state.copyWith(
        email: newEmail,
        isValid: Formz.validate([newEmail, state.password, state.fullName]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email, state.fullName]));
  }

  onFullNameChanged(String value) {
    final newFullName = FullName.dirty(value);
    state.copyWith(
        fullName: newFullName,
        isValid: Formz.validate([newFullName, state.email, state.password]));
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    await registerUserCallback(
        state.email.value, state.password.value, state.fullName.value);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final fullName = FullName.dirty(state.fullName.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        fullName: fullName,
        isValid: Formz.validate([email, password, fullName]));
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FullName fullName;
  final Email email;
  final Password password;

  RegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.fullName = const FullName.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure()});

  copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          FullName? fullName,
          Email? email,
          Password? password}) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          fullName: fullName ?? this.fullName,
          email: email ?? this.email,
          password: password ?? this.password);

  @override
  String toString() {
    return '''
RegisterFormState:
  isPosting: $isPosting
  isFormPosted: $isFormPosted
  isValid: $isValid
  fullName: $fullName
  email: $email
  password: $password
''';
  }
}
