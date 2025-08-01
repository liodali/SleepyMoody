import 'package:flutter_test/flutter_test.dart';
import 'package:sleepymoody_models/src/domain/local_db.dart';
import 'package:sleepymoody_models/src/models/sleepy_moody_model.dart';

// Mock implementation of LocalDB for testing
class MockLocalDB implements LocalDB {
  final List<SleepyMoodyModel> _data = [];

  @override
  Future<List<SleepyMoodyModel>> getListSleepyMoodyData() async {
    return List.from(_data);
  }

  @override
  Stream<List<SleepyMoodyModel>> watchListSleepyMoodyData() {
    return Stream.value(List.from(_data));
  }

  @override
  Future<SleepyMoodyModel?> getSleepyMoodyData(String uuid) async {
    try {
      return _data.firstWhere((item) => item.id == uuid);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> insertSleepyMoodyData(SleepyMoodyModel sleepyMoodyModel) async {
    _data.add(sleepyMoodyModel);
  }

  @override
  Future<void> deleteSleepyMoodyData(String uuid) async {
    _data.removeWhere((item) => item.id == uuid);
  }

  @override
  Future<void> clearSleepyMoody() async {
    _data.clear();
  }
}

void main() {
  group('LocalDB Tests', () {
    late MockLocalDB mockLocalDB;
    late SleepyMoodyModel testModel1;
    late SleepyMoodyModel testModel2;

    setUp(() {
      mockLocalDB = MockLocalDB();
      testModel1 = SleepyMoodyModel(
        id: 'test-uuid-1',
        sleepHours: 8.5,
        moodToday: 4,
        makeExercice: true,
        breakfast: 'Oatmeal with fruits',
        date: DateTime(2024, 1, 15),
      );
      testModel2 = SleepyMoodyModel(
        id: 'test-uuid-2',
        sleepHours: 6.0,
        moodToday: 3,
        makeExercice: false,
        breakfast: 'Toast and coffee',
        date: DateTime(2024, 1, 16),
      );
    });

    test('should insert and retrieve SleepyMoodyData', () async {
      // Insert test data
      await mockLocalDB.insertSleepyMoodyData(testModel1);
      await mockLocalDB.insertSleepyMoodyData(testModel2);

      // Retrieve all data
      final result = await mockLocalDB.getListSleepyMoodyData();

      expect(result.length, equals(2));
      expect(result.first.id, equals('test-uuid-1'));
      expect(result.last.id, equals('test-uuid-2'));
    });

    test('should get specific SleepyMoodyData by uuid', () async {
      await mockLocalDB.insertSleepyMoodyData(testModel1);

      final result = await mockLocalDB.getSleepyMoodyData('test-uuid-1');

      expect(result, isNotNull);
      expect(result!.id, equals('test-uuid-1'));
      expect(result.sleepHours, equals(8.5));
      expect(result.moodToday, equals(4));
      expect(result.makeExercice, isTrue);
      expect(result.breakfast, equals('Oatmeal with fruits'));
    });

    test('should return null for non-existent uuid', () async {
      final result = await mockLocalDB.getSleepyMoodyData('non-existent-uuid');

      expect(result, isNull);
    });

    test('should delete SleepyMoodyData by uuid', () async {
      await mockLocalDB.insertSleepyMoodyData(testModel1);
      await mockLocalDB.insertSleepyMoodyData(testModel2);

      await mockLocalDB.deleteSleepyMoodyData('test-uuid-1');

      final result = await mockLocalDB.getListSleepyMoodyData();
      expect(result.length, equals(1));
      expect(result.first.id, equals('test-uuid-2'));
    });

    test('should clear all SleepyMoodyData', () async {
      await mockLocalDB.insertSleepyMoodyData(testModel1);
      await mockLocalDB.insertSleepyMoodyData(testModel2);

      await mockLocalDB.clearSleepyMoody();

      final result = await mockLocalDB.getListSleepyMoodyData();
      expect(result.isEmpty, isTrue);
    });

    test('should watch SleepyMoodyData stream', () async {
      await mockLocalDB.insertSleepyMoodyData(testModel1);

      final stream = mockLocalDB.watchListSleepyMoodyData();

      await expectLater(
        stream,
        emits(
          predicate<List<SleepyMoodyModel>>(
            (list) => list.length == 1 && list.first.id == 'test-uuid-1',
          ),
        ),
      );
    });

    test('should handle multiple insertions correctly', () async {
      final additionalModel = SleepyMoodyModel(
        id: 'test-uuid-3',
        sleepHours: 7.5,
        moodToday: 5,
        makeExercice: true,
        breakfast: 'Smoothie bowl',
        date: DateTime(2024, 1, 17),
      );

      await mockLocalDB.insertSleepyMoodyData(testModel1);
      await mockLocalDB.insertSleepyMoodyData(testModel2);
      await mockLocalDB.insertSleepyMoodyData(additionalModel);

      final result = await mockLocalDB.getListSleepyMoodyData();
      expect(result.length, equals(3));

      final ids = result.map((model) => model.id).toList();
      expect(ids, contains('test-uuid-1'));
      expect(ids, contains('test-uuid-2'));
      expect(ids, contains('test-uuid-3'));
    });

    test('should handle deletion of non-existent uuid gracefully', () async {
      await mockLocalDB.insertSleepyMoodyData(testModel1);

      // This should not throw an error
      await mockLocalDB.deleteSleepyMoodyData('non-existent-uuid');

      final result = await mockLocalDB.getListSleepyMoodyData();
      expect(result.length, equals(1));
      expect(result.first.id, equals('test-uuid-1'));
    });
  });
}
