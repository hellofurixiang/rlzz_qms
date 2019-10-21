import 'package:qms/common/config/Config.dart';
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
      'tabName': '来料检验',
      'menus': [
        {
          'tabName': '来料待检任务',
          'code': 'arrivalWaitTotal',
          'info': {'url': new ArrivalWaitTaskListPage(), 'img': 'task.png'},
          'permissions': Config.arrivalWaitList_view
        },
        {
          'tabName': '检验单',
          'code': 'arrivalTotal',
          'info': {
            'url': new ArrivalTestOrderListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions': Config.arrivalTestOrderList_view
        },
        {
          'tabName': '检验单(按样本)',
          'code': 'arrivalSampleTotal',
          'info': {
            'url': new ArrivalTestOrderSampleListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions': Config.arrivalSampleList_view
        }
      ]
    },
    {
      'tabName': '完工检验',
      'menus': [
        {
          'tabName': '完工待检任务',
          'code': 'completeWaitTotal',
          'info': {
            'url': new CompleteWaitTaskListPage(),
            'img': 'task_finished.png'
          },
          'permissions': Config.defWaitList_view
        },
        {
          'tabName': '检验单',
          'code': 'completeTotal',
          'info': {
            'url': new CompleteTestOrderListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions': Config.defTestOrderList_view
        },
        {
          'tabName': '检验单(按样本)',
          'code': 'completeSampleTotal',
          'info': {
            'url': new CompleteTestOrderSampleListPage(),
            'img': 'tasks_blue.png'
          },
          'permissions': Config.defSampleList_view
        }
      ]
    },
    {
      'tabName': '来料检验(IQC)',
      'menus': [
        {
          'tabName': '待检任务',
          'code': 'iqcWaitTotal',
          'info': {'url': new IqcWaitTaskListPage(), 'img': 'task.png'},
          'permissions': Config.iqcWaitList_view
        },
        {
          'tabName': '检验单',
          'code': 'iqcTotal',
          'info': {'url': new IqcTestOrderListPage(), 'img': 'tasks_blue.png'},
          'permissions': Config.iqcTestOrderList_view
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
      'tabName': '生产自检(PQC)',
      'menus': [
        {
          'tabName': '待检任务',
          'code': 'pqcWaitTotal',
          'info': {'url': new PqcWaitTaskListPage(), 'img': 'task.png'},
          'permissions': Config.pqcWaitList_view
        },
        {
          'tabName': '检验单',
          'code': 'pqcTotal',
          'info': {'url': new PqcTestOrderListPage(), 'img': 'tasks_blue.png'},
          'permissions': Config.pqcTestOrderList_view
        },
      ]
    },
    {
      'tabName': '生产巡检(IPQC)',
      'menus': [
        {
          'tabName': '待检任务',
          'code': 'ipqcWaitTotal',
          'info': {'url': new IpqcWaitTaskListPage(), 'img': 'task.png'},
          'permissions': Config.ipqcWaitList_view
        },
        {
          'tabName': '检验单',
          'code': 'ipqcTotal',
          'info': {'url': new IpqcTestOrderListPage(), 'img': 'tasks_blue.png'},
          'permissions': Config.ipqcTestOrderList_view
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
      'tabName': '完工检验(FQC)',
      'menus': [
        {
          'tabName': '待检任务',
          'code': 'fqcWaitTotal',
          'info': {'url': new FqcWaitTaskListPage(), 'img': 'task.png'},
          'permissions': Config.fqcWaitList_view
        },
        {
          'tabName': '检验单',
          'code': 'fqcTotal',
          'info': {'url': new FqcTestOrderListPage(), 'img': 'tasks_blue.png'},
          'permissions': Config.fqcTestOrderList_view
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
      'tabName': '报表',
      'menus': [
        {
          'tabName': '来料:质量分析(按月)',
          'code': 'salOutbound',
          'info': {'url': new ArrivalMonthReport(), 'img': 'report_blue.png'},
          'permissions': Config.arrivalTestOrderStatisticalForMonth
        },
        {
          'tabName': '来料:质量分析(按周)',
          'code': 'materialOutbound',
          'info': {'url': new ArrivalWeekReport(), 'img': 'report_blue.png'},
          'permissions': Config.arrivalTestOrderStatisticalForWeek
        },
        {
          'tabName': '来料:质量分析(按供应商)',
          'code': 'otherOutbound',
          'info': {
            'url': new ArrivalSupplierReport(),
            'img': 'report_blue.png'
          },
          'permissions': Config.arrivalTestOrderStatisticalForSupplier
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
