import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/net/NetUtil.dart';

///质检请求服务类
class QmsSampleService {
  ///获取检验单（按样本检验）
  ///id 单据ID
  ///docNo 单据号
  static void getTestOrderSampleById(BuildContext context, int id, String docNo,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrderSample/getTestOrderById';

    NetUtil.get(url, context,
        params: {'id': id, 'docNo': docNo},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取检验单（按样本检验）
  ///srcDocDetailId 来源单据表体ID
  ///testTemplateId 检验模板ID
  ///qty 报检数量
  static void getTestOrderSample(
      BuildContext context,
      String srcDocDetailId,
      String testTemplateId,
      String qty,
      String testCat,
      String docCat,
      Function successCallBack,
      Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrderSample/getTestOrderSample';

    NetUtil.get(url, context,
        params: {
          'srcDocDetailId': srcDocDetailId,
          'testTemplateId': testTemplateId,
          'qty': qty,
          'testCat': testCat,
          'docCat': docCat,
        },
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///检验单保存、修改
  static void submitTestOrder(BuildContext context, TestOrder testOrder,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrderSample/save';

    NetUtil.post(url, context,
        params: testOrder.toJson(),
        responseType: ResponseType.PLAIN,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取检验单表体指标列表
  ///id 单据ID
  static void getTestOrderDetailTestQuotaById(
      BuildContext context,
      String oper,
      String orderId,
      String orderDetailId,
      String testTemplateId,
      Function successCallBack,
      Function errorCallBack) {
    String url =
        Config.qmsApiUrl + '/testOrderSample/getTestOrderDetailTestQuotaById';

    NetUtil.get(url, context,
        params: {
          'oper': oper,
          'orderId': orderId,
          'orderDetailId': orderDetailId,
          'testTemplateId': testTemplateId
        },
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
