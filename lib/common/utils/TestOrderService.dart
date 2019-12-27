import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/UserPermissionsConfig.dart';
import 'package:qms/common/modal/AttachmentVo.dart';
import 'package:qms/common/modal/TestOrder.dart';
import 'package:qms/common/modal/TestOrderDetail.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';

class TestOrderService {
  ///操作完成跳转页面
  static void _operCompleteJumpPage(
      BuildContext context, String docCat, String id) {
    ///跳转
    String urlName = '';

    switch (docCat) {
      case Config.test_order_complete:
        if (null != id) {
          urlName = Config.completeTestOrderListPage;
        } else {
          urlName = Config.completeWaitTaskListPage;
        }
        break;
      case Config.test_order_arrival:
        if (null != id) {
          urlName = Config.arrivalTestOrderListPage;
        } else {
          urlName = Config.arrivalWaitTaskListPage;
        }
        break;
      case Config.test_order_iqc:
        if (null != id) {
          urlName = Config.iqcTestOrderListPage;
        } else {
          urlName = Config.iqcWaitTaskListPage;
        }
        break;
      case Config.test_order_fqc:
        if (null != id) {
          urlName = Config.fqcTestOrderListPage;
        } else {
          urlName = Config.fqcWaitTaskListPage;
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

    switch (widgetDocCat) {
      case Config.test_order_arrival:
        permissions = UserPermissionsConfig.arrival_edit;
        permissionsText = StringZh.arrivalTestOrderDetail_edit;
        break;
      case Config.test_order_complete:
        permissions = UserPermissionsConfig.complete_edit;
        permissionsText = StringZh.arrivalTestOrderDetail_edit;
        break;
      case Config.test_order_iqc:
        permissions = UserPermissionsConfig.iqc_edit;
        permissionsText = StringZh.iqcTestOrderDetail_edit;
        break;
      case Config.test_order_fqc:
        permissions = UserPermissionsConfig.fqc_edit;
        permissionsText = StringZh.fqcTestOrderDetail_edit;
        break;
      default:
        break;
    }

    if (!CommonUtil.checkUserPermissions(permissions, permissionsText)) {
      //Navigator.pop(context);
      return;
    }

    ///IQC、FQC特殊处理
    if (testOrderInfo.docCat == Config.test_order_iqc ||
        testOrderInfo.docCat == Config.test_order_fqc) {
      if (testOrderInfo.testResult != Config.receive &&
          testOrderInfo.testResult != Config.concessionsToReceive) {
        submitFun(context, widgetDocCat, widgetTestCat, setInfo, isAdd,
            testOrderInfo);
      }

      ///判断样本是否都录入
      var msg = "";
      for (int i = 0; i < testOrderInfo.testOrderDetail.length; i++) {
        TestOrderDetail v = testOrderInfo.testOrderDetail[i];

        if (v.quotaCat != Config.quotaTypeEntryNumber) {
          continue;
        }
        var testQtyInfos = v.testQtyInfo.split('|');

        ///指标数必须等于检验数量
        if (testQtyInfos.length != v.quantity) {
          msg = CommonUtil.getText(StringZh.tip_testItem_entry_incomplete,
              [(i + 1).toString(), v.testItemName, v.testQuotaName]);
          break;
        }
      }
      if (msg != '') {
        Fluttertoast.showToast(msg: msg, timeInSecForIos: 3);
      } else {
        submitFun(context, widgetDocCat, widgetTestCat, setInfo, isAdd,
            testOrderInfo);
      }
    } else {
      submitFun(
          context, widgetDocCat, widgetTestCat, setInfo, isAdd, testOrderInfo);
    }
  }

  ///提交操作
  /// context 上下文
  /// widgetDocCat 单据类型
  /// widgetTestCat 检验类型
  /// setInfo 设置信息方法
  /// isAdd 新增状态
  /// testOrderInfo 检验单对象
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
      testOrderInfo.enclosureList = badEnclosureList;
    } else {
      if (CommonUtil.isNotEmpty(testOrderInfo.enclosure)) {
        List arr = json.decode(testOrderInfo.enclosure.replaceAll('\'', '"'));

        List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
        arr.forEach((v) {
          badEnclosureList.add(AttachmentVo.fromJson(v));
        });
        testOrderInfo.enclosureList = badEnclosureList;
      }
    }

    ///表体附件
    testOrderInfo.testOrderDetail.forEach((f) {
      List list = f.testQtyInfoDetailList;

      f.operTestQtyInfo = f.edited;

      if (list != null && list.isNotEmpty && f.edited) {
        f.testState = true;
        f.testQtyInfoDetail =
            json.encode(list); //.replaceAll('detailList', 'list');
      } else {
        f.testState = false;
        f.testQtyInfoDetail = 'noChange';
      }

      if (null != f.badEnclosureList && f.badEnclosureList.length > 0) {
        List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
        f.badEnclosureList.forEach((v) {
          if (CommonUtil.isNotEmpty(v.id)) {
            AttachmentVo attachmentVo = AttachmentVo.empty()
              ..id = v.id
              ..name = v.name
              ..size = v.size;
            badEnclosureList.add(attachmentVo);
          }
        });
        f.enclosureList = badEnclosureList;
      } else {
        if (CommonUtil.isNotEmpty(f.enclosure)) {
          List arr = json.decode(f.enclosure.replaceAll('\'', '"'));

          List<AttachmentVo> badEnclosureList = <AttachmentVo>[];
          arr.forEach((v) {
            badEnclosureList.add(AttachmentVo.fromJson(v));
          });
          f.enclosureList = badEnclosureList;
        }
      }
    });

    WidgetUtil.showLoadingDialog(context, StringZh.submiting);
    QmsService.submitTestOrder(context, testOrderInfo, (data) {
      Fluttertoast.showToast(msg: data, timeInSecForIos: 3);

      ///消除加载控件
      Navigator.pop(context);

      ///回退
      Navigator.pop(context);

      _operCompleteJumpPage(context, widgetDocCat, testOrderInfo.id);
    }, (err) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
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
      case Config.test_order_arrival:
        permissions = UserPermissionsConfig.arrival_audit;
        permissionsText = StringZh.arrivalTestOrderDetail_audit;
        break;
      case Config.test_order_complete:
        permissions = UserPermissionsConfig.complete_audit;
        permissionsText = StringZh.arrivalTestOrderDetail_audit;
        break;
      case Config.test_order_iqc:
        permissions = UserPermissionsConfig.iqc_audit;
        permissionsText = StringZh.iqcTestOrderDetail_audit;
        break;
      case Config.test_order_fqc:
        permissions = UserPermissionsConfig.fqc_audit;
        permissionsText = StringZh.fqcTestOrderDetail_audit;
        break;
      default:
        break;
    }

    if (!CommonUtil.checkUserPermissions(permissions, permissionsText)) {
      //Navigator.pop(context);
      return;
    }

    ///判断样本是否都录入
    String msg = '';
    for (int i = 0; i < testOrderInfo.testOrderDetail.length; i++) {
      TestOrderDetail v = testOrderInfo.testOrderDetail[i];

      if (CommonUtil.isEmpty(v.testQtyInfo)) {
        msg = CommonUtil.getText(StringZh.tip_testItem_entry_empty,
            [(i + 1).toString(), v.testItemName, v.testQuotaName]);
        break;
      }
    }
    if (msg != '') {
      WidgetUtil.showConfirmDialog(context, msg, () {
        WidgetUtil.showLoadingDialog(context, StringZh.auditing);
        QmsService.auditTestOrder(
            context,
            testOrderInfo.id,
            testOrderInfo.docCat,
            testOrderInfo.version,
            _operSuccessCallBack,
            () {});
      }, confirmText: StringZh.yes, cancelText: StringZh.no);
    } else {
      WidgetUtil.showLoadingDialog(context, StringZh.auditing);
      QmsService.auditTestOrder(context, testOrderInfo.id, testOrderInfo.docCat,
          testOrderInfo.version, _operSuccessCallBack, () {});
    }
  }

