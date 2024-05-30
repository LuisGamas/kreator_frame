// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widgets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getWidgetsHash() => r'bb2710252125cb4a59e2bef9690886a2b26e2fee';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getWidgets].
@ProviderFor(getWidgets)
const getWidgetsProvider = GetWidgetsFamily();

/// See also [getWidgets].
class GetWidgetsFamily extends Family<AsyncValue<List<WidgetEntity>>> {
  /// See also [getWidgets].
  const GetWidgetsFamily();

  /// See also [getWidgets].
  GetWidgetsProvider call(
    String widgetExt,
  ) {
    return GetWidgetsProvider(
      widgetExt,
    );
  }

  @override
  GetWidgetsProvider getProviderOverride(
    covariant GetWidgetsProvider provider,
  ) {
    return call(
      provider.widgetExt,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getWidgetsProvider';
}

/// See also [getWidgets].
class GetWidgetsProvider extends FutureProvider<List<WidgetEntity>> {
  /// See also [getWidgets].
  GetWidgetsProvider(
    String widgetExt,
  ) : this._internal(
          (ref) => getWidgets(
            ref as GetWidgetsRef,
            widgetExt,
          ),
          from: getWidgetsProvider,
          name: r'getWidgetsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getWidgetsHash,
          dependencies: GetWidgetsFamily._dependencies,
          allTransitiveDependencies:
              GetWidgetsFamily._allTransitiveDependencies,
          widgetExt: widgetExt,
        );

  GetWidgetsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.widgetExt,
  }) : super.internal();

  final String widgetExt;

  @override
  Override overrideWith(
    FutureOr<List<WidgetEntity>> Function(GetWidgetsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetWidgetsProvider._internal(
        (ref) => create(ref as GetWidgetsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        widgetExt: widgetExt,
      ),
    );
  }

  @override
  FutureProviderElement<List<WidgetEntity>> createElement() {
    return _GetWidgetsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetWidgetsProvider && other.widgetExt == widgetExt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, widgetExt.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetWidgetsRef on FutureProviderRef<List<WidgetEntity>> {
  /// The parameter `widgetExt` of this provider.
  String get widgetExt;
}

class _GetWidgetsProviderElement
    extends FutureProviderElement<List<WidgetEntity>> with GetWidgetsRef {
  _GetWidgetsProviderElement(super.provider);

  @override
  String get widgetExt => (origin as GetWidgetsProvider).widgetExt;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
