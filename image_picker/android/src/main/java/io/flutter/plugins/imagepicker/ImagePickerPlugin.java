// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.imagepicker;

import android.os.Environment;
//import android.support.annotation.VisibleForTesting;
import androidx.annotation.VisibleForTesting;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import java.io.File;

public class ImagePickerPlugin implements MethodChannel.MethodCallHandler {
  private static final String CHANNEL = "plugins.flutter.io/image_picker";

  private static final int SOURCE_CAMERA = 0;
  private static final int SOURCE_GALLERY = 1;

  private final PluginRegistry.Registrar registrar;
  private final ImagePickerDelegate delegate;

  public static void registerWith(PluginRegistry.Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);

    final File externalFilesDirectory =
        registrar.activity().getExternalFilesDir(Environment.DIRECTORY_PICTURES);
    final ExifDataCopier exifDataCopier = new ExifDataCopier();
    final ImageResizer imageResizer = new ImageResizer(externalFilesDirectory, exifDataCopier);

    final ImagePickerDelegate delegate =
        new ImagePickerDelegate(registrar.activity(), externalFilesDirectory, imageResizer);
    registrar.addActivityResultListener(delegate);
    registrar.addRequestPermissionsResultListener(delegate);

    final ImagePickerPlugin instance = new ImagePickerPlugin(registrar, delegate);
    channel.setMethodCallHandler(instance);
  }

  @VisibleForTesting
  ImagePickerPlugin(PluginRegistry.Registrar registrar, ImagePickerDelegate delegate) {
    this.registrar = registrar;
    this.delegate = delegate;
  }

  @Override
  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
    if (registrar.activity() == null) {
      result.error("no_activity", "image_picker plugin requires a foreground activity.", null);
      return;
    }
    if (call.method.equals("pickImage")) {
      int imageSource = call.argument("source");
      switch (imageSource) {
        case SOURCE_GALLERY:
          delegate.chooseImageFromGallery(call, result);
          break;
        case SOURCE_CAMERA:
          delegate.takeImageWithCamera(call, result);
          break;
        default:
          throw new IllegalArgumentException("Invalid source: " + imageSource);
      }
    } else if (call.method.equals("pickVideo")) {
      int imageSource = call.argument("source");
      switch (imageSource) {
        case SOURCE_GALLERY:
          delegate.chooseVideoFromGallery(call, result);
          break;
        case SOURCE_CAMERA:
          delegate.takeVideoWithCamera(call, result);
          break;
        default:
          throw new IllegalArgumentException("Invalid video source: " + imageSource);
      }
    } else {
      throw new IllegalArgumentException("Unknown method " + call.method);
    }
  }
}
