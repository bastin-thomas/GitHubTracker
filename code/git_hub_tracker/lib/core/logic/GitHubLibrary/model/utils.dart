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


String DisplayDate(DateTime date){
  return date.isBefore(DateTime.now().add(const Duration(days: -7)))
      ? DateFormat("dd/mm/yyyy HH:mm")
      .format(date)
      : DateFormat("EEEE HH:mm").format(date);
}