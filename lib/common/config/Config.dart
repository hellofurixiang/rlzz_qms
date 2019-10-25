class Config {
  ///调试状态
  static const isDebugKey = 'is-debug';

  static const debugBosIp = 'http://192.168.47.16:82/';

  ///协议
  static const protocol = 'http';

  static const protocols = 'https';

  ///端口
  static const post = '82';

  ///目录
  static const catalog = 'catalog';

  ///竖屏 true,横屏 false
  static const screenMode = false;

  ///调试状态（用于打印日志等...）
  static const debug = true;

  ///bugly app id
  static const buglyAppId = "087ffcdcbe";

  ///bugly app key
  static const buglyAppKey = "f841ad96-1935-4c5f-ae56-62c093c9682a";

  ///标准屏幕宽度
  static const screenWidth = 600;

  ///页条数
  static const pageSize = 10;

  ///数字精度默认值
  static const qtyScale = 2;

  ///密钥
  static const tokenKey = 'token';

  ///账号
  static const accountKey = 'account';

  ///密码
  static const passwordKey = 'password';

  ///登录时间
  static const loginDateKey = 'login-date';

  ///记住密码
  static const isRememberPassKey = 'is-keep-pwd';

  ///用户信息
  static const userInfoKey = 'user-info';

  ///系统配置信息
  static const systemConfigKey = 'system-config';

  ///用户拥有的权限
  static const userResourcesKey = 'user-resources';

  ///精度
  static const precisionKey = 'parameterDigitalMap';

  ///账套
  static const sobKey = 'sob';

  ///数字精度
  static const qtyScaleKey = 'qty-scale';

  ///接口协议
  static const protocolKey = 'protocol';

  ///IP地址
  static const ipKey = 'ip';

  ///端口
  static const postKey = 'post';

  ///端口
  static const catalogKey = 'catalog';

  ///QMS业务服务地址前缀
  static const qmsApiUrl = 'r9-qms-app/api/qms/app';

  ///系统服务地址前缀
  static const bossApiUrl = 'ecaf-bos';

  ///连接超时时间（秒）
  static const connectTimeout = 15000;

  ///接收数据超时时间（秒）
  static const receiveTimeout = 15000;

  ///参照用===========================start

  ///供应商
  static const ref_supplier = 'supplier';

  ///物料
  static const ref_inventory = 'inventory';

  ///物料分类
  static const ref_invCat = 'invCat';

  ///客户
  static const ref_customer = 'customer';

  ///工作中心
  static const ref_workCenter = 'workCenter';

  ///工序
  static const ref_workStep = 'workStep';

  ///用户
  static const ref_user = 'user';

  ///参照用===========================end

  ///筛选用===========================start

  ///参照
  static const filterItemTypeRef = '参照';

  ///文本
  static const filterItemTypeInput = '文本';

  ///单选
  static const filterItemTypeSingleSelect = '单选';

  ///多选
  static const filterItemTypeMultipleSelect = '多选';

  ///日期
  static const filterItemTypeDate = '日期';

  ///只读
  static const filterItemTypeLabel = '只读';

  ///筛选用==============================end

  ///表头、扫码区配置字段用===========================start

  ///字段类型
  static const fieldTypeText = 'text';
  static const fieldTypeDate = 'date';
  static const fieldTypeNumber = 'number';

  ///前端录入方式
  static const inputTypeReadonly = '只读';
  static const inputTypeText = '文本';
  static const inputTypeRef = '参照';

  ///表头、扫码区配置字段用===========================end

  ///日期格式：年-月-日 时:分
  static const formatDateTime = 'yyyy-MM-dd HH:mm';

  ///日期格式：年-月-日
  static const formatDate = 'yyyy-MM-dd';

  ///完工、来料
  static const test_order_complete = 'default';
  static const test_order_complete_sample = 'defSample';
  static const test_order_arrival = '002';
  static const test_order_arrival_sample = '002Sample';

  static const test_order_iqc = '003';
  static const test_order_ipqc = '004';
  static const test_order_fqc = '005';
  static const test_order_pqc = '006';

  static const text_complete = '生产完工检';
  static const text_complete_sample = '生产完工检(按样本)';
  static const text_arrival = '来料检验';
  static const text_arrival_sample = '来料检验(按样本)';

  static const text_iqc = '来料检验';
  static const text_ipqc = '生产巡检';
  static const text_pqc = '生产自检';
  static const text_fqc = '生产完工检';

  ///请求方式
  static const method_post = 'POST';
  static const method_get = 'GET';

  ///检验指标类型 (录入型，枚举型)
  static const quotaTypeEntryNumber = "录入型(数值)";
  static const quotaTypeEntryText = "录入型(文本)";
  static const quotaTypeEnum = "枚举型";

  ///一般缺陷数
  static const generalDefectsQty = '一般缺陷';

  ///主要缺陷数
  static const majorDefectsQty = '主要缺陷';

  ///严重缺陷数
  static const seriousDefectsQty = '严重缺陷';

  static const testForInv = '按物料检验';
  static const testForQuota = '按指标检验';

  static const receive = '接收';

  static const concessionsToReceive= '让步接收';

  static const testResult = ['接收', '让步接收', '拒收', '挑选', '返工', '报废'];

  ///页面路由配置
  static const login = '/login';
  static const splash = '/splash';
  static const serviceSetting = '/serviceSetting';
  static const mainPage = '/mainPage';
  static const arrivalWaitTaskListPage = '/arrivalWaitTaskListPage';
  static const arrivalTestOrderListPage = '/arrivalTestOrderListPage';
  static const arrivalTestOrderSampleListPage =
      '/arrivalTestOrderSampleListPage';

  static const iqcWaitTaskListPage = '/iqcWaitTaskListPage';
  static const iqcTestOrderListPage = '/iqcTestOrderListPage';
  static const ipqcWaitTaskListPage = '/ipqcWaitTaskListPage';
  static const ipqcTestOrderListPage = '/ipqcTestOrderListPage';
  static const pqcWaitTaskListPage = '/pqcWaitTaskListPage';
  static const pqcTestOrderListPage = '/pqcTestOrderListPage';
  static const fqcWaitTaskListPage = '/fqcWaitTaskListPage';
  static const fqcTestOrderListPage = '/fqcTestOrderListPage';

  static const completeWaitTaskListPage = '/completeWaitTaskListPage';
  static const completeTestOrderListPage = '/completeTestOrderListPage';
  static const completeTestOrderSampleListPage =
      '/completeTestOrderSampleListPage';

  ///来料检验报表类型
  static const arrivalMonthReport = 0;
  static const arrivalWeekReport = 1;
  static const arrivalSupplierReport = 2;

  ///与原生交互报表控件ID
  static const chartViewTypeId = 'com.szrlzz.qms/combinedChart';

  ///不良原因参照
  static const badReasonRefUrl = '/badReason/findBadReasonRef';

  ///测量工具
  static const measuringToolRefUrl = '/findMeasuringToolRef';

  static const completeWaitList_view  = 'dld:quarantinetask-default-list:list';
  static const completeTestOrderList_view  = 'dld:testorder-default-list:list';
  static const complete_add = 'form:testOrder:default:add';
  static const complete_view = 'form:testOrder:default:view';
  static const complete_edit = 'form:testOrder:default:edit';
  static const complete_save = 'form:testOrder:default:save';
  static const complete_audit = 'form:testOrder:default:audit';
  static const complete_unaudit = 'form:testOrder:default:unaudit';
  static const complete_del = 'form:testOrder:default:del';


  static const completeSampleList_view = 'dld:testorder-default-sample-list:list';
  static const completeSample_add = 'form:testOrder:defSample:add';
  static const completeSample_view = 'form:testOrder:defSample:view';
  static const completeSample_edit = 'form:testOrder:defSample:edit';
  static const completeSample_save = 'form:testOrder:defSample:save';
  static const completeSample_audit = 'form:testOrder:defSample:audit';
  static const completeSample_unaudit = 'form:testOrder:defSample:unaudit';
  static const completeSample_del = 'form:testOrder:defSample:del';

  static const arrivalWaitList_view  = 'dld:quarantinetask-002-list:list';
  static const arrivalTestOrderList_view  = 'dld:testorder-002-list:list';
  static const arrival_add = 'form:testOrder:002:add';
  static const arrival_view = 'form:testOrder:002:view';
  static const arrival_edit = 'form:testOrder:002:edit';
  static const arrival_save = 'form:testOrder:002:save';
  static const arrival_audit = 'form:testOrder:002:audit';
  static const arrival_unaudit = 'form:testOrder:002:unaudit';
  static const arrival_del = 'form:testOrder:002:del';


  static const arrivalSampleList_view = 'dld:testorder-002-sample-list:list';
  static const arrivalSample_add = 'form:testOrder:002Sample:add';
  static const arrivalSample_view = 'form:testOrder:002Sample:view';
  static const arrivalSample_edit = 'form:testOrder:002Sample:edit';
  static const arrivalSample_save = 'form:testOrder:002Sample:save';
  static const arrivalSample_audit = 'form:testOrder:002Sample:audit';
  static const arrivalSample_unaudit = 'form:testOrder:002Sample:unaudit';
  static const arrivalSample_del = 'form:testOrder:002Sample:del';

  static const iqcWaitList_view = 'dld:iqcWaitList:list';
  static const iqcTestOrderList_view  = 'dld:testorder-iqc-list:list';
  static const iqc_add = 'form:testOrder:003:add';
  static const iqc_view = 'form:testOrder:003:view';
  static const iqc_edit = 'form:testOrder:003:edit';
  static const iqc_save = 'form:testOrder:003:save';
  static const iqc_audit = 'form:testOrder:003:audit';
  static const iqc_unaudit = 'form:testOrder:003:unaudit';
  static const iqc_del = 'form:testOrder:003:del';

  static const ipqcWaitList_view  = 'dld:ipqcWaitList:list';
  static const ipqcTestOrderList_view  = 'dld:testorder-ipqc-list:list';
  static const ipqc_add = 'form:testOrder:004:add';
  static const ipqc_view = 'form:testOrder:004:view';
  static const ipqc_edit = 'form:testOrder:004:edit';
  static const ipqc_save = 'form:testOrder:004:save';
  static const ipqc_audit = 'form:testOrder:004:audit';
  static const ipqc_unaudit = 'form:testOrder:004:unaudit';
  static const ipqc_del = 'form:testOrder:004:del';

  static const fqcWaitList_view  = 'dld:fqcWaitList:list';
  static const fqcTestOrderList_view  = 'dld:testorder-fqc-list:list';
  static const fqc_add = 'form:testOrder:005:add';
  static const fqc_view = 'form:testOrder:005:view';
  static const fqc_edit = 'form:testOrder:005:edit';
  static const fqc_save = 'form:testOrder:005:save';
  static const fqc_audit = 'form:testOrder:005:audit';
  static const fqc_unaudit = 'form:testOrder:005:unaudit';
  static const fqc_del = 'form:testOrder:005:del';

  static const pqcWaitList_view  = 'dld:pqcWaitList:list';
  static const pqcTestOrderList_view  = 'dld:testorder-pqc-list:list';
  static const pqc_add = 'form:testOrder:006:add';
  static const pqc_view = 'form:testOrder:006:view';
  static const pqc_edit = 'form:testOrder:006:edit';
  static const pqc_save = 'form:testOrder:006:save';
  static const pqc_audit = 'form:testOrder:006:audit';
  static const pqc_unaudit = 'form:testOrder:006:unaudit';
  static const pqc_del = 'form:testOrder:006:del';




  static const arrivalTestOrderStatisticalForMonth='dld:arrivalTestOrderStatisticalForMonth-list:list';
  static const arrivalTestOrderStatisticalForWeek='dld:arrivalTestOrderStatisticalForWeek-list:list';
  static const arrivalTestOrderStatisticalForSupplier='dld:arrivalTestOrderStatisticalForSupplier-list:list';
}
