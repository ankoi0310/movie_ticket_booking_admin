enum GeneralState {
  active('ACTIVE'),
  updated('UPDATED'),
  deleted('DELETED');

  final String value;

  const GeneralState(this.value);

  static GeneralState fromValue(String value) {
    return GeneralState.values.firstWhere((e) => e.value == value);
  }
}

class General {
  final int id;
  final GeneralState state;
  final DateTime createdDate;
  final DateTime modifiedDate;
  final DateTime? deletedDate;

  General({
    required this.id,
    this.state = GeneralState.active,
    required this.createdDate,
    required this.modifiedDate,
    required this.deletedDate,
  });

  General.empty()
      : id = 0,
        state = GeneralState.active,
        createdDate = DateTime.now(),
        modifiedDate = DateTime.now(),
        deletedDate = null;
}