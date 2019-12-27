import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/PqcTestOrder.dart';
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
  ///orderId 单据ID
  ///orderDetailId 单据表体ID
  ///id 单据ID
  static void getTestOrderDetailTestQuotaById(
      BuildContext context,
      String orderId,
      String orderDetailId,
      Function successCallBack,
      Function errorCallBack) {
    String url =
        Config.qmsApiUrl + '/testOrderSample/getTestOrderDetailTestQuotaById';

    NetUtil.get(url, context,
        params: {
          'orderId': orderId,
          'orderDetailId': orderDetailId
        },
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///获取检验单表体指标列表
  ///testTemplateId 检验模板ID
  static void getTestOrderDetailTestQuotaByTestTemplateId(
      BuildContext context,
      String testTemplateId,
      Function successCallBack,
      Function errorCallBack) {
    String url =
        Config.qmsApiUrl + '/testOrderSample/getTestOrderDetailTestQuotaByTestTemplateId';

    NetUtil.get(url, context,
        params: {
          'testTemplateId': testTemplateId
        },
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  ///异步更新检验单及表体的检验指标信息
  static void asynUpdateTestOrderDetailAndQuotaInfo(BuildContext context, PqcTestOrder testOrder,
      Function successCallBack, Function errorCallBack) {
    String url = Config.qmsApiUrl + '/testOrderSample/asynUpdateTestOrderDetailAndQuotaInfo';

    NetUtil.post(url, context,
        params: testOrder.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
