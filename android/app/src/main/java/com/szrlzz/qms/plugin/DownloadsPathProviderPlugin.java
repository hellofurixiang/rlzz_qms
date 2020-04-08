package com.szrlzz.qms.plugin;

import android.os.Environment;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * DownloadsPathProviderPlugin
 */
public class DownloadsPathProviderPlugin implements MethodCallHandler {

    private Registrar registrar;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.szrlzz.qms/downloads_path_provider");
        channel.setMethodCallHandler(new DownloadsPathProviderPlugin(registrar));
    }

    private DownloadsPathProviderPlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getExternalStoragePublicDirectory")) {
            result.success(getExternalStoragePublicDirectory());
        } else if (call.method.equals("getExternalFilesDir")) {
            result.success(getExternalFilesDir());
        } else{
            result.notImplemented();
        }
    }

    /**
     * SD卡公有的目录 /storage/sdcard0
     * @return 路径
     */
    private String getExternalStoragePublicDirectory() {
        return Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).getAbsolutePath();
    }
    /**
     * 私有目录 /storage/emulated/0/Android/data/(包名)/files/
     * @return 路径
     */
    private String getExternalFilesDir() {
        return registrar.context().getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS).getAbsolutePath();
    }

}
