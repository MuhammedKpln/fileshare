flutter pub run build_runner clean
flutter pub run easy_localization:generate -S assets/translations/ -f json
flutter pub run easy_localization:generate -f keys  -S assets/translations/ -o locale_keys.g.dart
flutter pub run build_runner watch --delete-conflicting-outputs
