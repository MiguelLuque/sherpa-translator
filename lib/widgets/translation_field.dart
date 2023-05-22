import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TranslationField extends StatelessWidget {
  final String? text;
  final bool isEnabled;
  final TextEditingController controller;

  const TranslationField(
      {required this.controller, required this.isEnabled, this.text, Key? key})
      : super(key: key);

  //use text

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width / 2 - 200,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            color: Colors.grey[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: TextFormField(
                      key: key,
                      validator: (value) => // if value is empty return null
                          value!.isEmpty ? null : null,
                      controller: controller,
                      enabled: isEnabled,
                      style: TextStyle(fontSize: 20.0),
                      minLines:
                          6, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: text,
                      )),
                ),
                Row(
                  //paste to clipboard
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (controller.text.isNotEmpty && !isEnabled)
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(
                              new ClipboardData(text: controller.text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Texto copiado!'),
                              behavior: SnackBarBehavior.floating,
                              width: 200,
                            ),
                          );
                        },
                      ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
