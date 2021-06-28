import 'package:flutter/src/material/dropdown.dart';

/// id : 1
/// schoolCategoryId : 3
/// schoolCategoryName : "K-8"
/// name : "School1"
/// createdBy : 0
/// createdOn : "0001-01-01T00:00:00"
/// updatedBy : 0
/// updatedOn : "0001-01-01T00:00:00"

class SchoolListResponse {
  late int _id;
  late int _schoolCategoryId;
  late String _schoolCategoryName;
  late String _name;
  late int _createdBy;
  late String _createdOn;
  late int _updatedBy;
  late String _updatedOn;

  int get id => _id;
  int get schoolCategoryId => _schoolCategoryId;
  String get schoolCategoryName => _schoolCategoryName;
  String get name => _name;
  int get createdBy => _createdBy;
  String get createdOn => _createdOn;
  int get updatedBy => _updatedBy;
  String get updatedOn => _updatedOn;

  SchoolListResponse({
      required int id,
      required int schoolCategoryId,
      required String schoolCategoryName,
      required String name,
      required int createdBy,
      required String createdOn,
      required int updatedBy,
      required String updatedOn}){
    _id = id;
    _schoolCategoryId = schoolCategoryId;
    _schoolCategoryName = schoolCategoryName;
    _name = name;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _updatedBy = updatedBy;
    _updatedOn = updatedOn;
}

  SchoolListResponse.fromJson(dynamic json) {
    _id = json["id"];
    _schoolCategoryId = json["schoolCategoryId"];
    _schoolCategoryName = json["schoolCategoryName"];
    _name = json["name"];
    _createdBy = json["createdBy"];
    _createdOn = json["createdOn"];
    _updatedBy = json["updatedBy"];
    _updatedOn = json["updatedOn"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["schoolCategoryId"] = _schoolCategoryId;
    map["schoolCategoryName"] = _schoolCategoryName;
    map["name"] = _name;
    map["createdBy"] = _createdBy;
    map["createdOn"] = _createdOn;
    map["updatedBy"] = _updatedBy;
    map["updatedOn"] = _updatedOn;
    return map;
  }
}