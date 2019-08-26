import 'package:qms/page/ArrivalWaitTaskListPage.dart';
import 'package:qms/page/ArrivalTestOrderListPage.dart';
import 'package:qms/page/CompleteWaitTaskListPage.dart';
import 'package:qms/page/CompleteTestOrderListPage.dart';
import 'package:qms/page/IQCTestOrderListPage.dart';
import 'package:qms/page/report/ArrivalMonthReport.dart';
import 'package:qms/page/report/ArrivalSupplierReport.dart';
import 'package:qms/page/report/ArrivalWeekReport.dart';

class MenuConfig {
  var qmsMenuList = [
    {
      'tabName': '来料检验',
      'menus': [
        {
          'tabName': '来料待检任务',
          'code': 'waitOutbound',
          'info': {'url': new ArrivalWaitTaskListPage(), 'img': 'task.png'}
        },
        {
          'tabName': '检验单（来料）',
          'code': 'waitRedOutbound',
          'info': {
            'url': new ArrivalTestOrderListPage(),
            'img': 'tasks_blue.png'
          }
        },
        {
          'tabName': '检验单（按样本）',
          'info': {'url': new IQCTestOrderListPage(), 'img': 'tasks_blue.png'}
        }
      ]
    },
    {
      'tabName': '完工检验',
      'menus': [
        {
          'tabName': '完工待检任务',
          'info': {
            'url': new CompleteWaitTaskListPage(),
            'img': 'task_finished.png'
          }
        },
        {
          'tabName': '检验单（完工）',
          'info': {
            'url': new CompleteTestOrderListPage(),
            'img': 'tasks_blue.png'
          }
        }
      ]
    },
    /*{
      'tabName': '龙升',
      'menus': [
        {
          'tabName': 'IQC待检任务',
          'info': {'url': new IQCWaitTaskListPage(), 'img': 'task_finished.png'}
        },
        {
          'tabName': '检验单（IQC）',
          'info': {'url': new IQCTestOrderListPage(), 'img': 'tasks_blue.png'}
        }
      ]
    },*/
    {
      'tabName': '报表',
      'menus': [
        {
          'tabName': '来料:质量分析(按月)',
          'code': 'salOutbound',
          'info': {'url': new ArrivalMonthReport(), 'img': 'report_blue.png'}
        },
        {
          'tabName': '来料:质量分析(按周)',
          'code': 'materialOutbound',
          'info': {'url': new ArrivalWeekReport(), 'img': 'report_blue.png'}
        },
        {
          'tabName': '来料:质量分析(按供应商)',
          'code': 'otherOutbound',
          'info': {'url': new ArrivalSupplierReport(), 'img': 'report_blue.png'}
        }
      ]
    }
  ];
}
