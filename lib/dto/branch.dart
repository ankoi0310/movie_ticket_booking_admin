import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/general.dart';

enum BranchStatus {
  active('ACTIVE'),
  inactive('INACTIVE');

  final String value;

  const BranchStatus(this.value);

  static BranchStatus fromValue(String value) {
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
  }) : super(id: id, state: state, createdDate: createdDate, modifiedDate: modifiedDate, deletedDate: deletedDate);

  Branch.empty()
      : name = '',
        address = '',
        branchStatus = BranchStatus.active,
        super.empty();

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      branchStatus: BranchStatus.fromValue(json['status']),
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['deletedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'status': branchStatus.value,
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!) : null,
    };
  }
}
