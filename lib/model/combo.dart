import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/combo_item.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';

class Combo extends General {
  String name;
  int price;
  String image;
  List<ComboItem> comboItems;

  Combo({
    required int id,
    required this.name,
    required this.price,
    required this.image,
    required this.comboItems,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(id: id, state: state, createdDate: createdDate, modifiedDate: modifiedDate, deletedDate: deletedDate);


  @override
  bool operator ==(other) {
    return (other is Combo) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Combo.empty()
      : name = "",
  image= "",
        price = 0,
        comboItems = [],
        super.empty();

  factory Combo.fromJson(Map<String, dynamic> json) {
    return Combo(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      comboItems: json['comboItems'].map<ComboItem>((e) => ComboItem.fromJson(e)).toList(),
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null ? DateTime.parse(json['deletedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'comboItems': comboItems.map((e) => e.toJson()).toList(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!) : null,
    };
  }
}
