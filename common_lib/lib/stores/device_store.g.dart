// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DeviceStore on _DeviceStore, Store {
  Computed<List<dynamic>>? _$mapValuesComputed;

  @override
  List<dynamic> get mapValues =>
      (_$mapValuesComputed ??= Computed<List<dynamic>>(() => super.mapValues,
              name: '_DeviceStore.mapValues'))
          .value;

  late final _$yourMapAtom =
      Atom(name: '_DeviceStore.yourMap', context: context);

  @override
  ObservableMap<String, dynamic> get yourMap {
    _$yourMapAtom.reportRead();
    return super.yourMap;
  }

  @override
  set yourMap(ObservableMap<String, dynamic> value) {
    _$yourMapAtom.reportWrite(value, super.yourMap, () {
      super.yourMap = value;
    });
  }

  late final _$deviceListAtom =
      Atom(name: '_DeviceStore.deviceList', context: context);

  @override
  ObservableList<VirtualDevice> get deviceList {
    _$deviceListAtom.reportRead();
    return super.deviceList;
  }

  @override
  set deviceList(ObservableList<VirtualDevice> value) {
    _$deviceListAtom.reportWrite(value, super.deviceList, () {
      super.deviceList = value;
    });
  }

  late final _$_DeviceStoreActionController =
      ActionController(name: '_DeviceStore', context: context);

  @override
  void updateDeviceList(List<VirtualDevice> list) {
    final _$actionInfo = _$_DeviceStoreActionController.startAction(
        name: '_DeviceStore.updateDeviceList');
    try {
      return super.updateDeviceList(list);
    } finally {
      _$_DeviceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDeviceById2(String deviceId) {
    final _$actionInfo = _$_DeviceStoreActionController.startAction(
        name: '_DeviceStore.updateDeviceById2');
    try {
      return super.updateDeviceById2(deviceId);
    } finally {
      _$_DeviceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDeviceById(String deviceId) {
    final _$actionInfo = _$_DeviceStoreActionController.startAction(
        name: '_DeviceStore.updateDeviceById');
    try {
      return super.updateDeviceById(deviceId);
    } finally {
      _$_DeviceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
yourMap: ${yourMap},
deviceList: ${deviceList},
mapValues: ${mapValues}
    ''';
  }
}
