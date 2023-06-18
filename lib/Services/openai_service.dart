import 'dart:convert';

import 'package:http/http.dart' as http;

import '../env/env.dart';
import '../models/openai_request.dart';
import '../models/message.dart';
import '../models/openai_response.dart';

class OpenAIService {
  static final Uri completionsEndpoint =
      Uri.parse('https://api.openai.com/v1/chat/completions');

  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${Env.openaiKey}',
  };
  Future<String> getTranslation(
      String text, String languaje, String intentionallity) async {
    List<Map<String, dynamic>> openaiMessages = [];
    openaiMessages.add(Message(
            role: 'user',
            content:
                'Eres un traductor por lo que tan solo debes responder con la traducción del mensaje que debes traducir con characteres en UTF8. Por ejemplo si yo digo "Hola" tu debes responder con "Hello"')
        .toMap());

    if (intentionallity != null && intentionallity != 'Automatico') {
      openaiMessages.add(Message(
              role: 'user',
              content:
                  'La intencionalidad de la traducción es: $intentionallity')
          .toMap());
    }
    openaiMessages.add(Message(
            role: 'user',
            content:
                'Traduce el siguiente texto al idioma $languaje, corrigiendo los posibles errores gramaticales y sin ningun tipo de información o comentario adicional: $text')
        .toMap());

    String content = await getContent(openaiMessages);

    return content;
  }

  Future<String> getContent(List<Map<String, dynamic>> openAiMessages) async {
    OpenAIRequest request = OpenAIRequest(
        model: 'gpt-3.5-turbo',
        temperature: 1,
        topP: 1,
        n: 1,
        stream: false,
        maxTokens: 1000,
        presencePenalty: 0,
        frequencyPenalty: 0,
        messages: openAiMessages);

    http.Response response = await http.post(completionsEndpoint,
        headers: headers, body: jsonEncode(request));

    // Check to see if there was an error
    if (response.statusCode != 200) {
      return 'Hubo un error al traducir el texto, por favor intenta de nuevo';
    }
    OpenAIResponse completionsResponse =
        OpenAIResponse.fromJson(jsonDecode(response.body));

    return completionsResponse.getContent();
  }
}
