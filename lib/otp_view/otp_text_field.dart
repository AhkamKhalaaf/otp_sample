import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField(
      {Key? key,
      required this.context,
      required this.textEditingController,
      this.backGroundColor = Colors.white,
      required this.focusColorBorder,
      required this.enabledColorBorder,
      required this.borderRadius,
      required this.labelColor,
      required this.sizeScreen,
      required this.ownFocusNode,
      required this.nextFocusNode,
      required this.autoFocus})
      : super(key: key);
  final BuildContext context;
  final Color focusColorBorder;
  final Color enabledColorBorder;
  final Color backGroundColor;
  final double borderRadius;
  final Color labelColor;
  final bool autoFocus;
  final Size sizeScreen;
  final TextEditingController textEditingController;
  final FocusNode ownFocusNode;
  final FocusNode nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      width: sizeScreen.width * 0.15,
      child: TextFormField(
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
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },

        // onChanged: (value) {
        //   onChangeFunc(
        //       context: context,
        //       isFirstDigit: isFirst,
        //       isLastDigit: isLast,
        //       value: value);
        // },
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: labelColor),
        maxLength: 1,
        controller: textEditingController,
        decoration: InputDecoration(
            filled: true,
            fillColor: backGroundColor,
            contentPadding: const EdgeInsets.all(0.0),
            counter: const Offstage(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: focusColorBorder),
                borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: enabledColorBorder),
                borderRadius: BorderRadius.circular(borderRadius)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2.0, color: Colors.red),
                borderRadius: BorderRadius.circular(borderRadius)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2.0, color: Colors.red),
                borderRadius: BorderRadius.circular(borderRadius))),
      ),
    );
  }

  onChangeFunc(
      {required BuildContext context,
      required bool isFirstDigit,
      required bool isLastDigit,
      required String value}) {
    if (value.length == 1 && isLastDigit == false) {
      FocusScope.of(context).nextFocus();
    }
    if (value.isEmpty && isFirstDigit == false) {
      FocusScope.of(context).previousFocus();
    }
    if (value.length == 1 && isLastDigit == true) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
