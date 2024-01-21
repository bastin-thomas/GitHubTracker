
// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

class StoreUser {
  final List<String> followed_users;
  final List<String> followed_repository;
  final List<int> filter_state;

  const StoreUser({Key? key, required this.followed_users, required this.followed_repository, required this.filter_state,});

  factory StoreUser.fromJson(Map<String, dynamic> json){
    return StoreUser(
        followed_users: json['followed_users'].cast<String>(),
        followed_repository: json['followed_repositories'].cast<String>(),
        filter_state: json['filter_state'].cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'followed_users':followed_users,
      'followed_repositories':followed_repository,
      'filter_state':filter_state,
    };
  }
}