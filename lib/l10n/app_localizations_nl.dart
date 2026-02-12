// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Scissor Math';

  @override
  String get lSystem => 'Lutterloh Systeem';

  @override
  String correction(Object correction, Object unit) {
    return 'Correctiefactor: $correction $unit';
  }

  @override
  String result(String unit, Object result) {
    return 'Resultaat: $result $unit';
  }

  @override
  String get patternRadius => 'Straal van patroon';

  @override
  String get radiusHelper =>
      'Getal dat aangeduid staat bij een punt op het patroon';

  @override
  String get measurementHipBust => 'Maat (heup of borst) in cm';

  @override
  String get measurements => 'Maten';

  @override
  String get loading => 'Laden...';

  @override
  String get error => 'Fout';

  @override
  String get newWord => 'Nieuw';

  @override
  String get measurement => 'Maat';

  @override
  String get cancel => 'Annuleren';

  @override
  String get save => 'Opslaan';

  @override
  String get saveMeasurement => 'Sla Maat op';

  @override
  String get errorEnterText => 'Geef wat tekst in';

  @override
  String get errorEnterNumber => 'Geef een getal in';

  @override
  String get nameThisMeasurement => 'Geef deze Maat een naam';
}
