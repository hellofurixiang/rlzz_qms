package com.szrlzz.qms.chart;

import androidx.annotation.IntDef;

/**
 * @author furx
 * @date 2019/7/23
 */

public class ReportType {
    /**
     * 按月统计
     */
    static final int REPORT_FOR_MONTH = 0;
    /**
     * 按周统计
     */
    static final int REPORT_FOR_WEEK = 1;
    /**
     * 按供应商统计
     */
    static final int REPORT_FOR_SUPPLIER = 2;

    @IntDef({REPORT_FOR_MONTH, REPORT_FOR_WEEK, REPORT_FOR_SUPPLIER})
    public @interface Type {
    }
}
