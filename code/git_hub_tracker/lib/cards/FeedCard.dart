import 'package:flutter/material.dart';
import 'package:git_hub_tracker/cards/Contents/Content_Card.dart';
import 'package:git_hub_tracker/styles/constants.dart';
import 'package:git_hub_tracker/partials/UserTag/MyUserTag.dart';
import 'package:intl/intl.dart';

import 'Contents/Content_DefaultTEXT.dart';

class FeedCard extends StatelessWidget {
  final DateTime publishDate;
  final String image;
  final String userName;
  final Content_Card content_card;

  const FeedCard(
      {required this.publishDate,
      required this.image,
      required this.userName,
      required this.content_card,
      Key? key})
      : super(key: key);

  static const Map<int, String> days = {
    DateTime.monday: 'Lundi',
    DateTime.tuesday: 'Mardi',
    DateTime.wednesday: 'Mercredi',
    DateTime.thursday: 'Jeudi',
    DateTime.friday: 'Vendredi',
    DateTime.saturday: 'Samedi',
    DateTime.sunday: 'Dimanche',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      margin: const EdgeInsets.fromLTRB(4, 5, 4, 0),
      decoration: BoxDecoration(
        boxShadow: cBoxShadowItem,
        color: Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          MyUserTag(userName: userName, image: image),
          const Divider(height: 5, color: Colors.black87),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              publishDate.isBefore(DateTime.now().add(const Duration(days: -7)))
                  ? "${DateFormat("dd/mm/yyyy HH:mm").format(publishDate)}"
                  : "${days[publishDate.weekday]} ${publishDate.hour}:${publishDate.minute}",
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          const Divider(height: 6, color: Colors.black87),
          content_card,
        ],
      ),
    );
  }
}
