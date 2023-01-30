class ChatModel {
  final String message;
  final int msgIndex;
  final bool isImage;
  ChatModel({
    required this.message,
    required this.msgIndex,
    required this.isImage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
      message: json['msg'], msgIndex: json['chatIndex'], isImage: false);
}
