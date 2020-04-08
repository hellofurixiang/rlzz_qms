import 'package:qms/common/config/Config.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';

///=============质检系统=============
class FieldConfig {
  ///来料待检列表
  static const arrivalWaitTaskListPage = {
    'fields': [
      {
        'fieldCode': 'luru',
        'displayName': '操作',
        'fieldName': '录入',
        'fieldType': StringZh.listOper, //字段类型
        'onTap': true,
        'width': 60.0,
        'color': SetColors.mainColorValue,
        'checkField': 'canCheckQty', //显示操作校验字段
      },
      {
        'displayName': '到货日期',
        'fieldCode': 'arrivalDocDate',
        //'color': RLZZColors.mainColorValue,
        //'fieldType': Config.TYPE_FIELD_DATE, //字段类型
        //'dateFormat': Config.DATE_FORMAT_DATE, //日期格式
        'width': 90.0,
      },
      {
        'displayName': '到货单号',
        'fieldCode': 'arrivalDocNo',
        'width': 90.0,
      },
      {
        'displayName': '行号',
        'fieldCode': 'arrivalSeq',
        'width': 50.0,
      },
      {
        'displayName': '物料编码',
        'fieldCode': 'invCode',
        'width': 150.0,
      },
      {
        'displayName': '物料名称',
        'fieldCode': 'invName',
        'width': 150.0,
      },
      {
        'displayName': '规格型号',
        'fieldCode': 'invSpec',
        'width': 150.0,
      },
      {
        'displayName': '报检数量',
        'fieldCode': 'declareQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '已检数',
        'fieldCode': 'checkedQuantity',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '合格数量',
        'fieldCode': 'qualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '检验单号',
        'fieldCode': 'testOrderDocNo',
        'onTap': true,
        'width': 120.0,
      },
      {
        'displayName': '检验员',
        'fieldCode': 'checker',
        'width': 90.0,
      },
    ],
  };

  ///完工待检列表
  static const completeWaitTaskListPage = {
    'fields': [
      {
        'fieldCode': 'luru',
        'displayName': '操作',
        'fieldName': '录入',
        'fieldType': StringZh.listOper, //字段类型
        'onTap': true,
        'width': 60.0,
        'color': SetColors.mainColorValue,
        'checkField': 'canCheckQty', //显示操作校验字段
      },
      {
        'displayName': '报检日期',
        'fieldCode': 'inspectionDate',
        'fieldType': Config.fieldTypeDate, //字段类型
        'dateFormat': Config.formatDateTime, //日期格式
      },
      {
        'displayName': '批号',
        'fieldCode': 'batchNumber',
      },
      {
        'displayName': '客户',
        'fieldCode': 'cusName',
      },
      {
        'displayName': '工序名称',
        'fieldCode': 'opName',
      },
      {
        'displayName': '报检人',
        'fieldCode': 'applicant',
      },
      {
        'displayName': '工作中心',
        'fieldCode': 'workCenter',
      },
      {'displayName': '报工单号', 'fieldCode': 'vouchCode', 'width': 120.0},
      {'displayName': '工序行号', 'fieldCode': 'opSortSeq', 'width': 90.0},
      {'displayName': '物料编码', 'fieldCode': 'invCode', 'width': 120.0},
      {'displayName': '物料名称', 'fieldCode': 'invName', 'width': 120.0},
      {'displayName': '规格型号', 'fieldCode': 'invSpec', 'width': 120.0},
      {'displayName': '生产订单', 'fieldCode': 'moCode', 'width': 120.0},
      {'displayName': '生产订单行号', 'fieldCode': 'moSortSeq', 'width': 120.0},
      {
        'displayName': '报检数量',
        'fieldCode': 'declareQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '已检数',
        'fieldCode': 'checkedQuantity',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '合格数量',
        'fieldCode': 'qualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '检验单号',
        'fieldCode': 'testOrderDocNo',
        'width': 120.0,
        'onTap': true,
      },
      {
        'displayName': '检验员',
        'fieldCode': 'checker',
      },
      {
        'displayName': '产品类型',
        'fieldCode': 'protype',
      },
      {
        'displayName': '需求跟踪号',
        'fieldCode': 'socode',
      },
    ],
  };

