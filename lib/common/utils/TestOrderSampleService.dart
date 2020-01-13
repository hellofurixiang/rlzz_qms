import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/UserPermissionsConfig.dart';
import 'package:qms/common/local/GlobalInfo.dart';
import 'package:qms/common/modal/AttachmentVo.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/modal/TestOrderDetailTestQuota.dart';
import 'package:qms/common/modal/TestOrderSampleDetail.dart';
import 'package:qms/common/net/QmsSampleService.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

class TestOrderSampleService {
  ///操作完成跳转页面
  static void _operCompleteJumpPage(
      BuildContext context, String docCat, String id) {
    ///跳转
    String urlName = '';

    switch (docCat) {
      case Config.test_order_ipqc:
        if (null != id) {
          urlName = Config.ipqcTestOrderListPage;
        } else {
          urlName = Config.ipqcWaitTaskListPage;
        }
        break;
      case Config.test_order_pqc:
        if (null != id) {
          urlName = Config.pqcTestOrderListPage;
        } else {
          urlName = Config.pqcWaitTaskListPage;
        }
        break;
      case Config.test_order_complete_sample:
        if (null != id) {
          urlName = Config.completeTestOrderSampleListPage;
        } else {
          urlName = Config.completeWaitTaskListPage;
        }
        break;
      case Config.test_order_arrival_sample:
        if (null != id) {
          urlName = Config.arrivalTestOrderSampleListPage;
        } else {
          urlName = Config.arrivalWaitTaskListPage;
        }
        break;
      default:
        break;
    }

    NavigatorUtil.pushReplacementNamed(context, urlName);
  }

  ///编辑
  /// context 上下文
  /// widgetDocCat 单据类型
  /// widgetTestCat 检验类型
  /// setInfo 设置信息方法
  /// isAdd 新增状态
  /// testOrderInfo 检验单对象
  static void checkSavePermissions(
      BuildContext context,
      String widgetDocCat,
      String widgetTestCat,
      Function setInfo,
      bool isAdd,
      TestOrder testOrderInfo) {
    ///权限
    String permissions = '';

    ///权限描述
    String permissionsText = '';

    switch (testOrderInfo.docCat) {
      case Config.test_order_arrival_sample:
        permissions = UserPermissionsConfig.arrivalSample_edit;
        permissionsText = StringZh.arrivalTestOrderSampleDetail_edit;
        break;
      case Config.test_order_complete_sample:
        permissions = UserPermissionsConfig.completeSample_edit;
        permissionsText = StringZh.arrivalTestOrderSampleDetail_edit;
        break;
      case Config.test_order_ipqc:
        permissions = UserPermissionsConfig.ipqc_edit;
        permissionsText = StringZh.ipqcTestOrderDetail_edit;
        break;
      case Config.test_order_pqc:
        permissions = UserPermissionsConfig.pqc_edit;
        permissionsText = StringZh.pqcTestOrderDetail_edit;
        break;
      default:
        break;
    }

    if (!CommonUtil.checkUserPermissions(permissions, permissionsText)) {
      //Navigator.pop(context);
      return;
    }
    checkSubmitInfo(
        context, widgetDocCat, widgetTestCat, setInfo, isAdd, testOrderInfo);
  }
  /// context 上下文
  /// widgetDocCat 单据类型
  /// widgetTestCat 检验类型
  /// setInfo 设置信息方法
  /// isAdd 新增状态
  /// testOrderInfo 检验单对象
  static void checkSubmitInfo(
      BuildContext context,
      String widgetDocCat,
      String widgetTestCat,
      Function setInfo,
      bool isAdd,
      TestOrder testOrderInfo) {
    ///判断样本是否都录入
    int num = -1;
    for (int i = 0; i < testOrderInfo.testOrderSampleDetail.length; i++) {
      TestOrderSampleDetail v = testOrderInfo.testOrderSampleDetail[i];

      if (!v.edited) {
        num = i;
      }
    }

    if (num != -1) {
      WidgetUtil.showConfirmDialog(
          context, StringZh.checkTestOrderSampleInfoTip, () {
        submitFun(context, widgetDocCat, widgetTestCat, setInfo, isAdd,
            testOrderInfo);
      }, confirmText: StringZh.yes, cancelText: StringZh.no);
    } else {
      submitFun(
          context, widgetDocCat, widgetTestCat, setInfo, isAdd, testOrderInfo);
    }
  }

