package com.szrlzz.qms.chart;

import android.content.Context;
import android.graphics.Color;
import android.view.View;

import com.github.mikephil.charting.charts.CombinedChart;

import org.jetbrains.annotations.NotNull;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * 直通率图表(组合图表：2列圆柱+2条折线)
 *
 * @author furx
 * @date 2019/7/23
 */

public class ChartView implements PlatformView, MethodChannel.MethodCallHandler {
    //报表类型
    private int reportType;
    //报表控件
    private CombinedChart combinedChart;

    private final MethodChannel methodChannel;

    private List<ArrivalTestOrderStatisticalResVo> list;

    @SuppressWarnings("unchecked")
    ChartView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        List<Map<String, Object>> listMap = (List<Map<String, Object>>) params.get("list");

        if (listMap == null) {
            listMap = new ArrayList<>();
        }

        list = getListInfo(listMap);

        reportType = (int) params.get("reportType");

        System.out.println(params.get("list"));
        System.out.println(params.get("reportType"));

        combinedChart = new CombinedChart(context);
        combinedChart.setBackgroundColor(Color.parseColor("#FFFFFF"));
        showChart();


        methodChannel = new MethodChannel(messenger, "com.szrlzz.qms/combinedChart_" + id);
        methodChannel.setMethodCallHandler(this);


    }

    @NotNull
    private List<ArrivalTestOrderStatisticalResVo> getListInfo(List<Map<String, Object>> listMap) {


        List<ArrivalTestOrderStatisticalResVo> list = new ArrayList<>();

        for (Map<String, Object> map : listMap) {


            String supplierCode = objToStr(map.get("supplierCode"));

            String supplierName = objToStr(map.get("supplierCode"));

            ArrivalTestOrderStatisticalResVo vo = new ArrivalTestOrderStatisticalResVo(supplierCode, supplierName);

            vo.setItemName(objToStr(map.get("itemName")));


            vo.setBatch_qty(objToBigDecimal(map.get("batch_qty")));


            vo.setBatch_qualifiedQty(objToBigDecimal(map.get("batch_qualifiedQty")));
            vo.setBatch_concessionReceivedQuantity(objToBigDecimal(map.get("batch_concessionReceivedQuantity")));
            vo.setBatch_unQualifiedQty(objToBigDecimal(map.get("batch_unQualifiedQty")));
            vo.setBatch_spQty(objToBigDecimal(map.get("batch_spQty")));
            vo.setBatch_reworkQty(objToBigDecimal(map.get("batch_reworkQty")));
            vo.setBatch_scrapQty(objToBigDecimal(map.get("batch_scrapQty")));
            vo.setBatch_qualificationRate(objToBigDecimal(map.get("batch_qualificationRate")));
            vo.setBatch_unQualificationRate(objToBigDecimal(map.get("batch_unQualificationRate")));
            vo.setQty(objToBigDecimal(map.get("qty")));
            vo.setQualifiedQty(objToBigDecimal(map.get("qualifiedQty")));
            vo.setConcessionReceivedQuantity(objToBigDecimal(map.get("concessionReceivedQuantity")));
            vo.setUnQualifiedQty(objToBigDecimal(map.get("unQualifiedQty")));
            vo.setSpQty(objToBigDecimal(map.get("spQty")));
            vo.setReworkQty(objToBigDecimal(map.get("reworkQty")));
            vo.setScrapQty(objToBigDecimal(map.get("scrapQty")));
            vo.setQualificationRate(objToBigDecimal(map.get("qualificationRate")));
            vo.setUnQualificationRate(objToBigDecimal(map.get("unQualificationRate")));

            list.add(vo);
        }

        return list;
    }

    private BigDecimal objToBigDecimal(Object o) {
        if (null == o) {
            return BigDecimal.ZERO;
        }
        return new BigDecimal(o.toString());
    }

    private String objToStr(Object o) {
        if (null == o) {
            return "";
        }
        return o.toString();
    }


    @Override
    public View getView() {
        return combinedChart;
    }

    @Override
    public void dispose() {
    }


    @Override
    @SuppressWarnings("unchecked")
    public void onMethodCall(MethodCall methodCall, @NotNull MethodChannel.Result result) {
        if ("refresh".equals(methodCall.method)) {
            List<Map<String, Object>> listMap = (List<Map<String, Object>>) methodCall.arguments;
            list = getListInfo(listMap);
            showChart();
            result.success(null);
            return;
        }
        result.notImplemented();
    }


    private void showChart() {
        if (list == null || list.size() == 0) {
            ChartHelper.showMultiCombinedChart(combinedChart, null, null, null, Arrays.asList(ChartHelper.COLORS));
            return;
        }
        List<String> titles = new ArrayList<>();
        List<List<BigDecimal>> barData = new ArrayList<>();
        List<BigDecimal> bar1Data = new ArrayList<>();
        List<BigDecimal> bar2Data = new ArrayList<>();


        List<List<BigDecimal>> lineData = new ArrayList<>();
        List<BigDecimal> lineData1 = new ArrayList<>();
        List<BigDecimal> lineData2 = new ArrayList<>();

        for (ArrivalTestOrderStatisticalResVo arrivalTestOrderStatistical : list) {
            if (reportType == ReportType.REPORT_FOR_SUPPLIER) {
                titles.add(arrivalTestOrderStatistical.getSupplierName());
            } else {
                titles.add(arrivalTestOrderStatistical.getItemName());
            }
            BigDecimal batchQty = arrivalTestOrderStatistical.getBatch_qty();
            bar1Data.add(batchQty == null ? BigDecimal.ZERO : setBigDecimalScale(batchQty, 0));

            BigDecimal batchQualifiedQty = arrivalTestOrderStatistical.getBatch_qualifiedQty();
            bar2Data.add(batchQualifiedQty == null ? BigDecimal.ZERO : setBigDecimalScale(batchQualifiedQty, 0));
            BigDecimal batchQualificationRate = arrivalTestOrderStatistical.getBatch_qualificationRate();
            lineData1.add(batchQualificationRate == null ? BigDecimal.ZERO : setBigDecimalScale(batchQualificationRate, 2));

            BigDecimal qualificationRate = arrivalTestOrderStatistical.getQualificationRate();
            lineData2.add(qualificationRate == null ? BigDecimal.ZERO : setBigDecimalScale(qualificationRate, 2));
        }
        barData.add(bar1Data);
        barData.add(bar2Data);

        lineData.add(lineData1);
        lineData.add(lineData2);

        ChartHelper.showMultiCombinedChart(combinedChart, barData, lineData, titles, Arrays.asList(ChartHelper.COLORS));

    }

    private BigDecimal setBigDecimalScale(BigDecimal oldValue, int scale) {
        if (oldValue == null) {
            oldValue = BigDecimal.ZERO;
        }

        return oldValue.setScale(2, BigDecimal.ROUND_HALF_UP);


    }
}
