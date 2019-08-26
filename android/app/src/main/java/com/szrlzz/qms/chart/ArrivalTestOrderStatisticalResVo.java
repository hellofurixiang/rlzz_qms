package com.szrlzz.qms.chart;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 来料检验统计
 *
 * @author 付日祥
 * @date 2017/12/7
 */
public class ArrivalTestOrderStatisticalResVo implements Serializable {
    public ArrivalTestOrderStatisticalResVo(String supplierCode, String supplierName){
        this.supplierCode = supplierCode;
        this.supplierName = supplierName;
        this.batch_qty = new BigDecimal(1.000000);
        this.batch_qualifiedQty = new BigDecimal(1.000000);
        this.batch_concessionReceivedQuantity = new BigDecimal(1.000000);
        this.batch_unQualifiedQty = new BigDecimal(1.000000);
        this.batch_spQty = new BigDecimal(1.000000);
        this.batch_reworkQty = new BigDecimal(1.000000);
        this.batch_scrapQty = new BigDecimal(1.000000);
        this.batch_qualificationRate = new BigDecimal(100.000000);
        this.batch_unQualificationRate = new BigDecimal(0.000000);
        this.qty = new BigDecimal(15.000000);
        this.qualifiedQty = new BigDecimal(15.000000);
        this.concessionReceivedQuantity = new BigDecimal(0.000000);
        this.unQualifiedQty = new BigDecimal(0.000000);
        this.spQty = new BigDecimal(0.000000);
        this.reworkQty = new BigDecimal(0.000000);
        this.scrapQty = new BigDecimal(0.000000);
        this.qualificationRate = new BigDecimal(100.000000);
        this.unQualificationRate = new BigDecimal(0.000000);
    }
    /**
     * 供应商编码
     */
    private String supplierCode;
    /**
     * 供应商名称
     */
    private String supplierName;
    /**
     * 分组项
     */
    private String itemName;
    /***************批量*****************/
    /**
     * 报检数量
     */
    private BigDecimal batch_qty;
    /**
     * 合格数量
     */
    private BigDecimal batch_qualifiedQty;
    /**
     * 让步接收量
     */
    private BigDecimal batch_concessionReceivedQuantity;
    /**
     * 不良数量
     */
    private BigDecimal batch_unQualifiedQty;
    /**
     * 特采数量
     */
    private BigDecimal batch_spQty;
    /**
     * 返工数量
     */
    private BigDecimal batch_reworkQty;
    /**
     * 拒收/报废数量
     */
    private BigDecimal batch_scrapQty;
    /**
     * 一次合格率
     */
    private BigDecimal batch_onceQualificationRate;
    /**
     * 合格率
     */
    private BigDecimal batch_qualificationRate;
    /**
     * 不良率
     */
    private BigDecimal batch_unQualificationRate;

    /***************数量*****************/
    /**
     * 报检数量
     */
    private BigDecimal qty;
    /**
     * 合格数量
     */
    private BigDecimal qualifiedQty;
    /**
     * 让步接收量
     */
    private BigDecimal concessionReceivedQuantity;
    /**
     * 不良数量
     */
    private BigDecimal unQualifiedQty;
    /**
     * 特采数量
     */
    private BigDecimal spQty;
    /**
     * 返工数量
     */
    private BigDecimal reworkQty;
    /**
     * 拒收/报废数量
     */
    private BigDecimal scrapQty;
    /**
     * 一次合格率
     */
    private BigDecimal onceQualificationRate;
    /**
     * 合格率
     */
    private BigDecimal qualificationRate;
    /**
     * 不良率
     */
    private BigDecimal unQualificationRate;

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public BigDecimal getBatch_qty() {
        return batch_qty;
    }

    public void setBatch_qty(BigDecimal batch_qty) {
        this.batch_qty = batch_qty;
    }

    public BigDecimal getBatch_qualifiedQty() {
        return batch_qualifiedQty;
    }

    public void setBatch_qualifiedQty(BigDecimal batch_qualifiedQty) {
        this.batch_qualifiedQty = batch_qualifiedQty;
    }

    public BigDecimal getBatch_concessionReceivedQuantity() {
        return batch_concessionReceivedQuantity;
    }

