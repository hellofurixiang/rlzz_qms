package com.szrlzz.qms;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.webkit.MimeTypeMap;

import com.szrlzz.qms.chart.ChartViewPlugin;
import com.szrlzz.qms.flutterbugly.FlutterBuglyPlugin;
import com.szrlzz.qms.imagepicker.ImagePickerPlugin;
import com.szrlzz.qms.plugin.ConnectivityPlugin;
import com.szrlzz.qms.plugin.DownloadsPathProviderPlugin;
import com.szrlzz.qms.plugin.FilePickerPlugin;
import com.szrlzz.qms.plugin.DeviceInfoPlugin;
import com.szrlzz.qms.plugin.PackageInfoPlugin;
import com.szrlzz.qms.plugin.PathProviderPlugin;
import com.szrlzz.qms.plugin.SimplePermissionsPlugin;

import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.UnknownHostException;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import jcifs.UniAddress;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;
import jcifs.smb.SmbFileOutputStream;
import jcifs.smb.SmbSession;

/**
 * @author furx
 */
public class MainActivity extends FlutterActivity {

    private static final String FLUTTER_CHANNEL = "flutter_android_channel";
    private static final String LOG_PRINT = "logPrint";
    private static final String OPEN_FILE = "openFile";
    private static final String OPEN_SHARED_FILE = "openSharedFile";


    private Context mContext = null;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        GeneratedPluginRegistrant.registerWith(this);
        ChartViewPlugin.registerWith(this);


        FilePickerPlugin.registerWith(this.registrarFor(FilePickerPlugin.class.getCanonicalName()));
        PackageInfoPlugin.registerWith(this.registrarFor(PackageInfoPlugin.class.getCanonicalName()));
        ConnectivityPlugin.registerWith(this.registrarFor(ConnectivityPlugin.class.getCanonicalName()));
        DeviceInfoPlugin.registerWith(this.registrarFor(DeviceInfoPlugin.class.getCanonicalName()));
        ImagePickerPlugin.registerWith(this.registrarFor(ImagePickerPlugin.class.getCanonicalName()));
        DownloadsPathProviderPlugin.registerWith(this.registrarFor(DownloadsPathProviderPlugin.class.getCanonicalName()));
        PathProviderPlugin.registerWith(this.registrarFor(PathProviderPlugin.class.getCanonicalName()));
        FlutterBuglyPlugin.registerWith(this.registrarFor(FlutterBuglyPlugin.class.getCanonicalName()));
        SimplePermissionsPlugin.registerWith(this.registrarFor(SimplePermissionsPlugin.class.getCanonicalName()));


        //通过methodCall可以获取参数和方法名 执行对应的平台业务逻辑即可
        new MethodChannel(getFlutterView(), FLUTTER_CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    //通过methodCall可以获取参数和方法名  执行对应的平台业务逻辑即可

                    if (LOG_PRINT.equals(methodCall.method)) {
                        logPrint(methodCall);
                    } else if (OPEN_FILE.equals(methodCall.method)) {
                        openFile(mContext, methodCall, result);
                    } else if (OPEN_SHARED_FILE.equals(methodCall.method)) {
                        openSharedFile(mContext, methodCall, result);
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

    /**
     * 打印日志
     * Log.v("w", "测试错误w");
     * Log.d("d", "测试错误d");
     * Log.i("i", "测试错误i");
     * Log.w("w", "测试错误w");
     * Log.e("e", "测试错误e");
     *
     * @param methodCall 参数
     */
    private void logPrint(MethodCall methodCall) {

        String logType = methodCall.argument("logType");
        String tag = methodCall.argument("tag");
        String msg = methodCall.argument("msg");


        if (tag == null) {
            tag = "other";
        }
        if (msg == null) {
            msg = "error";
        }
        if (logType == null) {
            Log.i(tag, msg);
            return;
        }
        switch (logType) {
            case "logV":
                Log.v(tag, msg);
                break;
            case "logD":
                Log.d(tag, msg);
                break;
            case "logI":
                Log.i(tag, msg);
                break;
            case "logW":
                Log.w(tag, msg);
                break;
            case "logE":
                Log.e(tag, msg);
                break;
            default:
                Log.i(tag, msg);
                break;
        }
    }

    /**
     * 打开文件
     *
     * @param context    上下文
     * @param methodCall 参数
     */
    private void openFile(Context context, MethodCall methodCall, MethodChannel.Result result) {

        String path = methodCall.argument("path");
        String nameType = methodCall.argument("nameType");

        if (null == path) {
            return;
        }
        try {
            if (path.contains("file://")) {
                path = "file://$path";
            }
            //获取文件类型
            String mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(nameType);
            Intent intent = new Intent();

            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.setAction(Intent.ACTION_VIEW);
            //设置文件的路径和文件类型
            intent.setDataAndType(Uri.parse(path), mimeType);
            //跳转
            context.startActivity(intent);
        } catch (Exception e) {
            System.out.println("333333333");
            System.out.println(e);
            result.success(e.getMessage());
        }

    }

    /**
     * 打开共享文件
     *
     * @param context    上下文
     * @param methodCall 参数
     */
    private void openSharedFile(Context context, MethodCall methodCall, MethodChannel.Result result) {

        try {
            String path = methodCall.argument("path");
            String nameType = methodCall.argument("nameType");


            String ip = methodCall.argument("ip");
            String username = methodCall.argument("username");
            String password = methodCall.argument("password");

            ip = "192.168.47.19";//pc地址
            username = "rlzz";//账户密码
            password = "rlzz@123";
            UniAddress mDomain = null;

            //登录授权
            //mDomain = UniAddress.getByName(ip);
            NtlmPasswordAuthentication mAuthentication = new NtlmPasswordAuthentication(ip, username, password);
            //SmbSession.logon(mDomain, mAuthentication);
            //登录授权结束
            path = "smb://rlzz:rlzz@123" + ip + "/rlzz files/2.产品研发/机械行业MES文档U8+V13.0/1.pdf";

            SmbFile smbFile = new SmbFile(path, mAuthentication);
            //smbFile.connect();
            System.out.println("连接成功...url：" + path);

            //InputStream is = smbFile.getInputStream();


            // output is like smb://mypc/e/sharedfoldername/file.txt;
            SmbFileOutputStream out = new SmbFileOutputStream(smbFile);
            //out.write(text.getBytes());
            out.flush();
            out.close();

            //获取文件类型
                    /*String mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension("pdf");
                    Intent intent = new Intent();

                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    intent.setAction(Intent.ACTION_VIEW);
                    //设置文件的路径和文件类型
                    intent.setDataAndType(Uri.parse(path), mimeType);
                    //跳转
                    context.startActivity(intent);*/


        } catch (Exception e) {
            System.out.println("异常：" + e.getMessage());
            result.success(e.getMessage());
        }

    }


    private abstract class DownloadFilesTask extends AsyncTask<Context, MethodCall,String> {
        protected String doInBackground(Context context, MethodCall methodCall) {

            return "";
        }

        protected void onProgressUpdate(Integer... progress) {
            //setProgressPercent(progress[0]);
        }

        protected void onPostExecute(Long result) {
            //showDialog("Downloaded " + result + " bytes");
        }
    }


}
