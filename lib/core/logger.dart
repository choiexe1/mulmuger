import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    printEmojis: false,
    dateTimeFormat: DateTimeFormat.dateAndTime,
  ),
);
