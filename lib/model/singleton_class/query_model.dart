


class QnaModel {
  String? finishReason;
  List<BodyToJson>? bodyModel = [];

  QnaModel({this.finishReason, this.bodyModel});

  factory QnaModel.mapToModel(Map<String, dynamic> map) {
    List<dynamic> bdList = map["candidates"] ?? [];
    return QnaModel(
      finishReason: map["finishReason"],
      bodyModel: bdList.map((e) => BodyToJson.mapToModel(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "finishReason": finishReason,
    "bodyModel": bodyModel?.map((e) => e.toJson()).toList(),
  };
}

class BodyToJson {
  Content? content;

  BodyToJson({this.content});

  factory BodyToJson.mapToModel(Map<String, dynamic> map) {
    return BodyToJson(content: Content.mapToModel(map["content"]));
  }

  Map<String, dynamic> toJson() => {
    "content": content?.toJson(),
  };
}

class Content {
  String? role;
  List<Part>? parts = [];

  Content({this.role, this.parts});

  factory Content.mapToModel(Map<String, dynamic> map) {
    List<dynamic> list = map["parts"] ?? [];
    return Content(
      role: map["role"],
      parts: list.map((e) => Part.mapToModel(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "role": role,
    "parts": parts?.map((e) => e.toJson()).toList(),
  };
}

class Part {
  String? text;

  Part({this.text});

  factory Part.mapToModel(Map<String, dynamic> map) {
    return Part(text: map["text"]);
  }

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}


