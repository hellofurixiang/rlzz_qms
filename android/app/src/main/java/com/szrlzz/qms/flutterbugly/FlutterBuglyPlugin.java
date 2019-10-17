package com.szrlzz.qms.flutterbugly;

import android.app.Activity;
import android.text.TextUtils;

import com.szrlzz.qms.BuildConfig;
import com.szrlzz.qms.flutterbugly.bean.BuglyInitResultInfo;
import com.szrlzz.qms.flutterbugly.utils.JsonUtil;
import com.szrlzz.qms.flutterbugly.utils.MapUtil;
import com.tencent.bugly.Bugly;
import com.tencent.bugly.beta.Beta;
import com.tencent.bugly.beta.UpgradeInfo;
import com.tencent.bugly.crashreport.CrashReport;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterBuglyPlugin
 */
public class FlutterBuglyPlugin implements MethodCallHandler {
    private Activity activity;
    private Result result;
    private boolean isResultSubmitted = false;


    public FlutterBuglyPlugin(Activity activity) {
        this.activity = activity;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.szrlzz.qms/flutter_bugly");
        FlutterBuglyPlugin plugin = new FlutterBuglyPlugin(registrar.activity());
        channel.setMethodCallHandler(plugin);
    }

    @Override
    public void onMethodCall(final MethodCall call, final Result result) {
        isResultSubmitted = false;
        this.result = result;
        if (call.method.equals("initBugly")) {
            if (call.hasArgument("appId")) {
                if (call.hasArgument("enableHotfix")) {
                    Beta.enableHotfix = call.argument("enableHotfix");
                }
                if (call.hasArgument("autoCheckUpgrade")) {
                    Beta.autoCheckUpgrade = call.argument("autoCheckUpgrade");
                }
                if (call.hasArgument("autoDownloadOnWifi")) {
                    Beta.autoDownloadOnWifi = call.argument("autoDownloadOnWifi");
                }
                if (call.hasArgument("initDelay")) {
                    int delay = call.argument("initDelay");
                    Beta.initDelay = delay * 1000;
                }
                if (call.hasArgument("enableNotification")) {
                    Beta.enableNotification = call.argument("enableNotification");
                }
                if (call.hasArgument("upgradeCheckPeriod")) {
                    int period = call.argument("upgradeCheckPeriod");
                    Beta.upgradeCheckPeriod = period * 1000;
                }
                if (call.hasArgument("showInterruptedStrategy")) {
                    Beta.showInterruptedStrategy = call.argument("showInterruptedStrategy");
                }
                if (call.hasArgument("canShowApkInfo")) {
                    Beta.canShowApkInfo = call.argument("canShowApkInfo");
                }
                Beta.canShowUpgradeActs.add(activity.getClass());
                Bugly.init(activity.getApplicationContext(), call.argument("appId").toString(), BuildConfig.DEBUG);
                result(getResultBean(true, "Bugly 初始化成功"));
            } else {
                result(getResultBean(false, "Bugly key不能为空"));
            }
        } else if (call.method.equals("checkUpgrade")) {
            boolean isManual = false;
            boolean isSilence = false;
            if (call.hasArgument("isManual")) {
                isManual = call.argument("isManual");
            }
            if (call.hasArgument("isSilence")) {
                isSilence = call.argument("isSilence");
            }
            Beta.checkUpgrade(isManual, isSilence);
            result(null);
        } else if (call.method.equals("upgradeListener")) {
            UpgradeInfo strategy = Beta.getUpgradeInfo();
            result(strategy);
        } else if (call.method.equals("postCatchedException")) {
            String message = "";
            String detail = null;
            if (call.hasArgument("crash_message")) {
                message = call.argument("crash_message");
            }
            if (call.hasArgument("crash_detail")) {
                detail = call.argument("crash_detail");
            }
            if (TextUtils.isEmpty(detail)) return;
            String[] details = detail.split("#");
            List<StackTraceElement> elements = new ArrayList<>();
            for (String s : details) {
                if (!TextUtils.isEmpty(s)) {
                    String methodName = null;
                    String fileName = null;
                    int lineNum = -1;
                    String[] contents = s.split(" \\(");
                    if (contents.length > 0) {
                        methodName = contents[0];
                        if (contents.length < 2) {
                            break;
                        }
                        String packageContent = contents[1].replace(")", "");
                        String[] packageContentArray = packageContent.split("\\.dart:");
                        if (packageContentArray.length > 0) {
                            if (packageContentArray.length == 1) {
                                fileName = packageContentArray[0];
                            } else {
                                fileName = packageContentArray[0] + ".dart";
                                Pattern patternTrace = Pattern.compile("[1-9]\\d*");
                                Matcher m = patternTrace.matcher(packageContentArray[1]);
                                if (m.find()) {
                                    String lineNumStr = m.group();
                                    lineNum = Integer.parseInt(lineNumStr);
                                }
                            }
                        }
                    }
                    StackTraceElement element = new StackTraceElement("Dart", methodName, fileName, lineNum);
                    elements.add(element);
                }
            }
            Throwable throwable = new Throwable(message);
            if (elements.size() > 0) {
                StackTraceElement[] elementsArray = new StackTraceElement[elements.size()];
                throwable.setStackTrace(elements.toArray(elementsArray));
            }
            CrashReport.postCatchedException(throwable);
            result(null);
        } else {
            result.notImplemented();
            isResultSubmitted = true;
        }

    }

    private void result(Object object) {
        if (result != null && !isResultSubmitted) {
            if (object == null) {
                result.success(null);
            } else {
                result.success(JsonUtil.toJson(MapUtil.deepToMap(object)));
            }
            isResultSubmitted = true;
        }
    }

    private BuglyInitResultInfo getResultBean(boolean isSuccess, String msg) {
        BuglyInitResultInfo bean = new BuglyInitResultInfo();
        bean.setSuccess(isSuccess);
        bean.setMessage(msg);
        return bean;
    }
}