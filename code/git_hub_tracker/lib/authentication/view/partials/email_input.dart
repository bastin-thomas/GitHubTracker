import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:git_hub_tracker/core/view/partials/text_input.dart';

class EmailInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  const EmailInput({this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextInput(
      value: "thomas.bastin@student.hepl.be",
      icon: Icons.mail,
      labelText: 'Votre email',
      hintText: 'exemple@mail.com',
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'L’adresse mail doit être renseignée.';
        } else if (!EmailValidator.validate(value)) {
          return 'L’adresse mail doit être une adresse mail valide.';
        }
      },
      onChanged: onChanged,
    );
  }
}
