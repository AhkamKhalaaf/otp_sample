import 'package:flutter/material.dart';
import 'otp_text_field.dart';

class OptFormUi extends StatefulWidget {
  const OptFormUi(
      {Key? key,
      required this.numberDigits,
      this.labelColor = Colors.black,
      this.backGroundColor = Colors.white,
      required this.enabledColorBorder,
      required this.focusColorBorder,
      this.borderRadius = 5.0,
      this.verifyText = 'Verify',
      this.backColorVerifyButton = Colors.blue,
      this.textColorVerifyButton = Colors.white,
      this.textFormValueHint = '',
      this.formValueColor = Colors.black,
      this.textFormValueHintColor = Colors.black,
      this.shape = OtpDigitShape.box,
      required this.buttonAction})
      : super(key: key);
  final int numberDigits;
  final Color focusColorBorder;
  final Color enabledColorBorder;
  final Color backGroundColor;
  final double borderRadius;
  final Color labelColor;
  final String verifyText;
  final Color backColorVerifyButton;
  final Color textColorVerifyButton;
  final Color formValueColor;
  final String textFormValueHint;
  final Color textFormValueHintColor;
  final Function buttonAction;
  final OtpDigitShape shape;

  @override
  State<OptFormUi> createState() => _OptFormUiState();
}

class _OptFormUiState extends State<OptFormUi> {
  List<TextEditingController> keysController = [];
  List<FocusNode> focusNodes = [];
  String valueText = '';
  final formKey = GlobalKey<FormState>();
 initValueText()
 {
   valueText='';
   setState(() {

   });
 }
  initFormControl(int numberDigits) {
    for (int i = 0; i < numberDigits; i++) {
      var textEdit = TextEditingController();
      keysController.add(textEdit);
      var focusNode$i = FocusNode();
      focusNodes.add(focusNode$i);
      textEdit.addListener(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFormControl(widget.numberDigits);
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
          left: sizeScreen.width * 0.05,
          right: sizeScreen.width * 0.05,
          top: sizeScreen.width * 0.1,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Wrap(
              children: List<Widget>.generate(widget.numberDigits, (index) {
                return OtpTextField( initValueTextFunc: (){
                  initValueText();
                },
                  keys: keysController,
                  validateAllValues: () {
                    findValueOfOtp();
                  },
                  shape: widget.shape,
                  previousFocusNode:
                      index == 0 ? FocusNode() : focusNodes[index - 1],
                  backGroundColor: widget.backGroundColor,
                  nextFocusNode: index == widget.numberDigits - 1
                      ? FocusNode()
                      : focusNodes[index + 1],
                  ownFocusNode: focusNodes[index],
                  labelColor: widget.labelColor,
                  textEditingController: keysController[index],
                  context: context,
                  //   isFirst: index == 0 ? true : false,
                  autoFocus: index == 0 ? true : false,
                  borderRadius: widget.borderRadius,
                  enabledColorBorder: widget.enabledColorBorder,
                  focusColorBorder: widget.focusColorBorder,
                  //  isLast: index == widget.numberDigits - 1 ? true : false,
                );
              }),
            ),
          ),
          SizedBox(
            height: sizeScreen.width * 0.05,
          ),
          RichText(
            text: TextSpan(
              text: widget.textFormValueHint,
              style: TextStyle(
                  color: widget.textFormValueHintColor,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: valueText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.formValueColor,
                        letterSpacing: 2.0)),
              ],
            ),
          ),
          SizedBox(
            height: sizeScreen.width * 0.05,
          ),
          MaterialButton(
            color: widget.backColorVerifyButton,
            onPressed: () {
              findValueOfOtp();
            },
            child: Text(
              widget.verifyText,
              style: TextStyle(color: widget.textColorVerifyButton),
            ),
          )
        ],
      ),
    );
  }

  findValueOfOtp() {
    FocusScope.of(context).unfocus();
    valueText = '';
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    for (var element in keysController) {
      valueText = valueText + element.text;
    }
    setState(() {});
    widget.buttonAction();
  }
}
