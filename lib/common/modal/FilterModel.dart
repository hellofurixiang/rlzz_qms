import 'package:qms/common/modal/BaseEntity.dart';
import 'package:qms/common/modal/RefBasic.dart';

class FilterModel extends BaseEntity {
  ///筛选项目类型
  String itemType;

  ///项目编码
  String itemCode;

  ///项目编码数组
  List<String> itemCodes;

  ///项目存储名称
  String itemText;

  ///项目名称
  String itemName;

  ///参照类型
  String refFlag;

  ///关联参照，通过关联参照做筛选操作，如：货位参照关联仓库参照，选择仓库之后点击货位参照则选择仓库数据成为货位参照请求的参数
  String associated;

  ///参照查询参数，如仓库添加过滤条件：是否停用状态
  Map<String, String> refParams;

  ///参照显示标题
  String title;

  ///包含全部选项
  bool hasAll;

  ///选项数据
  List<Map<String, Object>> selectList;

  ///初始值
  RefBasic initParam;

  ///初始值
  Map<String, Object> returnVal;

  ///多功能构造函数
  FilterModel.input(
      this.itemType, this.itemCode, this.itemName, this.returnVal);

  ///多选、单选
  FilterModel.select(
      this.itemType, this.itemCode, this.itemName, this.selectList);

  ///日期
  FilterModel.date(
      this.itemType, this.itemCodes, this.itemName, this.returnVal);

  ///关联参照
  FilterModel.associated(
      this.itemType,
      this.itemCode,
      this.itemText,
      this.itemName,
      this.refFlag,
      this.title,
      this.hasAll,
      this.initParam,
      this.associated);

  ///有筛选参数参照
  FilterModel.refParams(
      this.itemType,
      this.itemCode,
      this.itemText,
      this.itemName,
      this.refFlag,
      this.title,
      this.hasAll,
      this.initParam,
      this.refParams);

  ///普通参照
  FilterModel(this.itemType, this.itemCode, this.itemText, this.itemName,
      this.refFlag, this.title, this.hasAll, this.initParam);
}
