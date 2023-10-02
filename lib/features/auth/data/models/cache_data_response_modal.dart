import 'package:equatable/equatable.dart';

class CachedUser extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CachedUser({required this.name, required this.email});

  CachedUser.emptyUser() : this(name: 'name', email: 'email@gmail.com');

  late final String name;
  late final String email;
  CachedUser.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Email'] = email;
    data['Name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [name, email];
}
