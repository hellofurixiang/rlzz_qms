import 'package:qms/common/config/Config.dart';
import 'package:qms/common/config/UserPermissionsConfig.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/page/ArrivalTestOrderSampleListPage.dart';
import 'package:qms/page/ArrivalWaitTaskListPage.dart';
import 'package:qms/page/ArrivalTestOrderListPage.dart';
import 'package:qms/page/CompleteTestOrderSampleListPage.dart';
import 'package:qms/page/CompleteWaitTaskListPage.dart';
import 'package:qms/page/CompleteTestOrderListPage.dart';
import 'package:qms/page/FqcTestOrderListPage.dart';
import 'package:qms/page/FqcWaitTaskListPage.dart';
import 'package:qms/page/IpqcTestOrderListPage.dart';
import 'package:qms/page/IpqcWaitTaskListPage.dart';
import 'package:qms/page/IqcTestOrderListPage.dart';
import 'package:qms/page/IqcWaitTaskListPage.dart';
import 'package:qms/page/PqcTestOrderListPage.dart';
import 'package:qms/page/PqcWaitTaskListPage.dart';
import 'package:qms/page/report/ArrivalMonthReport.dart';
import 'package:qms/page/report/ArrivalSupplierReport.dart';
import 'package:qms/page/report/ArrivalWeekReport.dart';

