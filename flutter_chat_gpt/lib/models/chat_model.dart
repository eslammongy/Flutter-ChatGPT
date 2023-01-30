class ChatModel {
  final String message;
  final int msgIndex;
  ChatModel({
    required this.message,
    required this.msgIndex,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(message: json['msg'], msgIndex: json['chatIndex']);
}
