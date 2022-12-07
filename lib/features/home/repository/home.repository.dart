import 'package:boilerplate/features/home/models/ip.model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Home repository
@LazySingleton()
class HomeRepository {
  /// `fetchIpAddress` makes a request to the `ip` function.
  ///
  /// Returns:
  ///   A Future<IpService>
  Future<IpService> fetchIpAddress() async {
    final supabase = Supabase.instance.client;
    final request = await supabase.functions.invoke('ip');

    return IpService.fromMap(request.data as Map<String, dynamic>);
  }
}