  ///来料检验单列表
  static const arrivalTestOrderListPage = {
    'fields': [
      {
        'fieldType': StringZh.listOper,
        'displayName': '操作',
        'fieldName': '录入',
        'width': 40.0,
      },
      {
        'fieldCode': 'docDate',
        'displayName': '报检日期',
        'width': 90.0,
      },
      {
        'fieldCode': 'docDate',
        'displayName': '检验日期',
        'width': 90.0,
      },
      {
        'displayName': '检验单号',
        'fieldCode': 'docNo',
        'onTap': true,
        'color': SetColors.mainColorValue,
        'width': 150.0,
      },
      {
        'displayName': '物料编码',
        'fieldCode': 'invCode',
        'width': 150.0,
      },
      {
        'displayName': '物料名称',
        'fieldCode': 'invName',
        'width': 150.0,
      },
      {
        'displayName': '规格型号',
        'fieldCode': 'invSpec',
        'width': 150.0,
      },
      {
        'displayName': '报检数量',
        'fieldCode': 'quantity',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '合格数',
        'fieldCode': 'qualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '不良数',
        'fieldCode': 'unQualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '让步接收数',
        'fieldCode': 'concessionReceivedQuantity',
        'fieldType': Config.fieldTypeNumber,
        'width': 90.0,
      },
      {
        'displayName': '检验员',
        'fieldCode': 'operator',
        'width': 90.0,
      },
      {
        'displayName': '来源单据类型',
        'fieldCode': 'srcDocType',
        'width': 100.0,
      },
      {
        'displayName': '来源单据号',
        'fieldCode': 'srcDocNo',
        'width': 90.0,
      },
      {
        'displayName': '来源单据行号',
        'fieldCode': 'srcDocRowNum',
        'width': 90.0,
      },
    ],
  };

  ///完工检验单列表
  static const completeTestOrderListPage = {
    'fields': [
      {
        'displayName': '报检日期',
        'fieldCode': 'inspectionDate',
      },
      {
        'fieldCode': 'docDate',
        'displayName': '检验日期',
      },
      {
        'displayName': '检验单号',
        'fieldCode': 'docNo',
        'onTap': true,
        'color': SetColors.mainColorValue,
        'width': 150.0,
      },
      {
        'displayName': '批号',
        'fieldCode': 'batchNumber',
      },
      {
        'displayName': '客户',
        'fieldCode': 'cusName',
      },
      {
        'displayName': '工序编码',
        'fieldCode': 'workStepCode',
      },
      {
        'displayName': '工序名称',
        'fieldCode': 'workStepName',
      },
      {
        'displayName': '检验员',
        'fieldCode': 'operator',
      },
      {
        'displayName': '需求跟踪号',
        'fieldCode': 'socode',
      },
      {
        'displayName': '物料编码',
        'fieldCode': 'invCode',
      },
      {
        'displayName': '物料名称',
        'fieldCode': 'invName',
      },
      {
        'displayName': '规格型号',
        'fieldCode': 'invSpec',
      },
      {
        'displayName': '报检数量',
        'fieldCode': 'quantity',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '合格数',
        'fieldCode': 'qualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '不良数',
        'fieldCode': 'unQualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '让步接收数',
        'fieldCode': 'concessionReceivedQuantity',
      },
      {
        'displayName': '来源单据类型',
        'fieldCode': 'srcDocType',
      },
      {
        'displayName': '来源单据号',
        'fieldCode': 'srcDocNo',
      },
      {
        'displayName': '来源单据行号',
        'fieldCode': 'srcDocRowNum',
      },
      {
        'displayName': '生产订单号',
        'fieldCode': 'moDocNo',
      },
      {
        'displayName': '产品类型',
        'fieldCode': 'protype',
      },
    ],
  };

  ///来料检验单表体检验指标列表
  static const testOrderDetailQuotaList = {
    'fields': [
      {
        'fieldType': StringZh.listOper,
        'displayName': '操作',
        'fieldName': '录入',
        'width': 40.0,
      },
      {
        'fieldCode': 'testItemName',
        'displayName': '检验项目',
        'width': 100.0,
      },
      {
        'fieldCode': 'testQuotaName',
        'displayName': '检验指标',
        'width': 100.0,
      },
      {
        'displayName': '指标类型',
        'fieldCode': 'quotaCat',
        'width': 80.0,
      },
      {
        'displayName': '标准值',
        'fieldCode': 'standardValue',
        'width': 60.0,
      },
      {
        'displayName': '下限值',
        'fieldCode': 'lowerLimitValue',
        'width': 60.0,
      },
      {
        'displayName': '上限值',
        'fieldCode': 'upperLimitValue',
        'width': 60.0,
      },
      {
        'displayName': '检测值',
        'fieldCode': 'testVal',
        'inputType': Config.inputTypeText,
        'width': 70.0,
        'mandatory': true,
      },
      {
        'displayName': '状态',
        'fieldCode': 'state',
        'width': 60.0,
      },
      {
        'displayName': '检验描述',
        'fieldCode': 'testDecription',
        'width': 80.0,
      },
      {
        'displayName': '附件',
        'fieldCode': 'enclosure',
        'width': 80.0,
      },
      {
        'displayName': '检验方法',
        'fieldCode': 'testWay',
        'width': 80.0,
      },
      {
        'displayName': '检验方式',
        'fieldCode': 'samplingWay',
        'width': 80.0,
      },
      {
        'displayName': '缺陷等级',
        'fieldCode': 'defectLevel',
        'width': 80.0,
      },
      {
        'displayName': '检验设备仪器',
        'fieldCode': 'inspectionEquipment',
        'width': 90.0,
      },
      {
        'displayName': '不良原因',
        'fieldCode': 'badReasonName',
        'width': 100.0,
      },
      {
        'displayName': '不良说明',
        'fieldCode': 'badReasonInfo',
        'width': 150.0,
      },
      {
        'displayName': '操作者',
        'fieldCode': 'producer',
        'width': 70.0,
      },
      {
        'displayName': '图像附件',
        'fieldCode': 'badReasonInfo',
        'width': 90.0,
      },
    ],
  };

