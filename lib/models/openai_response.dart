class OpenAIResponse {
  final String? id;
  final String object;
  final int? created;
  final String? model;
  final List<dynamic>? choices; // This list contains the completions
  final Map<String, dynamic>? usage;
  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;
  final String? firstCompletion;

  const OpenAIResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.firstCompletion,
  });

  factory OpenAIResponse.fromJson(Map<String, dynamic> json) {
    return OpenAIResponse(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      choices: json['choices'],
      usage: json['usage'],
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
      firstCompletion: json['choices'][0]['text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['created'] = this.created;
    data['model'] = this.model;
    data['choices'] = this.choices;
    data['usage'] = this.usage;
    data['prompt_tokens'] = this.promptTokens;
    data['completion_tokens'] = this.completionTokens;
    data['total_tokens'] = this.totalTokens;
    data['firstCompletion'] = this.firstCompletion;
    return data;
  }

  String getContent() {
    return choices![0]['message']['content'];
  }
}
