import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  return RegisterFormNotifier();
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  onEmailChanged() {}
  onPasswordChanged() {}
  onFullNameChanged() {}
  onFormSubmit() {}
}

class RegisterFormState {}
