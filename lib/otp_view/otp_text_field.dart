import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextField extends StatefulWidget {
  const OtpTextField(
      {Key? key,
      required this.context,
      required this.textEditingController,
      this.backGroundColor = Colors.white,
      required this.focusColorBorder,
      required this.enabledColorBorder,
      required this.borderRadius,
      required this.labelColor,
      required this.ownFocusNode,
      required this.nextFocusNode,
      required this.previousFocusNode,
      this.shape = OtpDigitShape.rectangle,
      required this.keys,
      required this.validateAllValues,
      required this.initValueTextFunc,
      required this.firstFocus})
      : super(key: key);
  final BuildContext context;
  final Color focusColorBorder;
  final Color enabledColorBorder;
  final Color backGroundColor;
  final double borderRadius;
  final Color labelColor;
  final TextEditingController textEditingController;
  final FocusNode ownFocusNode;
  final FocusNode nextFocusNode;
  final FocusNode previousFocusNode;
  final OtpDigitShape shape;
  final List<TextEditingController> keys;
  final Function validateAllValues;
  final Function initValueTextFunc;
  final FocusNode firstFocus;

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  KeyEventResult onKey(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace
        && widget.textEditingController.text.isEmpty
        ) {
      FocusScope.of(context).requestFocus(widget.previousFocusNode);

      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          left: sizeScreen.width * 0.025, right: sizeScreen.width * 0.025),
      width: widget.shape == OtpDigitShape.rectangle
          ? sizeScreen.width * 0.12
          : sizeScreen.width * 0.14,
      child: Focus(
        onKey: onKey,
        child: TextFormField(
          onTap: () {
            onTapFunction();
          },
          inputFormatters: <TextInputFormatter>[
            OtpFormatter(),
            FilteringTextInputFormatter.digitsOnly,
          ],
          enabled: true,
          showCursor: false,
          validator: (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
          focusNode: widget.ownFocusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: true,
          textInputAction: TextInputAction.next,
          readOnly: false,
          onChanged: (value) {
            onChangeFunc(
              textEditingController: widget.textEditingController,
              context: context,
              nextFocus: widget.nextFocusNode,
              previousFocus: widget.previousFocusNode,
            );
            autoSendValues();
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: widget.labelColor),
          controller: widget.textEditingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: widget.backGroundColor,
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.shape == OtpDigitShape.circle ? 10.0 : 15.0,
              ),
              counter: const Offstage(),
              focusedBorder: widget.shape == OtpDigitShape.underline
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.focusColorBorder))
                  : widget.shape == OtpDigitShape.circle
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.0, color: widget.focusColorBorder),
                          borderRadius: BorderRadius.circular(100.0))
                      : OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.0, color: widget.focusColorBorder),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
              enabledBorder: widget.shape == OtpDigitShape.underline
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.enabledColorBorder))
                  : widget.shape == OtpDigitShape.circle
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.0, color: widget.enabledColorBorder),
                          borderRadius: BorderRadius.circular(100.0))
                      : OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.0, color: widget.enabledColorBorder),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
              focusedErrorBorder: widget.shape == OtpDigitShape.underline
                  ?   UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.focusColorBorder))
                  : widget.shape == OtpDigitShape.circle
                      ? OutlineInputBorder(
                          borderSide:
                                BorderSide(width: 1.0, color:widget.focusColorBorder),
                          borderRadius: BorderRadius.circular(100.0))
                      : OutlineInputBorder(
                          borderSide:
                                BorderSide(width: 1.0, color: widget.focusColorBorder),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
              errorBorder: widget.shape == OtpDigitShape.underline
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))
                  : widget.shape == OtpDigitShape.circle
                      ? OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1.0, color: Colors.red),
                          borderRadius: BorderRadius.circular(100.0))
                      : OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1.0, color: Colors.red),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))),
        ),
      ),
    );
  }

  onChangeFunc({
    required BuildContext context,
    required FocusNode nextFocus,
    required FocusNode previousFocus,
    required TextEditingController textEditingController,
  }) {
    String value = textEditingController.text;

    if (value.isEmpty) {
      // request focus for the previous "box"
      FocusScope.of(context).requestFocus(previousFocus);
      textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));
      return;
    }
    // request focus for the next "box"
    FocusScope.of(context).requestFocus(nextFocus);
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
  }

  void onTapFunction() {
    widget.textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.textEditingController.text.length));
  }

  void autoSendValues() {
    int indexItem = 0;
    for (int i = 0; i < widget.keys.length; i++) {
      if (widget.keys[i].text != '') {
        indexItem = indexItem + 1;
      }
    }
    if (indexItem == widget.keys.length) {
      widget.validateAllValues();
    }
    if (indexItem == 0) {
      widget.initValueTextFunc();
      FocusScope.of(context).requestFocus(widget.firstFocus);
    }
  }
}

enum OtpDigitShape { rectangle, underline, circle }

class OtpFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      final intValue =
          int.parse(newValue.text.replaceAll(RegExp('[^0-9]'), ''));
      return oldValue.copyWith(
          text: intValue.toString().characters.last.trim());
    } catch (e) {
      return oldValue.copyWith(text: "");
    }
  }
}
