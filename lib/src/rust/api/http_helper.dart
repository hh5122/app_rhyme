// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.32.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<String> sendRequest(
        {required String method,
        required Map<String, String> headers,
        required String url,
        required String payload,
        dynamic hint}) =>
    RustLib.instance.api.sendRequest(
        method: method,
        headers: headers,
        url: url,
        payload: payload,
        hint: hint);