  ///提交操作
  static void submitFun(
      BuildContext context,
      String widgetDocCat,
      String widgetTestCat,
      Function setInfo,
      bool isAdd,
      TestOrder testOrderInfo) async {
    setInfo();

    if (isAdd) {
      testOrderInfo.docCat = widgetDocCat;
      testOrderInfo.testCat = widgetTestCat;
    }

    ///表头附件
    if (null != testOrderInfo.badEnclosureList &&
        testOrderInfo.badEnclosureList.length > 0) {
      List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
      testOrderInfo.badEnclosureList.forEach((v) {
        if (CommonUtil.isNotEmpty(v.id)) {
          AttachmentVo attachmentVo = AttachmentVo.empty()
            ..id = v.id
            ..name = v.name
            ..size = v.size;
          badEnclosureList.add(attachmentVo);
        }
      });
      testOrderInfo.enclosure = json.encode(badEnclosureList);
    } else {
      testOrderInfo.enclosure = '';
    }

    ///表体指标不良图片附件
    testOrderInfo.testOrderSampleDetail.forEach((f) {
      if (f.edited) {
        List quotaInfos = [];

        List<TestOrderDetailTestQuota> testOrderDetailTestQuotas =
            f.testOrderDetailTestQuota;

        testOrderDetailTestQuotas.forEach((q) {
          if (CommonUtil.isNotEmpty(q.enclosure)) {
            q.enclosure = q.enclosure.replaceAll("'", "\"");
          }

          if (null != q.badEnclosureList && q.badEnclosureList.length > 0) {
            List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
            q.badEnclosureList.forEach((v) {
              if (CommonUtil.isNotEmpty(v.id)) {
                AttachmentVo attachmentVo = AttachmentVo.empty()
                  ..id = v.id
                  ..name = v.name
                  ..size = v.size;
                badEnclosureList.add(attachmentVo);
              }
            });
            q.badPictures = json.encode(badEnclosureList);
          } else {
            q.badPictures = '';
          }

          /*quotaInfos.add({
            'testTemplateDetailId': q.testTemplateDetailId,
            'testVal': q.testVal,
            'id': q.id,
            'badReasonCode': q.badReasonCode,
            'badReasonName': q.badReasonName,
            'badReasonInfo': q.badReasonInfo,
            'badPictures': q.badPictures,
            'producer': q.producer,
            'state': q.state,
          });*/
        });
        //f.oper = json.encode(quotaInfos);
      }
    });

    //print(testOrderInfo.toJson());

    WidgetUtil.showLoadingDialog(context, StringZh.submiting);
    QmsSampleService.submitTestOrder(context, testOrderInfo, (data) {
      Fluttertoast.showToast(msg: data, timeInSecForIos: 3);

      ///消除加载控件
      Navigator.pop(context);

      ///回退
      Navigator.pop(context);

      _operCompleteJumpPage(context, testOrderInfo.docCat, testOrderInfo.id);
    }, (err) {
      Navigator.pop(context);
    });
  }

