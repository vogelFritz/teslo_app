import 'package:formz/formz.dart';

enum FullNameError { used }

class FullName extends FormzInput<String, FullNameError> {
  const FullName.pure() : super.pure('');

  @override
  FullNameError? validator(String value) {
    // TODO: implement validator
    throw UnimplementedError();
  }
}
