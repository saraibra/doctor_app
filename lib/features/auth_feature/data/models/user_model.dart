import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  UserModel(
      {required String name, required String email, required String id, required String phoneNumber})
      : super(name: name, email: email, id: id,phoneNumber: phoneNumber);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'], email: json['email'], id: json['uid'], phoneNumber: json['phoneNumber'].toString());
  }
  Map<String,dynamic> toJson(){
    
    return {
      'uid':id,
      'name':name,
      'email':email,
    };
  }
}