  ///审核
  static void checkAuditPermissions(
      BuildContext context, TestOrder testOrderInfo) {
    ///权限
    String permissions = '';

    ///权限描述
    String permissionsText = '';

    switch (testOrderInfo.docCat) {
      case Config.test_order_arrival_sample:
        permissions = UserPermissionsConfig.arrivalSample_audit;
        permissionsText = StringZh.arrivalTestOrderSampleDetail_audit;
        break;
      case Config.test_order_complete_sample:
        permissions = UserPermissionsConfig.completeSample_audit;
        permissionsText = StringZh.arrivalTestOrderSampleDetail_audit;
        break;
      case Config.test_order_ipqc:
        permissions = UserPermissionsConfig.ipqc_audit;
        permissionsText = StringZh.ipqcTestOrderDetail_audit;
        break;
      case Config.test_order_pqc:
        permissions = UserPermissionsConfig.pqc_audit;
        permissionsText = StringZh.pqcTestOrderDetail_audit;
        break;
      default:
        break;
    }

    if (!CommonUtil.checkUserPermissions(permissions, permissionsText)) {
      //Navigator.pop(context);
      return;
    }
    WidgetUtil.showLoadingDialog(context, StringZh.auditing);
    QmsService.auditTestOrder(context, testOrderInfo.id, testOrderInfo.docCat,
        testOrderInfo.version, _operSuccessCallBack, () {});
  }

  ///弃审
  static void checkUnauditPermissions(
      BuildContext context, TestOrder testOrderInfo) {
    ///权限
    String permissions = '';

    ///权限描述
    String permissionsText = '';

    switch (testOrderInfo.docCat) {
      case Config.test_order_arrival_sample:
        permissions = UserPermissionsConfig.arrivalSample_unaudit;
        permissionsText = StringZh.arrivalTestOrderSampleDetail_unaudit;
        break;
      case Config.test_order_complete_sample:
        permissions = UserPermissionsConfig.completeSample_unaudit;
        permissionsText = StringZh.arrivalTestOrderSampleDetail_unaudit;
        break;
      case Config.test_order_ipqc:
        permissions = UserPermissionsConfig.ipqc_unaudit;
        permissionsText = StringZh.ipqcTestOrderDetail_unaudit;
        break;
      case Config.test_order_pqc:
        permissions = UserPermissionsConfig.pqc_unaudit;
        permissionsText = StringZh.pqcTestOrderDetail_unaudit;
        break;
      default:
        break;
    }

    if (!CommonUtil.checkUserPermissions(permissions, permissionsText)) {
      //Navigator.pop(context);
      return;
    }
    WidgetUtil.showLoadingDialog(context, StringZh.unAuditing);
    QmsService.unAuditTestOrder(context, testOrderInfo.id, testOrderInfo.docCat,
        testOrderInfo.version, _operSuccessCallBack, () {});
  }

  ///删除
  static void checkDelPermissions(
      BuildContext context, TestOrder testOrderInfo) {
    ///权限
    String permissions = '';

    ///权限描述
    String permissionsText = '';

    switch (testOrderInfo.docCat) {
      case Config.test_order_arrival_sample:
        permissions = UserPermissionsConfig.arrivalSample_del;
        permissionsText = StringZh.arrivalTestOrderSampleDetail_del;
        break;
      case Config.test_order_complete_sample:
        permissions = UserPermissionsConfig.completeSample_del;
        permissionsText = StringZh.arrivalTestOrderSampleDetail_del;
        break;
      case Config.test_order_ipqc:
        permissions = UserPermissionsConfig.ipqc_del;
        permissionsText = StringZh.ipqcTestOrderDetail_del;
        break;
      case Config.test_order_pqc:
        permissions = UserPermissionsConfig.pqc_del;
        permissionsText = StringZh.pqcTestOrderDetail_del;
        break;
      default:
        break;
    }

    if(!GlobalInfo.instance.isDebug()) {
      if (!CommonUtil.checkUserPermissions(permissions, permissionsText)) {
        Navigator.pop(context);
        return;
      }
    }

    WidgetUtil.showLoadingDialog(context, StringZh.deling);
    QmsService.delTestOrder(context, testOrderInfo.id, testOrderInfo.docCat,
        testOrderInfo.version, _operSuccessCallBack, (err) {
          Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
          Navigator.pop(context);
        });
  }

  ///审核、弃审、删除回调函数
  static void _operSuccessCallBack(
      BuildContext context, TestOrder testOrderInfo) {
    Navigator.pop(context);
    _operCompleteJumpPage(context, testOrderInfo.docCat, testOrderInfo.id);
    Fluttertoast.showToast(msg: '操作成功', timeInSecForIos: 3);
  }
}
