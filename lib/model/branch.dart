import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';

enum BranchStatus {
  active("ACTIVE"),
  inactive("INACTIVE");

  final String value;

  const BranchStatus(this.value);

  factory BranchStatus.fromValue(String value) {
    return BranchStatus.values.firstWhere((e) => e.value == value);
  }
}

class Branch extends General {
  String name;
  String address;
  BranchStatus branchStatus;

  Branch({
    required int id,
    required this.name,
    required this.address,
    required this.branchStatus,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(
            id: id,
            state: state,
            createdDate: createdDate,
            modifiedDate: modifiedDate,
            deletedDate: deletedDate);

  Branch.empty()
      : name = '',
        address = '',
        branchStatus = BranchStatus.active,
        super.empty();

  @override
  bool operator ==(other) {
    return (other is Branch) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      branchStatus: BranchStatus.fromValue(json['branchStatus']),
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate:
          DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'branchStatus': branchStatus.value,
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }
}
