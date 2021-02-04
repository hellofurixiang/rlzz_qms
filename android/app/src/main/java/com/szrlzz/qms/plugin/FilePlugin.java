package com.szrlzz.qms.plugin;

import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Environment;
import android.util.Log;
import android.webkit.MimeTypeMap;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbFile;

/**
 * FilePlugin
 */
public class FilePlugin implements MethodCallHandler {

    private static final String OPEN_FILE = "openFile";
    private static final String OPEN_SHARED_FILE = "openSharedFile";

    private static Registrar registrar;

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel =
                new MethodChannel(registrar.messenger(), "com.szrlzz.qms/file");
        channel.setMethodCallHandler(new FilePlugin(registrar));
    }

    private FilePlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {

        if (OPEN_FILE.equals(methodCall.method)) {
            openFile(methodCall, result);
        } else if (OPEN_SHARED_FILE.equals(methodCall.method)) {
            openSharedFile(methodCall, result);
        } else {
            result.notImplemented();
        }

    }

    /**
     * 打开文件
     *
     * @param methodCall 参数
     */
    private void openFile(MethodCall methodCall, MethodChannel.Result result) {

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
            registrar.context().startActivity(intent);
        } catch (Exception e) {
            System.out.println("333333333");
            System.out.println(e);
            result.success(e.getMessage());
        }

    }

    /**
     * 打开共享文件
     *
     * @param methodCall 参数
     */
    private void openSharedFile(MethodCall methodCall, MethodChannel.Result result) {
        MyCustomTask task = new MyCustomTask(methodCall, result);
        task.execute();
    }


    public static class MyCustomTask extends AsyncTask<Void, Void, String> {
        private String username;
        private String password;
        private String url;
        private String fileName;
        private String nameType;
        private String downloadPath;
        private MethodChannel.Result result;

        MyCustomTask(MethodCall methodCall, MethodChannel.Result result) {
            this.username = methodCall.argument("username");
            this.password = methodCall.argument("password");
            this.url = methodCall.argument("url");
            this.fileName = methodCall.argument("fileName");
            this.nameType = methodCall.argument("nameType");
            this.downloadPath = methodCall.argument("downloadPath");
            this.result = result;
        }

        @Override
        protected String doInBackground(Void... params) {

            try {
                //String user = "rlzz";
                //String pass = "rlzz@123";
                //String url = "smb://192.168.47.19/RLZZ FILES/2.产品研发/机械行业MES文档U8+V13.0/U8+机械行业MES发版说明.doc";
                NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(
                        null, username, password);
                SmbFile smbFile = new SmbFile(url, auth);

                if (!smbFile.exists()) {
                    return "文件不存在";
                }

                File file = new File(downloadPath + fileName);
                if (file.getParentFile().exists()) {
                    Log.i("", "----- 创建文件：" + file.getAbsolutePath());
                    boolean bo1 = file.createNewFile();
                } else {
                    //创建目录之后再创建文件
                    createDir(file.getParentFile().getAbsolutePath());
                    boolean bo1 = file.createNewFile();
                    Log.i("", "----- 创建文件：" + file.getAbsolutePath());
                }

                InputStream inputStream = smbFile.getInputStream();
                FileOutputStream outputStream = new FileOutputStream(file);


                //拷贝文件
                byte[] buffer = new byte[1024];
                int byteRead;
                while ((byteRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, byteRead);
                }
                inputStream.close();
                outputStream.flush();
                outputStream.close();


                //打开文件
                //获取文件类型
                String mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(nameType);
                Intent intent = new Intent();

                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.setAction(Intent.ACTION_VIEW);

                String path = "file://" + file.getPath();
                //设置文件的路径和文件类型
                intent.setDataAndType(Uri.parse(path), mimeType);
                //跳转
                registrar.activity().startActivity(intent);
                return "";
            } catch (Exception e) {
                e.printStackTrace();
                return e.getMessage();
            }

        }

        @Override
        protected void onPostExecute(String msg) {
            result.success(msg);
        }
    }


    private static void createDir(String dirPath) {
        //因为文件夹可能有多层，比如:  a/b/c/ff.txt  需要先创建a文件夹，然后b文件夹然后...

        File file = new File(dirPath);
        if (file.getParentFile().exists()) {
            Log.i("----- 创建文件夹：", file.getAbsolutePath());
            boolean bo = file.mkdir();
        } else {
            createDir(file.getParentFile().getAbsolutePath());
            Log.i("----- 创建文件夹：", file.getAbsolutePath());
            boolean bo = file.mkdir();
        }
    }


}
