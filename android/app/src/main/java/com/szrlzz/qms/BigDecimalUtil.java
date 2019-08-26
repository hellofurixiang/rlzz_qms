package com.szrlzz.qms;

import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 * ${Description}
 *
 * @author furx
 * @date 2019/7/23
 */

public class BigDecimalUtil {
    private static int scale = 2;//MySelfInfo.getInstance().getQtyScale();

    public static BigDecimal createBigDecimal() {
        BigDecimal bigDecimal = new BigDecimal(Double.valueOf(0));
        bigDecimal.setScale(scale, BigDecimal.ROUND_HALF_UP);
        return bigDecimal;
    }

    public static BigDecimal createBigDecimal(float flo) {
        BigDecimal bigDecimal = new BigDecimal(flo);
        bigDecimal.setScale(scale, BigDecimal.ROUND_HALF_UP);
        return bigDecimal;
    }

    public static BigDecimal createBigDecimal(Double dou) {
        BigDecimal bigDecimal = new BigDecimal(dou);
        bigDecimal.setScale(scale, BigDecimal.ROUND_HALF_UP);
        return bigDecimal;
    }

    public static BigDecimal createBigDecimal(String string) {
        BigDecimal bigDecimal = new BigDecimal(string);
        bigDecimal.setScale(scale, BigDecimal.ROUND_HALF_UP);
        return bigDecimal;
    }

    public static BigDecimal convertBigDecimal(BigDecimal bigDecimal) {

        if (null != bigDecimal) {
            bigDecimal = bigDecimal.setScale(scale, BigDecimal.ROUND_HALF_UP);
        }
        return bigDecimal;
    }

    public static String convert2Str(BigDecimal bigDecimal) {
        if (bigDecimal == null) {
            return "";
        }
        return bigDecimal.setScale(scale).toPlainString();
    }

    public static BigDecimal addZero(BigDecimal big, int scale) {
        StringBuilder builder = new StringBuilder("0.");
        for (int i = 0; i < scale; i++) {
            builder.append("0");
        }
        DecimalFormat decimalFormat = new DecimalFormat(builder.toString());
        return new BigDecimal(decimalFormat.format(big));
    }

    public static String convert2Not0(BigDecimal bigDecimal) {
        if (bigDecimal == null) {
            return new BigDecimal(0).setScale(scale).toPlainString();
        }
        return bigDecimal.setScale(scale).toPlainString();
    }

    /**
     * 提供精确减法运算的sub方法
     *
     * @param value1 被减数
     * @param value2 减数
     * @return 两个参数的差
     */
    public static double sub(BigDecimal value1, BigDecimal value2) {
        if (value1 == null) {
            value1 = new BigDecimal(0).setScale(scale);
        }
        if (value2 == null) {
            value2 = new BigDecimal(0).setScale(scale);
        }
        return value1.subtract(value2).doubleValue();
    }

    /**
     * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指定精度，以后的数字四舍五入。
     *
     * @param value1 被除数
     * @param value1 除数
     * @return 两个参数的商
     */
    public static double div(double value1, double value2) throws IllegalAccessException {
        if (scale < 0) {
            //如果精确范围小于0，抛出异常信息。
            throw new IllegalArgumentException("精确度不能小于0");
        } else if (value2 == 0) {
            //如果除数为0，抛出异常信息。
            throw new IllegalArgumentException("除数不能为0");
        }
        BigDecimal b1 = new BigDecimal(Double.valueOf(value1));
        BigDecimal b2 = new BigDecimal(Double.valueOf(value2));
        return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * 提供精确加法计算的add方法，确认精确度
     *
     * @param value1 被加数
     * @param value2 加数
     * @param scale  小数点后保留几位
     * @return 两个参数求和之后，按精度四舍五入的结果
     */
    public static double add(double value1, double value2, int scale) {
        return round(add(value1, value2), scale);
    }

    /**
     * 提供精确的小数位四舍五入处理。
     *
     * @param v     需要四舍五入的数字
     * @param scale 小数点后保留几位
     * @return 四舍五入后的结果
     */
    public static double round(double v, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException("精确度不能小于0");
        }
        BigDecimal b = new BigDecimal(Double.toString(v));
        BigDecimal one = new BigDecimal("1");
        return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * 提供精确加法计算的add方法
     *
     * @param value1 被加数
     * @param value2 加数
     * @return 两个参数的和
     */
    public static double add(double value1, double value2) {
        BigDecimal b1 = new BigDecimal(Double.valueOf(value1));
        BigDecimal b2 = new BigDecimal(Double.valueOf(value2));
        return b1.add(b2).doubleValue();
    }

    /**
     * 提供精确减法运算的sub方法，确认精确度
     *
     * @param value1 被减数
     * @param value2 减数
     * @param scale  小数点后保留几位
     * @return 两个参数的求差之后，按精度四舍五入的结果
     */
    public static double sub(double value1, double value2, int scale) {
        return round(sub(value1, value2), scale);
    }

    /**
     * 提供精确减法运算的sub方法
     *
     * @param value1 被减数
     * @param value2 减数
     * @return 两个参数的差
     */
    public static double sub(double value1, double value2) {
        BigDecimal b1 = new BigDecimal(Double.valueOf(value1));
        BigDecimal b2 = new BigDecimal(Double.valueOf(value2));
        return b1.subtract(b2).doubleValue();
    }

    /**
     * 提供精确乘法运算的mul方法，确认精确度
     *
     * @param value1 被乘数
     * @param value2 乘数
     * @param scale  小数点后保留几位
     * @return 两个参数的乘积之后，按精度四舍五入的结果
     */
    public static double mul(double value1, double value2, int scale) {
        return round(mul(value1, value2), scale);
    }

    /**
     * 提供精确乘法运算的mul方法
     *
     * @param value1 被乘数
     * @param value2 乘数
     * @return 两个参数的积
     */
    public static double mul(double value1, double value2) {
        BigDecimal b1 = new BigDecimal(Double.valueOf(value1));
        BigDecimal b2 = new BigDecimal(Double.valueOf(value2));
        return b1.multiply(b2).doubleValue();
    }
}