  ///来料检验供应商统计
  static const arrivalSupplierReport = {
    'fields': [
      {
        'fieldCode': 'supplierCode',
        'displayName': '供应商编码',
        'width': 100.0,
      },
      {
        'fieldCode': 'supplierName',
        'displayName': '供应商名称',
        'width': 200.0,
      },
      {
        'inputType': Config.inputTypeReadonly,
        'displayName': '项目',
        'fieldNames': ['批量', '数量'],
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qty', 'qty'],
        'displayName': '报检',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qualifiedQty', 'qualifiedQty'],
        'displayName': '合格',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': [
          'batch_concessionReceivedQuantity',
          'concessionReceivedQuantity'
        ],
        'displayName': '让步接收',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_unQualifiedQty', 'unQualifiedQty'],
        'displayName': '不良',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_reworkQty', 'reworkQty'],
        'displayName': '返工',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_spQty', 'spQty'],
        'displayName': '特采',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_scrapQty', 'scrapQty'],
        'displayName': '报废',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qualificationRate', 'qualificationRate'],
        'displayName': '合格率(%)',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_unQualificationRate', 'unQualificationRate'],
        'displayName': '不良率(%)',
        'isSpit': true,
        'width': 100.0,
      },
    ]
  };

  ///来料检验周统计
  static const arrivalWeekReport = {
    'fields': [
      {
        'fieldCode': 'itemName',
        'displayName': '年-周',
        'width': 100.0,
      },
      {
        'inputType': Config.inputTypeReadonly,
        'displayName': '项目',
        'fieldNames': ['批量', '数量'],
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qty', 'qty'],
        'displayName': '报检',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qualifiedQty', 'qualifiedQty'],
        'displayName': '合格',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': [
          'batch_concessionReceivedQuantity',
          'concessionReceivedQuantity'
        ],
        'displayName': '让步接收',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_unQualifiedQty', 'unQualifiedQty'],
        'displayName': '不良',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_reworkQty', 'reworkQty'],
        'displayName': '返工',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_spQty', 'spQty'],
        'displayName': '特采',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_scrapQty', 'scrapQty'],
        'displayName': '报废',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qualificationRate', 'qualificationRate'],
        'displayName': '合格率(%)',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_unQualificationRate', 'unQualificationRate'],
        'displayName': '不良率(%)',
        'isSpit': true,
        'width': 100.0,
      },
    ]
  };

  ///来料检验月统计
  static const arrivalMonthReport = {
    'fields': [
      {
        'fieldCode': 'itemName',
        'displayName': '年-月',
        'width': 100.0,
      },
      {
        'inputType': Config.inputTypeReadonly,
        'displayName': '项目',
        'fieldNames': ['批量', '数量'],
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qty', 'qty'],
        'displayName': '报检',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qualifiedQty', 'qualifiedQty'],
        'displayName': '合格',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': [
          'batch_concessionReceivedQuantity',
          'concessionReceivedQuantity'
        ],
        'displayName': '让步接收',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_unQualifiedQty', 'unQualifiedQty'],
        'displayName': '不良',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_reworkQty', 'reworkQty'],
        'displayName': '返工',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_spQty', 'spQty'],
        'displayName': '特采',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_scrapQty', 'scrapQty'],
        'displayName': '报废',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_qualificationRate', 'qualificationRate'],
        'displayName': '合格率(%)',
        'isSpit': true,
        'width': 100.0,
      },
      {
        'fieldCode': ['batch_unQualificationRate', 'unQualificationRate'],
        'displayName': '不良率(%)',
        'isSpit': true,
        'width': 100.0,
      },
    ]
  };

  ///IQC待检列表
  static const iqcWaitTaskListPage = {
    'fields': [
      {
        'fieldCode': 'luru',
        'displayName': '操作',
        'fieldName': '录入',
        'fieldType': StringZh.listOper, //字段类型
        'onTap': true,
        'width': 60.0,
        'color': SetColors.mainColorValue,
        'checkField': 'canCheckQty', //显示操作校验字段
      },
      {
        'displayName': '到货日期',
        'fieldCode': 'arrivalDocDate',
        //'color': RLZZColors.mainColorValue,
        //'fieldType': Config.TYPE_FIELD_DATE, //字段类型
        //'dateFormat': Config.DATE_FORMAT_DATE, //日期格式
        'width': 90.0,
      },
      {
        'displayName': '到货单号',
        'fieldCode': 'arrivalDocNo',
        'width': 90.0,
      },
      {
        'displayName': '行号',
        'fieldCode': 'arrivalSeq',
        'width': 50.0,
      },
      {
        'displayName': '物料编码',
        'fieldCode': 'invCode',
        'width': 150.0,
      },
      {
        'displayName': '物料名称',
        'fieldCode': 'invName',
        'width': 150.0,
      },
      {
        'displayName': '规格型号',
        'fieldCode': 'invSpec',
        'width': 150.0,
      },
      {
        'displayName': '报检数量',
        'fieldCode': 'declareQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '已检数',
        'fieldCode': 'checkedQuantity',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '合格数量',
        'fieldCode': 'qualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '检验单号',
        'fieldCode': 'testOrderDocNo',
        'onTap': true,
        'width': 120.0,
      },
      {
        'displayName': '检验员',
        'fieldCode': 'checker',
        'width': 90.0,
      },
    ],
  };

  ///IPQC待检列表
  static const ipqcWaitTaskListPage = {
    'fields': [
      {
        'fieldCode': 'luru',
        'displayName': '操作',
        'fieldName': '录入',
        'fieldType': StringZh.listOper, //字段类型
        'onTap': true,
        'width': 60.0,
        'color': SetColors.mainColorValue,
        'checkField': 'canCheckQty', //显示操作校验字段
      },
      {
        'displayName': '到货日期',
        'fieldCode': 'arrivalDocDate',
        //'color': RLZZColors.mainColorValue,
        //'fieldType': Config.TYPE_FIELD_DATE, //字段类型
        //'dateFormat': Config.DATE_FORMAT_DATE, //日期格式
        'width': 90.0,
      },
      {
        'displayName': '到货单号',
        'fieldCode': 'arrivalDocNo',
        'width': 90.0,
      },
      {
        'displayName': '行号',
        'fieldCode': 'arrivalSeq',
        'width': 50.0,
      },
      {
        'displayName': '物料编码',
        'fieldCode': 'invCode',
        'width': 150.0,
      },
      {
        'displayName': '物料名称',
        'fieldCode': 'invName',
        'width': 150.0,
      },
      {
        'displayName': '规格型号',
        'fieldCode': 'invSpec',
        'width': 150.0,
      },
      {
        'displayName': '报检数量',
        'fieldCode': 'declareQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '已检数',
        'fieldCode': 'checkedQuantity',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '合格数量',
        'fieldCode': 'qualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '检验单号',
        'fieldCode': 'testOrderDocNo',
        'onTap': true,
        'width': 120.0,
      },
      {
        'displayName': '检验员',
        'fieldCode': 'checker',
        'width': 90.0,
      },
    ],
  };

  ///FQC待检列表
  static const fqcWaitTaskListPage = {
    'fields': [
      {
        'fieldCode': 'luru',
        'displayName': '操作',
        'fieldName': '录入',
        'fieldType': StringZh.listOper, //字段类型
        'onTap': true,
        'width': 60.0,
        'color': SetColors.mainColorValue,
        'checkField': 'canCheckQty', //显示操作校验字段
      },
      {
        'displayName': '报检日期',
        'fieldCode': 'inspectionDate',
        'fieldType': Config.fieldTypeDate, //字段类型
        'dateFormat': Config.formatDateTime, //日期格式
      },
      {
        'displayName': '批号',
        'fieldCode': 'batchNumber',
      },
      {
        'displayName': '客户',
        'fieldCode': 'cusName',
      },
      {
        'displayName': '工序名称',
        'fieldCode': 'opName',
      },
      {
        'displayName': '报检人',
        'fieldCode': 'applicant',
      },
      {
        'displayName': '工作中心',
        'fieldCode': 'workCenter',
      },
      {'displayName': '报工单号', 'fieldCode': 'vouchCode', 'width': 120.0},
      {'displayName': '工序行号', 'fieldCode': 'opSortSeq', 'width': 90.0},
      {'displayName': '物料编码', 'fieldCode': 'invCode', 'width': 120.0},
      {'displayName': '物料名称', 'fieldCode': 'invName', 'width': 120.0},
      {'displayName': '规格型号', 'fieldCode': 'invSpec', 'width': 120.0},
      {'displayName': '生产订单', 'fieldCode': 'moCode', 'width': 120.0},
      {'displayName': '生产订单行号', 'fieldCode': 'moSortSeq', 'width': 120.0},
      {
        'displayName': '报检数量',
        'fieldCode': 'declareQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '已检数',
        'fieldCode': 'checkedQuantity',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '合格数量',
        'fieldCode': 'qualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '检验单号',
        'fieldCode': 'testOrderDocNo',
        'width': 120.0,
        'onTap': true,
      },
      {
        'displayName': '检验员',
        'fieldCode': 'checker',
      },
      {
        'displayName': '产品类型',
        'fieldCode': 'protype',
      },
      {
        'displayName': '需求跟踪号',
        'fieldCode': 'socode',
      },
    ],
  };

  ///PQC待检列表
  static const pqcWaitTaskListPage = {
    'fields': [
      {
        'fieldCode': 'luru',
        'displayName': '操作',
        'fieldName': '录入',
        'fieldType': StringZh.listOper, //字段类型
        'onTap': true,
        'width': 60.0,
        'color': SetColors.mainColorValue,
        'checkField': 'canCheckQty', //显示操作校验字段
      },
      {
        'displayName': '报检日期',
        'fieldCode': 'inspectionDate',
        'fieldType': Config.fieldTypeDate, //字段类型
        'dateFormat': Config.formatDateTime, //日期格式
      },
      {
        'displayName': '批号',
        'fieldCode': 'batchNumber',
      },
      {
        'displayName': '客户',
        'fieldCode': 'cusName',
      },
      {
        'displayName': '工序名称',
        'fieldCode': 'opName',
      },
      {
        'displayName': '报检人',
        'fieldCode': 'applicant',
      },
      {
        'displayName': '工作中心',
        'fieldCode': 'workCenter',
      },
      {'displayName': '报工单号', 'fieldCode': 'vouchCode', 'width': 120.0},
      {'displayName': '工序行号', 'fieldCode': 'opSortSeq', 'width': 90.0},
      {'displayName': '物料编码', 'fieldCode': 'invCode', 'width': 120.0},
      {'displayName': '物料名称', 'fieldCode': 'invName', 'width': 120.0},
      {'displayName': '规格型号', 'fieldCode': 'invSpec', 'width': 120.0},
      {'displayName': '生产订单', 'fieldCode': 'moCode', 'width': 120.0},
      {'displayName': '生产订单行号', 'fieldCode': 'moSortSeq', 'width': 120.0},
      {
        'displayName': '报检数量',
        'fieldCode': 'declareQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '已检数',
        'fieldCode': 'checkedQuantity',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '合格数量',
        'fieldCode': 'qualifiedQty',
        'fieldType': Config.fieldTypeNumber,
      },
      {
        'displayName': '检验单号',
        'fieldCode': 'testOrderDocNo',
        'width': 120.0,
        'onTap': true,
      },
      {
        'displayName': '检验员',
        'fieldCode': 'checker',
      },
      {
        'displayName': '产品类型',
        'fieldCode': 'protype',
      },
      {
        'displayName': '需求跟踪号',
        'fieldCode': 'socode',
      },
    ],
  };

  ///物料附件
  static const invEnclosure = {
    'fields': [
      {'displayName': '文件编码', 'fieldCode': 'code', 'width': 180.0},
      {
        'displayName': '文件名称',
        'fieldCode': 'name',
        'onTap': true,
      },
      {
        'displayName': '文件版本',
        'fieldCode': 'docVer',
      },
      {
        'displayName': '生效日期',
        'fieldCode': 'effectiveDate', 'width': 150.0
      },
      {
        'displayName': '作废日期',
        'fieldCode': 'deactivationDate', 'width': 150.0
      },
      {'displayName': '档案类型', 'fieldCode': 'docFileType'},
      {'displayName': '档案备份', 'fieldCode': 'docFullNameBak', 'width': 120.0},
    ],
  };
}
