class MessageModel {
  String? object;
  List<Data>? data;
  String? firstId;
  String? lastId;

  MessageModel({this.object, this.data, this.firstId, this.lastId});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      object: json['object'],
      data: json['data'] != null ? List<Data>.from(json['data'].map((x) => Data.fromJson(x))) : null,
      firstId: json['first_id'],
      lastId: json['last_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_id'] = this.firstId;
    data['last_id'] = this.lastId;
    return data;
  }
  
}

class Data {
  String? id;
  int? createdAt;
  String? threadId;
  String? role;
  List<Content>? content;
  String? assistantId;

  Data({this.id, this.createdAt, this.threadId, this.role, this.content, this.assistantId});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      createdAt: json['created_at'],
      threadId: json['thread_id'],
      role: json['role'],
      content: json['content'] != null ? List<Content>.from(json['content'].map((x) => Content.fromJson(x))) : null,
      assistantId: json['assistant_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['thread_id'] = this.threadId;
    data['role'] = this.role;
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['assistant_id'] = this.assistantId;
    return data;
  }
}

class Content {
  String? type;
  Text? text;

  Content({this.type, this.text});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      type: json['type'],
      text: json['text'] != null ? Text.fromJson(json['text']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.text != null) {
      data['text'] = this.text!.toJson();
    }
    return data;
  }
}

class Text {
  String? value;

  Text({this.value});

  factory Text.fromJson(Map<String, dynamic> json) {
    return Text(
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}
