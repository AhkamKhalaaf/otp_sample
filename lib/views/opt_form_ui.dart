import 'package:flutter/material.dart';

class OptFormUi extends StatefulWidget {
  const OptFormUi({Key? key, required this.numberDigits}) : super(key: key);
  final int numberDigits;

  @override
  State<OptFormUi> createState() => _OptFormUiState();
}

class _OptFormUiState extends State<OptFormUi> {
  List<TextEditingController> keysController = [];
  String valueText = '';
  final formKey = GlobalKey<FormState>();

  initControllers(int numberDigits) {
    for (int i = 0; i < numberDigits; i++) {
      keysController.add(TextEditingController());
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
    Size sizeScreen = MediaQuery.of(context).size;

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
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.numberDigits,
                      itemBuilder: (context, index) {
                        return otpTextField(
                            textEditingController: keysController[index],
                            context: context,
                            isFirst: index == 0 ? true : false,
                            autoFocus: index == 0 ? true : false,
                            borderRadius: 12.0,
                            enabledColorBorder: Colors.blue,
                            focusColorBorder: Colors.green,
                            isLast:
                                index == widget.numberDigits - 1 ? true : false,
                            textInputType: TextInputType.number,
                            sizeScreen: sizeScreen);
                      }),
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

  Widget otpTextField(
      {required BuildContext context,
      required textInputType,
      required focusColorBorder,
      required borderRadius,
      required enabledColorBorder,
      required isLast,
      required autoFocus,
      required isFirst,
      required sizeScreen,
      required textEditingController}) {
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
        autofocus: true,
        showCursor: false,
        readOnly: false,
        onChanged: (value) {
          onChangeFunc(
              context: context,
              isFirstDigit: isFirst,
              isLastDigit: isLast,
              value: value);
        },
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        keyboardType: textInputType,
        maxLength: 1,
        controller: textEditingController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0.0),
            counter: const Offstage(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: focusColorBorder),
                borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: enabledColorBorder),
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
