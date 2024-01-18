
// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

class StoreUser {
  final List<String> followed_users;
  final List<String> followed_repository;

  const StoreUser({Key? key, required this.followed_users, required this.followed_repository});

  factory StoreUser.fromJson(Map<String, dynamic> json){
    return StoreUser(
        followed_users: json['followed_users'].cast<String>(),
        followed_repository: json['followed_repositories'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'followed_users':followed_users,
      'followed_repositories':followed_repository,
    };
  }
}