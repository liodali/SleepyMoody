import 'package:flutter_test/flutter_test.dart';
import 'package:sleepymoody_models/src/models/user.dart';
import 'package:sleepymoody_models/src/models/sleepy_moody_model.dart';

void main() {
  group('User Model Tests', () {
    test('should create User with required properties', () {
      const user = User(
        id: 'user-123',
        name: 'John Doe',
        email: 'john.doe@example.com',
      );

      expect(user.id, equals('user-123'));
      expect(user.name, equals('John Doe'));
      expect(user.email, equals('john.doe@example.com'));
    });

    test('should create User with different values', () {
      const user = User(
        id: 'user-456',
        name: 'Jane Smith',
        email: 'jane.smith@test.com',
      );

      expect(user.id, equals('user-456'));
      expect(user.name, equals('Jane Smith'));
      expect(user.email, equals('jane.smith@test.com'));
    });

    test('should handle empty strings', () {
      const user = User(
        id: '',
        name: '',
        email: '',
      );

      expect(user.id, equals(''));
      expect(user.name, equals(''));
      expect(user.email, equals(''));
    });

    test('should handle special characters in properties', () {
       const user = User(
         id: 'user-special',
         name: 'Jose Maria',
         email: 'test+user@domain.co.uk',
       );

       expect(user.id, equals('user-special'));
       expect(user.name, equals('Jose Maria'));
       expect(user.email, equals('test+user@domain.co.uk'));
     });

    test('should be immutable', () {
      const user1 = User(
        id: 'user-123',
        name: 'John Doe',
        email: 'john.doe@example.com',
      );

      const user2 = User(
        id: 'user-123',
        name: 'John Doe',
        email: 'john.doe@example.com',
      );

      // Since User is immutable, we can't modify properties
      // This test verifies the const constructor works correctly
      expect(user1.id, equals(user2.id));
      expect(user1.name, equals(user2.name));
      expect(user1.email, equals(user2.email));
    });
  });

  group('SleepyMoodyModel Tests', () {
    test('should create SleepyMoodyModel with all required properties', () {
      final model = SleepyMoodyModel(
        id: 'sleepy-123',
        sleepHours: 8.5,
        moodToday: 4,
        makeExercice: true,
        breakfast: 'Oatmeal with berries',
        date: DateTime(2024, 1, 15, 8, 30),
      );

      expect(model.id, equals('sleepy-123'));
      expect(model.sleepHours, equals(8.5));
      expect(model.moodToday, equals(4));
      expect(model.makeExercice, isTrue);
      expect(model.breakfast, equals('Oatmeal with berries'));
      expect(model.date, equals(DateTime(2024, 1, 15, 8, 30)));
    });

    test('should handle different sleep hours values', () {
      final model1 = SleepyMoodyModel(
        id: 'test-1',
        sleepHours: 6.0,
        moodToday: 3,
        makeExercice: false,
        breakfast: 'Coffee only',
        date: DateTime.now(),
      );

      final model2 = SleepyMoodyModel(
        id: 'test-2',
        sleepHours: 9.75,
        moodToday: 5,
        makeExercice: true,
        breakfast: 'Full breakfast',
        date: DateTime.now(),
      );

      expect(model1.sleepHours, equals(6.0));
      expect(model2.sleepHours, equals(9.75));
    });

    test('should handle mood range values', () {
      final models = [
        SleepyMoodyModel(
          id: 'mood-1',
          sleepHours: 7.0,
          moodToday: 1,
          makeExercice: false,
          breakfast: 'Toast',
          date: DateTime.now(),
        ),
        SleepyMoodyModel(
          id: 'mood-5',
          sleepHours: 8.0,
          moodToday: 5,
          makeExercice: true,
          breakfast: 'Smoothie',
          date: DateTime.now(),
        ),
      ];

      expect(models[0].moodToday, equals(1));
      expect(models[1].moodToday, equals(5));
    });

    test('should handle exercise boolean values', () {
      final exerciseModel = SleepyMoodyModel(
        id: 'exercise-yes',
        sleepHours: 7.5,
        moodToday: 4,
        makeExercice: true,
        breakfast: 'Protein shake',
        date: DateTime.now(),
      );

      final noExerciseModel = SleepyMoodyModel(
        id: 'exercise-no',
        sleepHours: 6.5,
        moodToday: 3,
        makeExercice: false,
        breakfast: 'Cereal',
        date: DateTime.now(),
      );

      expect(exerciseModel.makeExercice, isTrue);
      expect(noExerciseModel.makeExercice, isFalse);
    });

    test('should handle various breakfast descriptions', () {
      final breakfasts = [
        'Eggs and bacon',
        'Avocado toast',
        'Greek yogurt with granola',
        'Nothing',
        'Coffee and pastry',
        '🥞 Pancakes with syrup 🍯',
      ];

      for (int i = 0; i < breakfasts.length; i++) {
        final model = SleepyMoodyModel(
          id: 'breakfast-$i',
          sleepHours: 7.0,
          moodToday: 3,
          makeExercice: false,
          breakfast: breakfasts[i],
          date: DateTime.now(),
        );

        expect(model.breakfast, equals(breakfasts[i]));
      }
    });

    test('should handle different date values', () {
      final pastDate = DateTime(2023, 12, 25, 7, 0);
      final futureDate = DateTime(2025, 6, 15, 9, 30);
      final currentDate = DateTime.now();

      final models = [
        SleepyMoodyModel(
          id: 'past',
          sleepHours: 8.0,
          moodToday: 4,
          makeExercice: true,
          breakfast: 'Holiday breakfast',
          date: pastDate,
        ),
        SleepyMoodyModel(
          id: 'future',
          sleepHours: 7.0,
          moodToday: 3,
          makeExercice: false,
          breakfast: 'Future meal',
          date: futureDate,
        ),
        SleepyMoodyModel(
          id: 'current',
          sleepHours: 7.5,
          moodToday: 4,
          makeExercice: true,
          breakfast: 'Today\'s breakfast',
          date: currentDate,
        ),
      ];

      expect(models[0].date, equals(pastDate));
      expect(models[1].date, equals(futureDate));
      expect(models[2].date, equals(currentDate));
    });

    test('should handle edge case values', () {
      final model = SleepyMoodyModel(
        id: '',
        sleepHours: 0.0,
        moodToday: 0,
        makeExercice: false,
        breakfast: '',
        date: DateTime(1970, 1, 1),
      );

      expect(model.id, equals(''));
      expect(model.sleepHours, equals(0.0));
      expect(model.moodToday, equals(0));
      expect(model.makeExercice, isFalse);
      expect(model.breakfast, equals(''));
      expect(model.date, equals(DateTime(1970, 1, 1)));
    });
  });
}
