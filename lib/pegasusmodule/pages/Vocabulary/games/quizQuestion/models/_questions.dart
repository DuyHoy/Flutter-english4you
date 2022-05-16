// ignore: file_names
class Question {
  final int id, answer;
  final String question;
  final String note;
  final String mean;
  final List<String> options;

  Question({required this.id, required this.question, required this.answer,required this.note,required this.mean, required this.options});
}

// ignore: constant_identifier_names
const List sample_data = [
  {
    "id": 1,
    "question":
        "It was one of the President's greatest ____s.",
    "note":"an impressive thing that is done or achieved after a lot of of work",
    "mean":"sự hoàn thành tốt đẹp",
    "options": ['realize', 'calculator', 'drawer', 'accomplishment'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question":
        "It was one of the President's greatest ____s.",
    "note":"an impressive thing that is done or achieved after a lot of of work",
    "mean":"sự hoàn thành tốt đẹp",
    "options": ['realize', 'calculator', 'drawer', 'accomplishment'],
    "answer_index": 1,
  },
  {
    "id": 3,
    "question":
        "It was one of the President's greatest ____s.",
    "note":"an impressive thing that is done or achieved after a lot of of work",
    "mean":"sự hoàn thành tốt đẹp",
    "options": ['realize', 'calculator', 'drawer', 'accomplishment'],
    "answer_index": 1,
  },
  {
    "id": 4,
    "question":
        "It was one of the President's greatest ____s.",
    "note":"an impressive thing that is done or achieved after a lot of of work",
    "mean":"sự hoàn thành tốt đẹp",
    "options": ['realize', 'calculator', 'drawer', 'accomplishment'],
    "answer_index": 1,
  },
];
