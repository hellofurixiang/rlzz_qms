package com.szrlzz.qms.chart;

import io.flutter.plugin.common.PluginRegistry;

/**
 * @author furx rxfu@szrlzz.com
 * @date 2019-07-23  10:41
 * 作用: TODO
 */
public class ChartViewPlugin {

    public static void registerWith(PluginRegistry registry) {
        final String key = ChartViewPlugin.class.getCanonicalName();

        if (registry.hasPlugin(key)) {
            return;
        }

        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("com.szrlzz.qms/combinedChart", new ChartViewFactory(registrar.messenger()));
    }


}
