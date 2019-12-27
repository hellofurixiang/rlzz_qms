import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/net/NetUtil.dart';

///质检请求服务类
class QmsService {
  ///获取待检任务列表
  /// default完工检验、002来料检验
  static void getQuarantineTaskList(
      BuildContext context,
      Map<String, Object> params,
      Function successCallBack,
      Function errorCallBack) {
    String url = Config.qmsApiUrl + '/quarantineTask/list';

    NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  /// 获取检验单列表
  ///searchReqVo default完工检验、002来料检验
  static void getTestOrderList(BuildContext context, Map<String, Object> params,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/list';

    NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取检验单详情
  ///searchReqVo default完工检验、002来料检验
  static void getTestOrderById(BuildContext context, int id, String docNo,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/getTestOrderByInfo';

    NetUtil.post(url, context,
        params: {'id': id, 'docNo': docNo},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  /// 获取检验单详情
  ///testQuotaListReq default完工检验、002来料检验
  ///id 检验单Id
  static void getTestTaskDetail(
      BuildContext context,
      Map<String, Object> params,
      Function successCallBack,
      Function errorCallBack) {
    String url = Config.qmsApiUrl + '/quarantineTask/detail';

    NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  /// 获取检验模板
  ///testTemplateReqVo {@link TestTemplateReqVo}
  ///testCat 检验类型
  ///invCode 存货编码
  static void getTestTemplate(BuildContext context, Map<String, Object> params,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testTemplate/findTestTemplateByInv';

    NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///根据单据信息获取检验模板表体检验指标数据
  ///testCat 检验类型
  ///invCode 存货编码
  ///opCode 工序编码
  ///testTemplateId 检验模板id
  static void getTestQuotaListByOrderInfo(BuildContext context, String barcode,
      Function successCallBack, Function errorCallBack) {
    String url =
        Config.qmsApiUrl + '/testTemplateAllot/getTestQuotaListByOrderInfo';

    NetUtil.post(url, context,
        params: {'barcode': barcode},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///审核检验单
  ///id 检验单表头id
  static void auditTestOrder(BuildContext context, String id, String docCat,
      int version, Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/auditTestOrder';

    NetUtil.get(url, context,
        params: {'id': id, 'docCat': docCat, 'version': version},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///弃审检验单
  ///id 检验单表头id
  static void unAuditTestOrder(BuildContext context, String id, String docCat,
      int version, Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/unAuditTestOrder';

    NetUtil.get(url, context,
        params: {'id': id, 'docCat': docCat, 'version': version},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///删除检验单
  ///id 检验单表头id
  static void delTestOrder(BuildContext context, String id, String docCat,
      int version, Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/delTestOrder';

    NetUtil.get(url, context,
        params: {'id': id, 'docCat': docCat, 'version': version},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取生产订单详情
  static void getProductionOrderInfo(BuildContext context, String moDocNo,
      String detailId, Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/productionOrder/getProductionOrderInfo';

    NetUtil.post(url, context,
        params: {'id': detailId, 'docNo': moDocNo},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///人员参照，分页接口
  static void getUserlList(BuildContext context, String barcode,
      Function successCallBack, Function errorCallBack) {
    String url = Config.bossApiUrl + '/api/user/search';

    NetUtil.post(url, context,
        params: {'barcode': barcode},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///不良原因参照，分页接口
  static void getBadReasonRef(
      BuildContext context, Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + Config.badReasonRefUrl;

    NetUtil.post(url, context,
        params: {},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///参照，分页接口
  static void getRefList(
      BuildContext context,
      String url,
      Map<String, String> params,
      Function successCallBack,
      Function errorCallBack) {
    //String url = Config.qmsApiUrl + '/badReason/findBadReasonRef';findMeasuringToolRef

    url = Config.qmsApiUrl + url;
    NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取录入型(文本)检测值列表
  static void getInputTextListInfo(BuildContext context, String id,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/getInputInfoListInfo';

    NetUtil.get(url, context,
        params: {'id': id},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取录入型(数值)检测值列表
  static void getInputInfoListInfo(BuildContext context, String id,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/getInputInfoListInfo';

    NetUtil.get(url, context,
        params: {'id': id},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取枚举型检测值列表
  ///orderDetailId 检验单表体ID
  ///testQuotaId 检验项id
  static void getEnumInfoListInfo(BuildContext context, String orderDetailId,
      String testQuotaCode, Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/getEnumInfoListInfo';

    NetUtil.get(url, context,
        params: {'id': orderDetailId, 'testQuotaCode': testQuotaCode},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///根据检验指标ID查找枚举型列表
  static void getEnumListInfoByQuotaCode(
      BuildContext context, String quotaCode, Function successCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/getEnumListInfoByQuotaCode';

    NetUtil.get(url, context,
        params: {'quotaCode': quotaCode}, successCallBack: successCallBack);
  }

  ///获取统计信息
  static void getUnHandleMessage(
      BuildContext context, Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/quarantineTask/counts';

    NetUtil.post(url, context,
        params: {'operatorName': '', 'operatorId': ''},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取统计信息
  static void getTestOrderStatistical(
      BuildContext context, Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/quarantineTask/getTestOrderStatistical';

    NetUtil.post(url, context,
        params: {'operatorName': '', 'operatorId': ''},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///检验单保存、修改
  static void submitTestOrder(BuildContext context, TestOrder testOrder,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/save';

    NetUtil.post(url, context,
        params: testOrder.toJson(),
        responseType: ResponseType.PLAIN,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取按月统计报表
  ///testOrderRes 参数beginDate 起始时间、endDate 结束时间、supplierCode 供应商编码、invCatCode 物料分类编码、invCode 物料编码
  static void getArrivalTestOrderStatisticalForMonth(
      BuildContext context,
      Map<String, Object> params,
      Function successCallBack,
      Function errorCallBack) {
    String url =
        Config.qmsApiUrl + '/testOrder/getArrivalTestOrderStatisticalForMonth';

    NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取按周统计报表
  ///testOrderRes 参数beginDate 起始时间、endDate 结束时间、supplierCode 供应商编码、invCatCode 物料分类编码、invCode 物料编码
  static void getArrivalTestOrderStatisticalForWeek(
      BuildContext context,
      Map<String, Object> params,
      Function successCallBack,
      Function errorCallBack) {
    String url =
        Config.qmsApiUrl + '/testOrder/getArrivalTestOrderStatisticalForWeek';

    NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取按供应商统计报表
  ///testOrderRes 参数beginDate、supplierCode、invCatCode、invCode
  static void getArrivalTestOrderStatisticalForSupplier(
      BuildContext context,
      Map<String, Object> params,
      Function successCallBack,
      Function errorCallBack) {
    String url = Config.qmsApiUrl +
        '/testOrder/getArrivalTestOrderStatisticalForSupplier';

    NetUtil.post(url, context,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///根据单据ID获取不良信息列表
  ///id 检验单ID
  static void getTestOrderBadInfoList(
      BuildContext context, String id, Function successCallBack) {
    String url = Config.qmsApiUrl + '/testOrder/getBadInfoList';

    NetUtil.get(url, context,
        params: {'id': id}, successCallBack: successCallBack);
  }
}
