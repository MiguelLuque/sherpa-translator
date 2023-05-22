// food class with a property name
// add to String

class Message {
  String role;
  String content;

  Message({
    required this.role,
    required this.content,
  });

  //to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
    };
  }
}
