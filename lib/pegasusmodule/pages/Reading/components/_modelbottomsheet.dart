import 'package:sample2/pegasusmodule/pages/Reading/provider/translator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final ButtonStyle raisedButton_choose_lang = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.transparent,
  padding: const EdgeInsets.symmetric(horizontal: 10),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

// ignore: camel_case_types
class modelbottomsheet extends StatefulWidget {
  const modelbottomsheet({Key? key}) : super(key: key);

  @override
  State<modelbottomsheet> createState() => _modelbottomsheetState();
}

// ignore: camel_case_types
class _modelbottomsheetState extends State<modelbottomsheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TranslatorData>(context);
    return SizedBox(
      height: 350,
      width: 200,
      child: Column(
        children: [
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Spacer(
                          flex: 5,
                        ),
                        Expanded(
                          child: Text(
                            "Vietnamese",
                          ),
                          flex: 3,
                        ),
                        Expanded(child: Icon(Icons.arrow_drop_down), flex: 1),
                        Spacer(
                          flex: 5,
                        )
                      ]),
                  style: raisedButton_choose_lang,
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                )),
            flex: 2,
          ),
          Expanded(
              flex: 15,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Text(provider.translatedData,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: "RobotoSlab",
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none)),
                ),
              )),
        ],
      ),
    );
  }
}
