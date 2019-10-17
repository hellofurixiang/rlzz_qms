package com.szrlzz.qms.chart;

import android.graphics.Color;
import androidx.annotation.NonNull;

import com.github.mikephil.charting.charts.CombinedChart;
import com.github.mikephil.charting.components.XAxis;
import com.github.mikephil.charting.components.YAxis;
import com.github.mikephil.charting.data.BarData;
import com.github.mikephil.charting.data.BarDataSet;
import com.github.mikephil.charting.data.BarEntry;
import com.github.mikephil.charting.data.CombinedData;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.szrlzz.qms.BigDecimalUtil;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

/**
 * @author furx
 * @date 2019/7/23
 */

class ChartHelper {

    static final Integer[] COLORS = {
            Color.parseColor("#46BFBD"),
            Color.parseColor("#FDB45C"),
            Color.parseColor("#949FB1"),
            Color.parseColor("#F7464A"),
            Color.parseColor("#836FFF"),
            Color.parseColor("#8B0A50"),
            Color.parseColor("#4D5360")};

    static void showMultiCombinedChart(CombinedChart chart, List<List<BigDecimal>> yAxisBarValues, List<List<BigDecimal>> yAxisLineValues, final List<String> labels, List<Integer> colors) {
        initChart(chart);

        if (yAxisBarValues == null) {
            chart.setData(null);
            return;
        }
        setXAxis(chart, labels);

        YAxis axisLeft = chart.getAxisLeft();

        axisLeft.setAxisMinimum(0f);

        CombinedData combinedData = new CombinedData();
        BarData barData = getBarData(yAxisBarValues, colors);
        combinedData.setData(barData);
        chart.setData(combinedData);

        setYAxisRight(chart);

        LineData lineData = new LineData();

        BigDecimal yMax = BigDecimalUtil.createBigDecimal(chart.getBarData().getYMax());

        getLineData(yMax, lineData, yAxisLineValues.get(0), colors.get(4), "批合格率");
        getLineData(yMax, lineData, yAxisLineValues.get(1), colors.get(5), "合格率");

        combinedData.setData(lineData);
        chart.setData(combinedData);


        chart.notifyDataSetChanged();
        chart.invalidate();
    }

    private static void initChart(CombinedChart chart) {
        chart.setNoDataText("没有数据");
        //chart.setNoDataTextColor("没有数据");
        chart.setTouchEnabled(false);
        chart.getDescription().setEnabled(false);
        // 设置比例缩放
        chart.setPinchZoom(false);
        // 设置绘画顺序 先绘制柱形图，再绘制折线图
        chart.setDrawOrder(new CombinedChart.DrawOrder[]{
                CombinedChart.DrawOrder.BAR,
                CombinedChart.DrawOrder.LINE
        });
        // 显示边界
        chart.setDrawBorders(true);
        // 第一次渲染时动画执行时长
        chart.animateY(1200);
    }

    /**
     * 设置X轴数据
     *
     * @param chart
     * @param labels
     */
    private static void setXAxis(CombinedChart chart, final List<String> labels) {
        XAxis xAxis = chart.getXAxis();
        xAxis.setGranularity(1f);
        xAxis.setDrawGridLines(false);
        xAxis.setLabelCount(labels.size(), false);
        xAxis.setPosition(XAxis.XAxisPosition.BOTTOM);
        //x轴文本标签倾斜角度
        xAxis.setLabelRotationAngle(-20);
        xAxis.setValueFormatter((value, axis) -> {
            if (labels.size() > 0) {
                return labels.get((int) value % labels.size());
            } else {
                return 0 + "";
            }
        });
        // 解决左右两边只显示一半的问题
        xAxis.setAxisMinimum(-0.5f);
        xAxis.setAxisMaximum(labels.size() - 0.5f);
    }

    @NonNull
    private static BarData getBarData(List<List<BigDecimal>> yAxisValues, List<Integer> colours) {
        BarData barData = new BarData();
        // 外层循环控制多组数据
        for (int i = 0; i < yAxisValues.size(); i++) {
            List<BigDecimal> floats = yAxisValues.get(i);
            List<BarEntry> barEntries = new ArrayList<>();
            // 内层循环控制某一组中的数据
            for (int j = 0; j < floats.size(); j++) {
                BigDecimal bigDecimal = floats.get(j);
                if (bigDecimal == null) {
                    bigDecimal = new BigDecimal(0);
                }
                barEntries.add(new BarEntry(j, bigDecimal.floatValue()));
            }
            BarDataSet barDataSet = new BarDataSet(barEntries, i == 0 ? "送检批数" : "合格批数");
            barDataSet.setColor(colours.get(i));
            //不显示值
            barDataSet.setDrawValues(false);
            barData.addDataSet(barDataSet);
        }
        //柱状图组之间的间距
        float groupSpace = 0.1f;
        // x4 DataSet
        float barSpace = 0f;
        // x4 DataSet
        float barWidth = 0.45f;

        barData.setBarWidth(barWidth);

        barData.groupBars(-0.5f, groupSpace, barSpace);
        return barData;
    }

    /**
     * 设置右侧Y轴数据
     *
     * @param chart
     */
    private static void setYAxisRight(CombinedChart chart) {
        final YAxis axisLeft = chart.getAxisLeft();
        final YAxis axisRight = chart.getAxisRight();

        float yMax = chart.getBarData().getYMax();

        axisRight.setDrawGridLines(false);

        axisRight.setGranularity(10);
        axisRight.setAxisMinimum(0);
        axisRight.setAxisMaximum(axisLeft.getAxisMaximum() / yMax * 100);
        axisRight.setValueFormatter((value, axis) -> {
            return value + "%";
        });
    }

    private static void getLineData(BigDecimal yMax, LineData lineData, List<BigDecimal> yAxisLineValues, Integer color, String label) {

        /*计算合格率 - 根据柱形图的数据计算，合格数量/送检批数*/
        List<Entry> lineEntries = new ArrayList<>();

        BigDecimal a100 = new BigDecimal(100);
        for (int i = 0; i < yAxisLineValues.size(); i++) {
            float v = yAxisLineValues.get(i).multiply(yMax).divide(a100, RoundingMode.UP).floatValue();
            lineEntries.add(new Entry(i, v));
        }
        LineDataSet lineDataSet = new LineDataSet(lineEntries, label);
        lineDataSet.setValueTextColor(color);
        lineDataSet.setColor(color);
        lineDataSet.setCircleColor(color);
        lineData.addDataSet(lineDataSet);


        lineData.setValueFormatter((value, entry, dataSetIndex, viewPortHandler) -> {

            return yAxisLineValues.get((int) entry.getX()).toPlainString() + "%";
        });

        lineData.setHighlightEnabled(false);

    }


}
