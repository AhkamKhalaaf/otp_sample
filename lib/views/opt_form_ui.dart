import 'package:flutter/material.dart';

import 'otp_text_field.dart';

class OptFormUi extends StatefulWidget {
  const OptFormUi({Key? key,
    required this.numberDigits,
    required this.labelColor,
    this.backGroundColor = Colors.white,
    required this.enabledColorBorder,
    required this.focusColorBorder,
    required this.borderRadius})
      : super(key: key);
  final int numberDigits;
  final Color focusColorBorder;
  final Color enabledColorBorder;
  final Color backGroundColor;
  final double borderRadius;
  final Color labelColor;

  @override
  State<OptFormUi> createState() => _OptFormUiState();
}

class _OptFormUiState extends State<OptFormUi> {
  List<TextEditingController> keysController = [];
  List<FocusNode> focusNodes = [];
  String valueText = '';
  final formKey = GlobalKey<FormState>();

  initControllers(int numberDigits) {
    for (int i = 0; i < numberDigits; i++) {
      var focusNode$i = FocusNode();
      keysController.add(TextEditingController());
      focusNodes.add(focusNode$i);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initControllers(widget.numberDigits);
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery
        .of(context)
        .size;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(sizeScreen.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: sizeScreen.width * 0.2,
                child: Form(
                  key: formKey,
                  child: Wrap(
                    children:
                    List<Widget>.generate(widget.numberDigits, (index) {
                      return OtpTextField(backGroundColor: widget.backGroundColor,
                          nextFocusNode: index == widget.numberDigits - 1 ?FocusNode():focusNodes[index+1],
                          ownFocusNode: focusNodes[index],
                          labelColor: widget.labelColor,
                          textEditingController: keysController[index],
                          context: context,
                          //isFirst: index == 0 ? true : false,
                          autoFocus: index == 0 ? true : false,
                          borderRadius: widget.borderRadius,
                          enabledColorBorder: widget.enabledColorBorder,
                          focusColorBorder: widget.focusColorBorder,
                          //   isLast: index == widget.numberDigits - 1 ? true : false,
                          sizeScreen: sizeScreen);
                    }),
                  ),
                )),
            SizedBox(
              height: sizeScreen.width * 0.025,
            ),
            SizedBox(
              height: sizeScreen.width * 0.025,
            ),
            Text(valueText),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                findValueOfOtp();
              },
              child: const Text('verify'),
            )
          ],
        ),
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
  }
}
