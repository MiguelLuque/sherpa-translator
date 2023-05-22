import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sherpa_translator/widgets/toggle_buttons_row.dart';
import 'package:sherpa_translator/widgets/translation_field.dart';

import '../Services/openai_service.dart';
import 'package:async/async.dart';

class TranslationForm extends StatefulWidget {
  TranslationForm({Key? key}) : super(key: key);

  @override
  State<TranslationForm> createState() => _TranslationFormState();
}

class _TranslationFormState extends State<TranslationForm> {
  final _formKey = GlobalKey<FormState>();

  final _toTranslateTextController = TextEditingController();
  final _translatedTextController = TextEditingController();
  final _languageController = TextEditingController();
  final _intentionallityController = TextEditingController();

// Variable para almacenar la operación de la API
  CancelableOperation? _apiOperation;

  final languages = ['Inglés', 'Español', 'Francés', 'Italiano', 'Portugués'];

  @override
  //init state with first language
  void initState() {
    super.initState();
    _languageController.text = languages[0];
  }

  //swap controllers text function
  void swapControllersText() {
    String temp = _toTranslateTextController.text;
    _toTranslateTextController.text = _translatedTextController.text;
    _translatedTextController.text = temp;
    //set state
    setState(() {
      _toTranslateTextController.text = _toTranslateTextController.text;
      _translatedTextController.text = _translatedTextController.text;
    });
  }

  void updateTranslatedText(String translatedText) {
    setState(() {
      _translatedTextController.text = translatedText;
    });
  }

  String convertToUtf8(String text) {
    List<int> latin1Bytes = latin1.encode(text);
    String utf8String = utf8.decode(latin1Bytes);
    return utf8String;
  }

  Future<void> _callApi() async {
    String translatedText = await OpenAIService()
        .getTranslation(_toTranslateTextController.text,
            _languageController.text, _intentionallityController.text)
        .then((value) => value)
        .onError((error, stackTrace) => 'Error: $error');
    updateTranslatedText(convertToUtf8(translatedText));
    ;
  }

  void _handleButtonPress() {
    // Aborta la operación anterior si existe
    _apiOperation?.cancel();

    // Crea una nueva operación de la API
    _apiOperation = CancelableOperation.fromFuture(
      _callApi(),
      onCancel: () {
        // Lógica para manejar la cancelación de la operación
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Intención'),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ToggleButtonsRow(controller: _intentionallityController),
                      SizedBox(width: 50),
                      DropdownButton<String>(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        value: _languageController.text,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 18,
                        elevation: 16,
                        style: const TextStyle(color: Colors.blue),
                        onChanged: (String? newValue) {
                          setState(() {
                            _languageController.text = newValue!;
                          });
                        },
                        items: languages
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child:
                                Text(value, style: TextStyle(fontSize: 20.0)),
                          );
                        }).toList(),
                      ),
                      SizedBox(width: 50),
                      ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate() &&
                              _toTranslateTextController.text.isNotEmpty) {
                            _handleButtonPress();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Introduzca texto')),
                            );
                          }
                        },
                        child: Text('Traducir'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(80, 50),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              TranslationField(
                controller: _toTranslateTextController,
                isEnabled: true,
                text: 'Introduzca texto para su traducción',
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: () {
                    // Lógica para intercambiar los contenidos de los contenedores
                    swapControllersText();
                  },
                ),
              ),
              TranslationField(
                  controller: _translatedTextController, isEnabled: false),
            ],
          ),
        ],
      ),
    );
  }
}
