flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run easy_localization:generate -S assets/translations/ -f json
flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart