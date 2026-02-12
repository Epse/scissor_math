// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Scissor Math';

  @override
  String get lSystem => 'Lutterloh System';

  @override
  String correction(Object correction, Object unit) {
    return 'Correction Factor: $correction $unit';
  }

  @override
  String result(String unit, Object result) {
    return 'Result: $result $unit';
  }

  @override
  String get patternRadius => 'Radius from pattern';

  @override
  String get radiusHelper => 'Number indicated at a dot on the pattern';

  @override
  String get measurementHipBust => 'Measurement (hip or bust) in cm';

  @override
  String get measurements => 'Measurements';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get newWord => 'New';

  @override
  String get measurement => 'measurement';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get saveMeasurement => 'Save Measurement';

  @override
  String get errorEnterText => 'Please enter some text';

  @override
  String get errorEnterNumber => 'Please enter a number';

  @override
  String get nameThisMeasurement => 'Name this measurement';
}
