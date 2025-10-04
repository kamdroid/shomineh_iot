# shomineh

An IOT project.

For creating any release use these command

## ANDROID For Dev Test
- flutter clean
- flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/splitInfo --dart-define=env=dev

  or

- flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/splitInfo --dart-define=env=dev

## ANDROID For Production
- flutter clean
- flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/splitInfo --dart-define=env=production

  or

- flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/splitInfo --dart-define=env=production

### After uploading apk or bundle to google play run below command to upload symbols to firebase
    in windows
- firebase crashlytics:symbols:upload --app=1:2------ build\app\outputs\splitInfo

  in linux or mac
- firebase crashlytics:symbols:upload --app=1:2------ build/app/outputs/splitInfo


## IOS
- flutter clean
- flutter build ios --release --no-tree-shake-icons

## IPA
- flutter clean
- flutter build ipa --release --no-tree-shake-icons