    public void setBatch_concessionReceivedQuantity(BigDecimal batch_concessionReceivedQuantity) {
        this.batch_concessionReceivedQuantity = batch_concessionReceivedQuantity;
    }

    public BigDecimal getBatch_unQualifiedQty() {
        return batch_unQualifiedQty;
    }

    public void setBatch_unQualifiedQty(BigDecimal batch_unQualifiedQty) {
        this.batch_unQualifiedQty = batch_unQualifiedQty;
    }

    public BigDecimal getBatch_spQty() {
        return batch_spQty;
    }

    public void setBatch_spQty(BigDecimal batch_spQty) {
        this.batch_spQty = batch_spQty;
    }

    public BigDecimal getBatch_reworkQty() {
        return batch_reworkQty;
    }

    public void setBatch_reworkQty(BigDecimal batch_reworkQty) {
        this.batch_reworkQty = batch_reworkQty;
    }

    public BigDecimal getBatch_scrapQty() {
        return batch_scrapQty;
    }

    public void setBatch_scrapQty(BigDecimal batch_scrapQty) {
        this.batch_scrapQty = batch_scrapQty;
    }

    public BigDecimal getBatch_qualificationRate() {
        return batch_qualificationRate;
    }

    public void setBatch_qualificationRate(BigDecimal batch_qualificationRate) {
        this.batch_qualificationRate = batch_qualificationRate;
    }

    public BigDecimal getBatch_onceQualificationRate() {
        return batch_onceQualificationRate;
    }

    public void getBatch_onceQualificationRate(BigDecimal batch_onceQualificationRate) {
        this.batch_onceQualificationRate = batch_onceQualificationRate;
    }

    public BigDecimal getBatch_unQualificationRate() {
        return batch_unQualificationRate;
    }

    public void setBatch_unQualificationRate(BigDecimal batch_unQualificationRate) {
        this.batch_unQualificationRate = batch_unQualificationRate;
    }

    public BigDecimal getQty() {
        return qty;
    }

    public void setQty(BigDecimal qty) {
        this.qty = qty;
    }

    public BigDecimal getQualifiedQty() {
        return qualifiedQty;
    }

    public void setQualifiedQty(BigDecimal qualifiedQty) {
        this.qualifiedQty = qualifiedQty;
    }

    public BigDecimal getConcessionReceivedQuantity() {
        return concessionReceivedQuantity;
    }

    public void setConcessionReceivedQuantity(BigDecimal concessionReceivedQuantity) {
        this.concessionReceivedQuantity = concessionReceivedQuantity;
    }

    public BigDecimal getUnQualifiedQty() {
        return unQualifiedQty;
    }

    public void setUnQualifiedQty(BigDecimal unQualifiedQty) {
        this.unQualifiedQty = unQualifiedQty;
    }

    public BigDecimal getSpQty() {
        return spQty;
    }

    public void setSpQty(BigDecimal spQty) {
        this.spQty = spQty;
    }

    public BigDecimal getReworkQty() {
        return reworkQty;
    }

    public void setReworkQty(BigDecimal reworkQty) {
        this.reworkQty = reworkQty;
    }

    public BigDecimal getScrapQty() {
        return scrapQty;
    }

    public void setScrapQty(BigDecimal scrapQty) {
        this.scrapQty = scrapQty;
    }

    public BigDecimal getOnceQualificationRate() {
        return onceQualificationRate;
    }

    public void setOnceQualificationRate(BigDecimal onceQualificationRate) {
        this.onceQualificationRate = onceQualificationRate;
    }

    public BigDecimal getQualificationRate() {
        return qualificationRate;
    }

    public void setQualificationRate(BigDecimal qualificationRate) {
        this.qualificationRate = qualificationRate;
    }

    public BigDecimal getUnQualificationRate() {
        return unQualificationRate;
    }

    public void setUnQualificationRate(BigDecimal unQualificationRate) {
        this.unQualificationRate = unQualificationRate;
    }

    /*private BigDecimal BigDecimal bigDecimal) {
        return (null == bigDecimal) ? new BigDecimal(0) : bigDecimal;
    }*/

    public String getSupplierCode() {
        return supplierCode;
    }

    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}
