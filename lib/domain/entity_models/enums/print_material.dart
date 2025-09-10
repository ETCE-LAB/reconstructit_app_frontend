import 'package:json_annotation/json_annotation.dart';

enum PrintMaterial {
  @JsonValue(0)
  pla,
  @JsonValue(1)
  cpe;


  @override
  String toString(){
    if(this == PrintMaterial.cpe){
      return "CPE";
    } else {
      return "PLA";
    }
  }
}
