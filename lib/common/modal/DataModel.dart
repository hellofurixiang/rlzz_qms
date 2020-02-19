import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DataModel {
  String text;

  String value;

  DataModel.empty();

  DataModel(this.value, this.text);
}
