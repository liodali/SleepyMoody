# Local DB Client

A Flutter package that provides a database client for managing data in local storage. This package handles all local data persistence operations for the SleepyMoody application.

## Features

- Local data storage and retrieval
- Database schema management
- Data persistence for offline functionality
- Type-safe database operations
- Built with code generation for optimal performance

## Getting started

To use this package in your Flutter application:

1. Add the dependency to your `pubspec.yaml`
2. Run the build runner to generate necessary code:
   ```bash
   dart run build_runner build
   ```
3. Import the package in your Dart files

## Usage

After running the build runner, you can use the generated database client:

```dart
import 'package:local_db_client/local_db_client.dart';

// Initialize the database
final dbClient = LocalDbClient();

// Perform database operations
await dbClient.initialize();
```

### Build Runner

This package uses code generation. After making changes to the database schema or models, run:

```bash
dart run build_runner build
```

## Additional information

This package is part of the SleepyMoody application ecosystem and is designed specifically for local data management. It provides a clean abstraction layer over the underlying database implementation.

### Development

When modifying this package:
1. Make your changes to the source files
2. Run `dart run build_runner build --delete-conflicting-outputs ` to regenerate code
3. Test your changes thoroughly

For questions or issues, please refer to the main SleepyMoody project documentation.
