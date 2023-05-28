import 'package:hive/hive.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/hive/local_data_provider_contract.dart';

class HiveProvider implements LocalDataProviderContract {
  HiveProvider._();

  static final HiveProvider _instance = HiveProvider._();

  static HiveProvider get instance => _instance;

  Future<Box> _getBox(String table) async {
    return await Hive.openBox(table);
  }

  @override
  Future<void> insert({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    Box box = await _getBox(table);
    if (values.isNotEmpty) {
      values.forEach((k, v) => box.put(k, v));
    }
  }

  @override
  Future<Map<String, dynamic>> read({
    required String table,
    bool? distinct,
    List<String> keys = const [],
    List<String> columns = const [],
    String? whereClauseValue,
    List? whereClauseArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
  }) async {
    Box box = await _getBox(table);
    if (keys.isEmpty) {
      return Map<String, dynamic>.from(box.toMap());
    }
    Map<String, dynamic> data = {};
    for (var k in keys) {
      data[k] = box.get(k);
    }
    return data;
  }

  @override
  Future delete({
    required String table,
    String? whereClauseValue,
    List whereClauseArgs = const [],
    List<String> keys = const [],
  }) async {
    Box box = await _getBox(table);
    // empty box
    if (keys.isEmpty) {
      await box.clear();
      return;
    }
    await Future.wait(keys.map((key) => box.delete(key)));
    for (var key in keys) {
      box.delete(key);
    }
  }

  @override
  Future update({required String table, required Map<String, dynamic> values, String? whereClauseValue, List whereClauseArgs = const []}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
