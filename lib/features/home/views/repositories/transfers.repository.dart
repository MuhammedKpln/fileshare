import 'package:boilerplate/features/home/models/transfer.model.dart';
import 'package:boilerplate/shared/services/auth.service.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class TransfersRepository {
  final String _table = "transfers";
  final _supabase = Supabase.instance.client;
  final AuthService _authService;

  TransfersRepository(this._authService);

  /// `fetchLatestTransfers` fetches the latest transfers from the database
  Future<ObservableList<Transfer>> fetchLatestTransfers() async {
    try {
      final authId = _authService.user!.id;

      final request = await _supabase
          .from(_table)
          .select("*, from(*), to(*)")
          .or("from.eq.$authId,to.eq.$authId");

      final list = List.from(request as List<dynamic>)
          .map((e) => Transfer.fromMap(e as Map<String, dynamic>))
          .toList();

      return ObservableList.of(list);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteTransfer(int id) async {
    try {
      final request =
          await _supabase.from(_table).delete().eq("id", id).single();

      return request["id"] as int;
    } catch (e) {
      rethrow;
    }
  }
}
