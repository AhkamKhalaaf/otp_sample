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
        numberDigits:5,
        shape: OtpDigitShape.underline,
        backGroundColor: Colors.grey.withOpacity(0.125),
        borderRadius: 10.0,
        enabledColorBorder: Colors.blue,
        focusColorBorder: Colors.amber,
        textColorVerifyButton: Colors.amber,
        verifyText: 'Send',
        backColorVerifyButton: Colors.green,
        formValueColor: Colors.deepPurpleAccent,
        textFormValueHintColor: Colors.cyan,
        textFormValueHint: 'your verification code : ',
        buttonAction: () {
          // print('helllo');
        },
      ),
    );
  }
}
