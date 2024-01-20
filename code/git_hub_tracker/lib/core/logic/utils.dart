import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';
import 'package:intl/intl.dart';

DateTime TimeConverter(String? date){
  if(date == null) return DateTime.fromMicrosecondsSinceEpoch(0);

  try{
    DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
    DateTime convertedTime = format.parse(date);
    return convertedTime;
  }on Exception{
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }
}

void sortOnDate(List<FeedCard> tosort){
  tosort.sort((a, b) {
    int result = a.publishDate.compareTo(b.publishDate);
    if(result == -1) return 1;
    if(result == 1) return -1;
    return result;
  });
}

String DisplayDate(DateTime date){
  return date.isBefore(DateTime.now().add(const Duration(days: -7)))
      ? DateFormat("dd/MM/yyyy HH:mm").format(date) : DateFormat("EEEE HH:mm").format(date);
}