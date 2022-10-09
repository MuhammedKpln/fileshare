// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/posts/controllers/post_details_view.controller.dart'
    as _i6;
import '../../features/posts/controllers/posts_view.controller.dart' as _i4;
import '../../features/posts/repositories/posts.repository.dart' as _i3;
import '../../test.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.PostsRepository>(() => _i3.PostsRepository());
  gh.lazySingleton<_i4.PostsViewController>(
      () => _i4.PostsViewController(get<_i3.PostsRepository>()));
  gh.lazySingleton<_i5.TestDi>(() => _i5.TestDi());
  gh.lazySingleton<_i6.PostDetailsViewController>(
      () => _i6.PostDetailsViewController(get<_i3.PostsRepository>()));
  return get;
}
