package com.szrlzz.qms.chart;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * @author furx rxfu@szrlzz.com
 * @date 2019-07-23  10:41
 * 作用: chart报表
 */
public class ChartViewFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;

    ChartViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @SuppressWarnings("unchecked")
    @Override
    public PlatformView create(Context context, int id, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
        return new ChartView(context, messenger, id, params);
    }

}
