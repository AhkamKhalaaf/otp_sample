import 'package:flutter/material.dart';
import 'opt_form_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: OptFormUi(
        numberDigits: 12,
        backGroundColor: Colors.transparent,
        borderRadius: 5.0,
        enabledColorBorder: Colors.blue,
        focusColorBorder: Colors.amber,
        textColorVerifyButton: Colors.amber,
        verifyText: 'Send',
        backColorVerifyButton: Colors.green,
        formValueColor: Colors.deepPurpleAccent,
        textFormValueHintColor: Colors.cyan,
        textFormValueHint: 'your verification code : ',
        buttonAction: () {
          print('helllo');
        },
      ),
    );
  }
}
