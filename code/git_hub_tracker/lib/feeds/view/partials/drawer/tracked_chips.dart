import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_chips_input/simple_chips_input.dart';

class TrackChip extends StatelessWidget {
  final String chipName;
  final List<String> trackedList;
  final GlobalKey<FormState> globalKey;

  const TrackChip({Key? key, required this.globalKey, required this.chipName, required this.trackedList,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    StringBuffer chipsbuilded = StringBuffer();
    chipsbuilded.writeAll(trackedList, ";");
    print(chipsbuilded.toString());


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

          child: SimpleChipsInput(
            controller: TextEditingController(text: chipsbuilded.toString()),

            deleteIcon: const Row(children: [
              VerticalDivider(width: 10, color: Colors.transparent,),
              Icon(
                Icons.delete_forever,
                size: 16.0,
                color: Colors.redAccent,
              ),
            ],),

            chipTextStyle: const TextStyle(fontSize: 16.0, color: kPayloadTextColor),
            onChipDeleted: onDelete,
            onChipAdded: onAdded,
            separatorCharacter: ";",
            chipContainerDecoration: kBoxDecoration,
            validateInput: true,
            key: globalKey,
          ),
        ),
      ]),
    );
  }

  void onDelete(String value, int index) {
    trackedList.removeAt(index);
  }

  void onAdded(String value) {
    trackedList.add(value);
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
          child: Center(
            child: LoadingAnimationWidget.hexagonDots(
                color: kDefaultIconDarkColor, size: 75),
          ),
        ),
      ]),
    );
  }
}

