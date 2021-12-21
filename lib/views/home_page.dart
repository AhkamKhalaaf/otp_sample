import 'package:flutter/material.dart';

import 'opt_form_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OptFormUi(numberDigits: 7),
    );
  }
}