class MenuConfig {
  List qmsMenuList = [
    {
      'tabName': StringZh.arrivalTest,
      'menus': [
        {
          'tabName': StringZh.arrivalWaitTask_title,
          'code': 'arrivalWaitTotal',
          'info': {'url': new ArrivalWaitTaskListPage(), 'img': 'task.png'},
          'permissions': UserPermissionsConfig.arrivalWaitList_view
        },
        {
          'tabName': StringZh.testOrder,
          'code': 'arrivalTotal',
          'info': {
            'url': new ArrivalTestOrderListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions': UserPermissionsConfig.arrivalTestOrderList_view
        },
        {
          'tabName': StringZh.testOrder_sample,
          'code': 'arrivalSampleTotal',
          'info': {
            'url': new ArrivalTestOrderSampleListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions': UserPermissionsConfig.arrivalSampleList_view
        }
      ]
    },
    {
      'tabName': StringZh.completeTest,
      'menus': [
        {
          'tabName': StringZh.completeWaitTask_title,
          'code': 'completeWaitTotal',
          'info': {
            'url': new CompleteWaitTaskListPage(),
            'img': 'task_finished.png'
          },
          'permissions': UserPermissionsConfig.completeWaitList_view
        },
        {
          'tabName': StringZh.testOrder,
          'code': 'completeTotal',
          'info': {
            'url': new CompleteTestOrderListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions': UserPermissionsConfig.completeTestOrderList_view
        },
        {
          'tabName': StringZh.testOrder_sample,
          'code': 'completeSampleTotal',
          'info': {
            'url': new CompleteTestOrderSampleListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions': UserPermissionsConfig.completeSampleList_view
        }
      ]
    },
    {
      'tabName': StringZh.arrivalTest + '(IQC)',
      'menus': [
        {
          'tabName': StringZh.waitTask,
          'code': 'iqcWaitTotal',
          'info': {'url': new IqcWaitTaskListPage(), 'img': 'task.png'},
          'permissions': UserPermissionsConfig.iqcWaitList_view
        },
        {
          'tabName': StringZh.testOrder,
          'code': 'iqcTotal',
          'info': {'url': new IqcTestOrderListPage(), 'img': 'tasks_blue.png'},
          'permissions': UserPermissionsConfig.iqcTestOrderList_view
        },
        /*{
          'tabName': '不良品处理单',
          'info': {
            'url': new CompleteTestOrderListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions':'dld:iqcWaitDefectiveDocList:list'
        }*/
      ]
    },
    {
      'tabName': StringZh.production_self_inspection + '(PQC)',
      'menus': [
        {
          'tabName': StringZh.waitTask,
          'code': 'pqcWaitTotal',
          'info': {'url': new PqcWaitTaskListPage(), 'img': 'task.png'},
          'permissions': UserPermissionsConfig.pqcWaitList_view
        },
        {
          'tabName': StringZh.testOrder,
          'code': 'pqcTotal',
          'info': {'url': new PqcTestOrderListPage(), 'img': 'tasks_blue.png'},
          'permissions': UserPermissionsConfig.pqcTestOrderList_view
        },
      ]
    },
    {
      'tabName': StringZh.production_sampling + '(IPQC)',
      'menus': [
        {
          'tabName': StringZh.waitTask,
          'code': 'ipqcWaitTotal',
          'info': {'url': new IpqcWaitTaskListPage(), 'img': 'task.png'},
          'permissions': UserPermissionsConfig.ipqcWaitList_view
        },
        {
          'tabName': StringZh.testOrder,
          'code': 'ipqcTotal',
          'info': {'url': new IpqcTestOrderListPage(), 'img': 'tasks_blue.png'},
          'permissions': UserPermissionsConfig.ipqcTestOrderList_view
        },
        /*{
          'tabName': '不良品处理单',
          'info': {
            'url': new CompleteTestOrderListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions':'dld:ipqcWaitDefectiveDocList:list'
        }*/
      ]
    },
    {
      'tabName': StringZh.completeTest + '(FQC)',
      'menus': [
        {
          'tabName': StringZh.waitTask,
          'code': 'fqcWaitTotal',
          'info': {'url': new FqcWaitTaskListPage(), 'img': 'task.png'},
          'permissions': UserPermissionsConfig.fqcWaitList_view
        },
        {
          'tabName': StringZh.testOrder,
          'code': 'fqcTotal',
          'info': {'url': new FqcTestOrderListPage(), 'img': 'tasks_blue.png'},
          'permissions': UserPermissionsConfig.fqcTestOrderList_view
        },
        /*{
          'tabName': '不良品处理单',
          'info': {
            'url': new CompleteTestOrderListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions':'dld:fqcWaitDefectiveDocList:list'
        }*/
      ]
    },
    {
      'tabName': StringZh.report,
      'menus': [
        {
          'tabName': StringZh.arrivalTestOrderStatisticalForMonth,
          'code': 'salOutbound',
          'info': {'url': new ArrivalMonthReport(), 'img': 'report_blue.png'},
          'permissions':
              UserPermissionsConfig.arrivalTestOrderStatisticalForMonth
        },
        {
          'tabName': StringZh.arrivalTestOrderStatisticalForWeek,
          'code': 'materialOutbound',
          'info': {'url': new ArrivalWeekReport(), 'img': 'report_blue.png'},
          'permissions':
              UserPermissionsConfig.arrivalTestOrderStatisticalForWeek
        },
        {
          'tabName': StringZh.arrivalTestOrderStatisticalForSupplier,
          'code': 'otherOutbound',
          'info': {
            'url': new ArrivalSupplierReport(),
            'img': 'report_blue.png'
          },
          'permissions':
              UserPermissionsConfig.arrivalTestOrderStatisticalForSupplier
        }
      ]
    }
  ];
}

/*dld:quarantinetask-default-list:list
dld:testorder-fqc-list:list
dld:fqcWaitList:list
dld:fqcWaitDefectiveDocList:list
dld:quarantinetask-002-list:list
dld:testorder-ipqc-list:list
dld:ipqcWaitList:list
dld:ipqcWaitDefectiveDocList:list
dld:testorder-iqc-list:list
dld:iqcWaitList:list
dld:iqcWaitDefectiveDocList:list
dld:testorder-pqc-list:list
dld:pqcWaitList:list
dld:testorder-002-list:list
dld:testorder-002-sample-list:list
dld:testorder-default-list:list
dld:testorder-default-sample-list:list*/
