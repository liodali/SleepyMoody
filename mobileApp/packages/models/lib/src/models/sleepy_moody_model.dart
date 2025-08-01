class SleepyMoodyModel {
  final String id;
  final double sleepHours;
  final int moodToday;
  final bool makeExercice;
  final String breakfast;
  final DateTime date;

  const SleepyMoodyModel({
    required this.id,
    required this.sleepHours,
    required this.moodToday,
    required this.makeExercice,
    required this.breakfast,
    required this.date,
  });
}