  ///弃审
  static void checkUnauditPermissions(
      BuildContext context, TestOrder testOrderInfo) {
    ///权限
    String permissions = '';

    ///权限描述
    String permissionsText = '';

    switch (testOrderInfo.docCat) {
      case Config.test_order_arrival:
        permissions = UserPermissionsConfig.arrival_unaudit;
        permissionsText = StringZh.arrivalTestOrderDetail_unaudit;
        break;
      case Config.test_order_complete:
        permissions = UserPermissionsConfig.complete_unaudit;
        permissionsText = StringZh.arrivalTestOrderDetail_unaudit;
        break;
      case Config.test_order_iqc:
        permissions = UserPermissionsConfig.iqc_unaudit;
        permissionsText = StringZh.iqcTestOrderDetail_unaudit;
        break;
      case Config.test_order_fqc:
        permissions = UserPermissionsConfig.fqc_unaudit;
        permissionsText = StringZh.fqcTestOrderDetail_unaudit;
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
      case Config.test_order_arrival:
        permissions = UserPermissionsConfig.arrival_del;
        permissionsText = StringZh.arrivalTestOrderDetail_del;
        break;
      case Config.test_order_complete:
        permissions = UserPermissionsConfig.complete_del;
        permissionsText = StringZh.arrivalTestOrderDetail_del;
        break;
      case Config.test_order_iqc:
        permissions = UserPermissionsConfig.iqc_del;
        permissionsText = StringZh.iqcTestOrderDetail_del;
        break;
      case Config.test_order_fqc:
        permissions = UserPermissionsConfig.fqc_del;
        permissionsText = StringZh.fqcTestOrderDetail_del;
        break;
      default:
        break;
    }

    if (!CommonUtil.checkUserPermissions(permissions, permissionsText)) {
      //Navigator.pop(context);
      return;
    }

    WidgetUtil.showLoadingDialog(context, StringZh.deling);
    QmsService.delTestOrder(context, testOrderInfo.id, testOrderInfo.docCat,
        testOrderInfo.version, _operSuccessCallBack, () {});
  }

  ///审核、弃审、删除回调函数
  static void _operSuccessCallBack(
      BuildContext context, TestOrder testOrderInfo) {
    Navigator.pop(context);
    _operCompleteJumpPage(context, testOrderInfo.docCat, testOrderInfo.id);
    Fluttertoast.showToast(msg: '操作成功', timeInSecForIos: 3);
  }

  static void _operErrorCallBack(BuildContext context, err) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: err, timeInSecForIos: 3);
  }
}
