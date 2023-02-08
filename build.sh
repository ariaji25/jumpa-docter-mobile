#!/bin/bash

cd android/ && ./gradlew clean
flutter clean
flutter pub get 

# flutter build apk --flavor develop -t lib/main_prod.dart -v
# flutter build appbundle --flavor develop -t lib/main_prod.dart -v

# UNCOMENT WHEN BUILD PROD
# flutter build apk --release --flavor prod -t lib/main_prod.dart --split-per-abi
# flutter build appbundle --release --flavor prod -t lib/main_prod.dart

flutter build apk --release --flavor prod -t lib/main.dart --split-per-abi
flutter build appbundle --release --flavor prod -t lib/main.dart
