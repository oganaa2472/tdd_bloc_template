import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String createdAt;
  final String avatar;
  final String name;
  const User({required this.id,required this.createdAt,required this.avatar, required this.name});
  
  @override
  // TODO: implement props 
  List<Object?> get props => [id];
}