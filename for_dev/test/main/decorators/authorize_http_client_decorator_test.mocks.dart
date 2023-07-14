// Mocks generated by Mockito 5.4.0 from annotations
// in for_dev/test/main/decorators/authorize_http_client_decorator_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:for_dev/data/cache/fetch_secure_cache_storage.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FetchSecureCacheStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchSecureCacheStorage extends _i1.Mock
    implements _i2.FetchSecureCacheStorage {
  @override
  _i3.Future<String?> fetchSecure(String? key) => (super.noSuchMethod(
        Invocation.method(
          #fetchSecure,
          [key],
        ),
        returnValue: _i3.Future<String?>.value(),
        returnValueForMissingStub: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);
}
