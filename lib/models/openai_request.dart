class OpenAIRequest {
  String model;
  List<Map<String, dynamic>> messages;
  double temperature;
  double topP;
  int n;
  bool stream;
  int maxTokens;
  double presencePenalty;
  double frequencyPenalty;

  OpenAIRequest({
    required this.model,
    required this.messages,
    required this.temperature,
    required this.topP,
    required this.n,
    required this.stream,
    required this.maxTokens,
    required this.presencePenalty,
    required this.frequencyPenalty,
  });

  factory OpenAIRequest.fromJson(Map<String, dynamic> json) {
    return OpenAIRequest(
      model: json['model'],
      messages: List<Map<String, dynamic>>.from(json['messages']),
      temperature: json['temperature'],
      topP: json['top_p'],
      n: json['n'],
      stream: json['stream'],
      maxTokens: json['max_tokens'],
      presencePenalty: json['presence_penalty'],
      frequencyPenalty: json['frequency_penalty'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['model'] = this.model;
    data['messages'] = this.messages;
    data['temperature'] = this.temperature;
    data['top_p'] = this.topP;
    data['n'] = this.n;
    data['stream'] = this.stream;
    data['max_tokens'] = this.maxTokens;
    data['presence_penalty'] = this.presencePenalty;
    data['frequency_penalty'] = this.frequencyPenalty;
    return data;
  }
}
