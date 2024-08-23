<h1 align="center">yeti_movies</h1>


<p align="center">An awesome Flutter project.</p>

Outcomes
--------

This app was specifically built to apply the principles of SOLID and Clean Architecture. With this in mind, two architectures were adopted, which I consider essential for apps aiming to remain scalable, extensible, and pluggable.

The separation is implemented in the feature of movie listing, where one architecture is applied to the listing of popular movies, and the other to the listing of featured/discovered movies.

The first approach applies the concepts of modular dependency and responsibility segregation more directly and incisively. Here, the DATA and DOMAIN layers are separated from the module, facilitating the maintenance of the outer layers and business logic.

The second approach is more conventional and popular, where features are segregated by modules, and all layers (DATA, DOMAIN, PRESENTER) are at the same level within the module.

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

Otherwise there are debug config files that allows the IDEs to run with debug menu, as `.vscode/launch.json` file and `.idea/runConfigurations/flavor.xml`

_\*Yeti Movies works on iOS, Android, Web, and Windows, but flavors works only on mobile._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:yeti_movies/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   ├── app_es.arb
│   │   └── app_pt.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "appBarTitle": "YetiMovies",
    "@appBarTitle": {
        "description": "Text shown in the AppBar of the App Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "appBarTitle": "YetiMovies",
    "@appBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del app"
    }
}
```

`app_pt.arb`

```arb
{
    "@@locale": "pt",
    "appBarTitle": "YetiMovies",
    "@appBarTitle": {
        "description": "Texto mostrado no AppBar da página do app"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

---

### 🛠 Tech and Tools
The following tools were used in the construction of the project:

- [Flutter](https://flutter.dev/): Core SDK
- [BloC](https://pub.dev/packages/bloc): State Management which implement the BLoC pattern.
- [Mocktail](https://pub.dev/packages/mocktail) : Mock library and suit test methods
- [Json serializable](https://pub.dev/packages/json_serializable): Provides Dart Build System builders for handling JSON
- [Equatable](https://pub.dev/packages/equatable): Compare objects in Dart|Overrides
- [very_good_workflows](https://github.com/VeryGoodOpenSource/very_good_workflows) For workflows and actions
- [SOLID](https://en.wikipedia.org/wiki/SOLID)

_\*BLoC pattern helps to build your Flutter app architecture and manage the flow of data through your widgets using Dart streams. So it fits to the goals of the app._


[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization