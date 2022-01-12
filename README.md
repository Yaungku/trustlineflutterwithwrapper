# Trustline Flutter App with JS Wrapper

This project is about using Trustline with JS Wrapper. This take most of common used apis of Clientlib and wrap with a server. This is very easy to use.
This app currently uses [this api reference](https://github.com/thuaung30/tl-clientlib-wrapper-api).

For more information on trustline clientlib, visit [their docs](https://dev.trustlines.network/clientlib/introduction).

## Build

1. If you don't have Flutter SDK installed, please visit official [Flutter](https://flutter.dev/) site.
2. Install Flutter according to their guides.

```
git clone https://github.com/Yaungku/trustlineflutterwithwrapper.git
```

3. Run the app with Android Studio or Visual Studio. Or the command line.

```
flutter pub get
flutter run
```

## Setup

The default api route is setup with [this](https://tl-clientlib-wrapper-api.herokuapp.com/api-docs/).

You can test out by hosting your own server. There is guide in there how to [Local Setup](https://github.com/thuaung30/tl-clientlib-wrapper-api#local-setup).

When setup in localhost, you need to change local route here.

lib > src > services > api.dart

```dart
var baseUrl = localhost //(Default: networkurl)
```

## APK File

https://drive.google.com/drive/folders/1R9XECB7cfE2YBdlbIAkzT06OPt8oSRKG?usp=sharing (Tested on S9)

## Credits to

https://github.com/thuaung30


