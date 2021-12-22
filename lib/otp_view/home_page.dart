import 'package:flutter/material.dart';
import 'package:otp_sample/otp_view/otp_text_field.dart';
import 'opt_form_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: OptFormUi(
        numberDigits: 6,
        shape: OtpDigitShape.box,
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
