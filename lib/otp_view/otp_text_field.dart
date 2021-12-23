import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    Key? key,
    required this.context,
    required this.textEditingController,
    this.backGroundColor = Colors.white,
    required this.focusColorBorder,
    required this.enabledColorBorder,
    required this.borderRadius,
    required this.labelColor,
    required this.ownFocusNode,
    required this.nextFocusNode,
    required this.autoFocus,
    required this.previousFocusNode,
    this.isLast,
    this.isFirst,
    this.shape = OtpDigitShape.box,
  }) : super(key: key);
  final BuildContext context;
  final Color focusColorBorder;
  final Color enabledColorBorder;
  final Color backGroundColor;
  final double borderRadius;
  final Color labelColor;
  final bool autoFocus;
  final TextEditingController textEditingController;
  final FocusNode ownFocusNode;
  final FocusNode nextFocusNode;
  final FocusNode previousFocusNode;
  final bool? isLast;
  final bool? isFirst;
  final OtpDigitShape shape;

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      width: sizeScreen.width * 0.125,
      child: TextFormField(
        inputFormatters: [OtpFormatter()],
        enabled: true,
        showCursor: false,
        validator: (value) {
          if (value!.isEmpty) {
            return '';
          }
          return null;
        },
        focusNode: ownFocusNode,
        autofocus: true,
        textInputAction: TextInputAction.next,
        readOnly: false,
        onChanged: (value) {
          //print('${value},,,vvv');

          onChangeFunc(
              textEditingController: textEditingController,
              context: context,
              //isFirstDigit: isFirst,
              //  isLastDigit: isLast,
              nextFocus: nextFocusNode,
              previousFocus: previousFocusNode,
              value: value);
        },
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: labelColor),
        //   maxLength: 2,
        controller: textEditingController,
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: backGroundColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            counter: const Offstage(),
            focusedBorder: shape == OtpDigitShape.underline
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: focusColorBorder))
                : shape == OtpDigitShape.circle
                    ? OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: focusColorBorder),
                        borderRadius: BorderRadius.circular(25.0))
                    : OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: focusColorBorder),
                        borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: shape == OtpDigitShape.underline
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: enabledColorBorder))
                : shape == OtpDigitShape.circle
                    ? OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: enabledColorBorder),
                        borderRadius: BorderRadius.circular(25.0))
                    : OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: enabledColorBorder),
                        borderRadius: BorderRadius.circular(borderRadius)),
            focusedErrorBorder: shape == OtpDigitShape.underline
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))
                : shape == OtpDigitShape.circle
                    ? OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2.0, color: Colors.red),
                        borderRadius: BorderRadius.circular(25.0))
                    : OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2.0, color: Colors.red),
                        borderRadius: BorderRadius.circular(borderRadius)),
            errorBorder: shape == OtpDigitShape.underline
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))
                : shape == OtpDigitShape.circle
                    ? OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2.0, color: Colors.red),
                        borderRadius: BorderRadius.circular(25.0))
                    : OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2.0, color: Colors.red),
                        borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }

  onChangeFunc(
      {required BuildContext context,
      required FocusNode nextFocus,
      required FocusNode previousFocus,
      required TextEditingController textEditingController,
      required String value}) {
    String value = textEditingController.text;

    if (value.isEmpty) {
      // request focus for the previous "box"
      FocusScope.of(context).requestFocus(previousFocus);
      return;
    }
    // request focus for the next "box"
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

enum OtpDigitShape { box, underline, circle }

class OtpFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    try{ return oldValue.copyWith(text: newValue.text.characters.last.trim());}
    catch(e){
      return oldValue;
    }

  }
}
