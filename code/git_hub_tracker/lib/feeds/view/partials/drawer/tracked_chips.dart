import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/feeds/view/partials/inputs/my_simple_chips_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_chips_input/simple_chips_input.dart';

class TrackChip extends StatelessWidget {
  final String chipName;
  final List<String> trackedList;
  final Function(String value, int index)? onDelete;
  final Function(String value)? onAdded;
  final Function(String value)? onChanged;

  const TrackChip({
    super.key,
    required this.chipName,
    required this.trackedList,
    this.onDelete,
    this.onAdded,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      decoration: BoxDecoration(
          boxShadow: cBoxShadowItem,
          color: Colors.black45,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(children: [
        Text(
          chipName,
          style: const TextStyle(color: kPayloadTextColor),
        ),
        const Divider(height: 5, color: Colors.transparent),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          decoration: BoxDecoration(
              boxShadow: cBoxShadowItem,
              color: Colors.white10,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: MySimpleChipsInput(
            chipsText: trackedList,
            deleteIcon: const Row(
              children: [
                VerticalDivider(
                  width: 10,
                  color: Colors.transparent,
                ),
                Icon(
                  Icons.delete_forever,
                  size: 16.0,
                  color: Colors.redAccent,
                ),
              ],
            ),
            chipTextStyle:
                const TextStyle(fontSize: 16.0, color: kPayloadTextColor),
            separatorCharacter: ";",
            chipContainerDecoration: kBoxDecoration,
            validateInput: true,
            onChipAdded: onAdded,
            onChanged: onChanged,
            onChipDeleted: onDelete,
          ),
        ),
      ]),
    );
  }
}

/*












































 */

class TrackedWaiting extends StatelessWidget {
  final String chipName;

  const TrackedWaiting({super.key, required this.chipName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      decoration: BoxDecoration(
          boxShadow: cBoxShadowItem,
          color: Colors.black45,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(children: [
        Text(
          chipName,
          style: const TextStyle(color: kPayloadTextColor),
        ),
        const Divider(height: 5, color: Colors.transparent),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          decoration: BoxDecoration(
              boxShadow: cBoxShadowItem,
              color: Colors.white10,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: const Column(
            children: [
              Divider(height: 10, color: Colors.transparent),
              Center(
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: CircularProgressIndicator(
                    color: kDefaultIconDarkColor,
                    strokeWidth: 10,
                  ),
                ),
              ),
              Divider(height: 10, color: Colors.transparent),
            ],
          ),
        ),
      ]),
    );
  }
}
