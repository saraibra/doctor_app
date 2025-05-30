import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String name;
  final String email;

  final String id;
  final String phoneNumber;

  User({required this.phoneNumber, required this.name, required this.email, required this.id});
  
  @override
  // TODO: implement props
  List<Object?> get props => [name, email, id, phoneNumber];
  
}