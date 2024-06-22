/* class MyModel {
  String? object;
  String? first_id;
  String? last_id;

  MyModel({this.first_id, this.last_id, this.object});

  MyModel.fromJson(Map<String, dynamic> json){
    object = json["object"];
    first_id = json["first_id"];
    last_id = json["last_id"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['first_id'] = first_id;
    data['last_id'] = last_id;
    return data;
  }
} */
class MessageResponse {
  String? object;
  List<Message>? messages;
  String? firstId;
  String? lastId;

  MessageResponse({this.object, this.messages, this.firstId, this.lastId});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      object: json['object'],
      messages: json['data'] != null ? List<Message>.from(json['data'].map((v) => Message.fromJson(v))) : [],
      firstId: json['first_id'],
      lastId: json['last_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'object': object,
      'data': messages?.map((v) => v.toJson()).toList(),
      'first_id': firstId,
      'last_id': lastId,
    };
  }
}

class Message {
  String? id;
  String? threadId;
  String? role;
  List<MessageContent>? content;

  Message({this.id, this.threadId, this.role, this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      threadId: json['thread_id'],
      role: json['role'],
      content: json['content'] != null ? List<MessageContent>.from(json['content'].map((v) => MessageContent.fromJson(v))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thread_id': threadId,
      'role': role,
      'content': content?.map((v) => v.toJson()).toList(),
    };
  }
}

class MessageContent {
  String? type;
  MessageText? text;

  MessageContent({this.type, this.text});

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    return MessageContent(
      type: json['type'],
      text: json['text'] != null ? MessageText.fromJson(json['text']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'text': text?.toJson(),
    };
  }
}

class MessageText {
  String? value;

  MessageText({this.value});

  factory MessageText.fromJson(Map<String, dynamic> json) {
    return MessageText(
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

