class Chat {
  final String massege;
  final String id;
  Chat({required this.id, required this.massege});

  factory Chat.fromJson(jsonData) {
    return Chat(massege: jsonData['message'], id: jsonData['id']);
  }
}
