import 'package:flutter/material.dart';
import 'package:qms/common/utils/CommonUtil.dart';

///页面跳转服务类
class NavigatorUtil {
  ///页面跳转
  static goToPage(BuildContext context, Widget url,
      {String permissions, String permissionsText,Function backCall}) async {
    if (CommonUtil.checkUserPermissions(
        permissions, permissionsText)) {
      Navigator.push(context, new MaterialPageRoute(builder: (context) => url))
          .then((Object obj) {
        if (null != backCall) backCall(obj);
      });
    }
  }

  static pushNamedAndRemoveUntil(BuildContext context, String urlName) async {
    Navigator.pushNamedAndRemoveUntil(
        context, urlName, (route) => route == null);
  }

  static pushReplacementNamed(BuildContext context, String urlName) async {
    Navigator.pushReplacementNamed(context, urlName);
  }

//List kkk=["dld:outbound-default-selection:list","dld:badreasoncategory-default-list:add","form:initialDeposit:default:edit","dld:cargospace-default-selection:list","dld:testtemplate-default-list:disable","form:cargoSpace:default:save","dld:transceiverSummary:list","form:testMethod:default:delete","form:badReasonCategory:default:save","form:csGoodsPackageSet:default:delete","kanban:jkView","form:checkInventory:default:delete","form:testTaskAllot:default:save","dld:barcode-archive-list:list","form:barcodeArchive:default:view","form:analyticRuleSet:default:ruleTest","dld:interfaceconfig-default-selection:list","form:testTemplate:default:delete","form:barcodeRuleSet:default:add","form:barcodeRuleAllot:default:edit","form:productionOrder:default:view","dld:testtaskallot-default-list:add","dld:barcodeTraceability:list","dld:completeOperatorList:list","dld:currentstock-default-list:list","form:customSamplingWay:default:save","dld:completeOnceQualifiedRate:export","dld:completeOperatorList:export","dld:barcode-create-list:li
}
