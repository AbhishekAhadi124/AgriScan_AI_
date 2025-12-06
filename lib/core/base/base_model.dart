class BaseModel {
  int? id;

  BaseModel();

  BaseModel.fromJson(Map<dynamic, dynamic> parsedJson) : id = parsedJson['id'];

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
      };
}
