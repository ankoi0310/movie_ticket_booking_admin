import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/combo.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/product.dart';

class ComboItem extends General {
  Product? product;
  int quantity;
  Combo? combo;

  ComboItem({
    required int id,
    required this.product,
    required this.quantity,
    required this.combo,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(id: id, state: state, createdDate: createdDate, modifiedDate: modifiedDate, deletedDate: deletedDate);

  @override
  bool operator ==(other) {
    return (other is ComboItem) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  ComboItem.empty()
      : product = Product.empty(),
        quantity = 0,
        combo = null,
        super.empty();

  factory ComboItem.initial({required Product product, required int quantity}) {
    return ComboItem(
      id: 0,
      combo: null,
      product: product,
      quantity: quantity,
      state: GeneralState.active,
      createdDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      deletedDate: null,
    );
  }

  factory ComboItem.fromJson(Map<String, dynamic> json) {
    return ComboItem(
      id: json['id'],
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      quantity: json['quantity'],
      combo: json['combo'] != null ? Combo.fromJson(json['combo']) : null,
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null ? DateTime.parse(json['deletedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product != null ? product!.toJson() : null,
      'quantity': quantity,
      'combo': combo != null ? combo!.toJson() : null,
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!) : null,
    };
  }
}
