import 'package:form_field_validator/form_field_validator.dart';

final streamTextValidator = MultiValidator([
  RequiredValidator(errorText: 'Stream name is required'),
]);

final streamPinTextValidator = MultiValidator([
  RequiredValidator(errorText: 'Stream pin is required'),
]);
