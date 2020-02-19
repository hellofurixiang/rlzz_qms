class Config {
  ///调试状态
  static const String isDebugKey = 'is-debug';

  static const String debugBosIp = 'http://192.168.47.16:82/';

  ///协议
  static const String protocol = 'http';

  static const String protocols = 'https';

  ///端口
  static const String post = '82';

  ///目录
  static const String catalog = 'catalog';

  ///竖屏 true,横屏 false
  static const bool screenMode = false;

  ///调试状态（用于打印日志等...）
  static const bool debug = true;

  ///bugly app id
  static const String buglyAppId = "21cc9c4212";

  ///bugly app key
  static const String buglyAppKey = "b2b8faea-6c33-4029-bc20-1760e9e72433";

  ///标准屏幕宽度
  static const int screenWidth = 600;

  ///页条数
  static const int pageSize = 10;

  ///数字精度默认值
  static const int qtyScale = 2;

  ///密钥
  static const String tokenKey = 'token';

  ///账号
  static const String accountKey = 'account';

  ///密码
  static const String passwordKey = 'password';

  ///登录时间
  static const String loginDateKey = 'login-date';

  ///记住密码
  static const String isRememberPassKey = 'is-keep-pwd';

  ///用户信息
  static const String userInfoKey = 'user-info';

  ///系统配置信息
  static const String systemConfigKey = 'system-config';

  ///用户拥有的权限
  static const String userResourcesKey = 'user-resources';

  ///精度
  static const String precisionKey = 'parameterDigitalMap';

  ///账套
  static const String sobKey = 'sob';

  ///数字精度
  static const String qtyScaleKey = 'qty-scale';

  ///接口协议
  static const String protocolKey = 'protocol';

  ///IP地址
  static const String ipKey = 'ip';

  ///端口
  static const String postKey = 'post';

  ///端口
  static const String catalogKey = 'catalog';

  ///QMS业务服务地址前缀
  static const String qmsApiUrl = 'r9-qms-app/api/qms/app';

  ///系统服务地址前缀
  static const String bossApiUrl = 'ecaf-bos';

  ///连接超时时间（秒）
  static const int connectTimeout = 15000;

  ///接收数据超时时间（秒）
  static const int receiveTimeout = 15000;

  ///参照用===========================start

  ///供应商
  static const String ref_supplier = 'supplier';

  ///物料
  static const String ref_inventory = 'inventory';

  ///物料分类
  static const String ref_invCat = 'invCat';

  ///客户
  static const String ref_customer = 'customer';

  ///工作中心
  static const String ref_workCenter = 'workCenter';

  ///工序
  static const String ref_workStep = 'workStep';

  ///用户
  static const String ref_user = 'user';

  ///参照用===========================end

  ///筛选用===========================start

  ///参照
  static const String filterItemTypeRef = '参照';

  ///文本
  static const String filterItemTypeInput = '文本';

  ///单选
  static const String filterItemTypeSingleSelect = '单选';

  ///多选
  static const String filterItemTypeMultipleSelect = '多选';

  ///日期
  static const String filterItemTypeDate = '日期';

  ///只读
  static const String filterItemTypeLabel = '只读';

  ///筛选用==============================end

  ///表头、扫码区配置字段用===========================start

  ///字段类型
  static const String fieldTypeText = 'text';
  static const String fieldTypeDate = 'date';
  static const String fieldTypeNumber = 'number';

  ///前端录入方式
  static const String inputTypeReadonly = '只读';
  static const String inputTypeText = '文本';
  static const String inputTypeRef = '参照';

  ///表头、扫码区配置字段用===========================end

  ///日期格式：年-月-日 时:分
  static const String formatDateTime = 'yyyy-MM-dd HH:mm';

  ///日期格式：年-月-日
  static const String formatDate = 'yyyy-MM-dd';

  ///完工、来料
  static const String test_order_complete = 'default';
  static const String test_order_complete_sample = 'defSample';
  static const String test_order_arrival = '002';
  static const String test_order_arrival_sample = '002Sample';

  static const String test_order_iqc = '003';
  static const String test_order_ipqc = '004';
  static const String test_order_fqc = '005';
  static const String test_order_pqc = '006';

  static const String text_complete = '生产完工检';
  static const String text_complete_sample = '生产完工检(按样本)';
  static const String text_arrival = '来料检验';
  static const String text_arrival_sample = '来料检验(按样本)';

  static const String text_iqc = '来料检验';
  static const String text_ipqc = '生产抽检';
  static const String text_pqc = '生产自检';
  static const String text_fqc = '生产完工检';

  ///请求方式
  static const String method_post = 'POST';
  static const String method_get = 'GET';

  ///检验指标类型 (录入型，枚举型)
  static const String quotaTypeEntryNumber = "录入型(数值)";
  static const String quotaTypeEntryText = "录入型(文本)";
  static const String quotaTypeEnum = "枚举型";

  ///一般缺陷数
  static const String generalDefectsQty = '一般缺陷';

  ///主要缺陷数
  static const String majorDefectsQty = '主要缺陷';

  ///严重缺陷数
  static const String seriousDefectsQty = '严重缺陷';

  static const String abnormal = '异常';
  static const String normal = '正常';

  static const String testForInv = '按物料检验';
  static const String testForQuota = '按指标检验';

  static const String receive = '接收';

  static const String concessionsToReceive = '让步接收';

  static const List<String> testResultValue = [
    'received',
    'consessionReceived',
    'rejecte',
    'choose',
    'rework',
    'scrap',
  ];

  static const List<String> testResultText = [
    '接收',
    '让步接收',
    '拒收',
    '挑选',
    '返工',
    '报废'
  ];

  static const List<String> testResult_pqc = ['合格', '不合格', '报废'];
  static const String qualified = '合格';
  static const String unqualified = '不合格';
  static const String scrap = '报废';

  ///页面路由配置
  static const String login = '/login';
  static const String splash = '/splash';
  static const String serviceSetting = '/serviceSetting';
  static const String mainPage = '/mainPage';
  static const String arrivalWaitTaskListPage = '/arrivalWaitTaskListPage';
  static const String arrivalTestOrderListPage = '/arrivalTestOrderListPage';
  static const String arrivalTestOrderSampleListPage =
      '/arrivalTestOrderSampleListPage';

  static const String iqcWaitTaskListPage = '/iqcWaitTaskListPage';
  static const String iqcTestOrderListPage = '/iqcTestOrderListPage';
  static const String ipqcWaitTaskListPage = '/ipqcWaitTaskListPage';
  static const String ipqcTestOrderListPage = '/ipqcTestOrderListPage';
  static const String pqcWaitTaskListPage = '/pqcWaitTaskListPage';
  static const String pqcTestOrderListPage = '/pqcTestOrderListPage';
  static const String fqcWaitTaskListPage = '/fqcWaitTaskListPage';
  static const String fqcTestOrderListPage = '/fqcTestOrderListPage';

  static const String completeWaitTaskListPage = '/completeWaitTaskListPage';
  static const String completeTestOrderListPage = '/completeTestOrderListPage';
  static const String completeTestOrderSampleListPage =
      '/completeTestOrderSampleListPage';

  ///来料检验报表类型
  static const int arrivalMonthReport = 0;
  static const int arrivalWeekReport = 1;
  static const int arrivalSupplierReport = 2;

  ///与原生交互报表控件ID
  static const String chartViewTypeId = 'com.szrlzz.qms/combinedChart';

  static const String methodChannel_connectivity =
      'com.szrlzz.qms/connectivity';

  static const String methodChannel_connectivity_status =
      'com.szrlzz.qms/connectivity_status';
  static const String methodChannel_device_info = 'com.szrlzz.qms/device_info';
  static const String methodChannel_downloads_path_provider =
      'com.szrlzz.qms/downloads_path_provider';
  static const String methodChannel_file_picker = 'com.szrlzz.qms/file_picker';
  static const String methodChannel_image_picker =
      'com.szrlzz.qms/image_picker';
  static const String methodChannel_package_info =
      'com.szrlzz.qms/package_info';
  static const String methodChannel_path_provider =
      'com.szrlzz.qms/path_provider';

  static const String methodChannel_simple_permissions =
      'com.szrlzz.qms/simple_permissions';
  static const String methodChannel_flutter_bugly =
      'com.szrlzz.qms/flutter_bugly';

  ///不良原因参照
  static const String badReasonRefUrl = '/badReason/findBadReasonRef';

  ///测量工具
  static const String measuringToolRefUrl = '/findMeasuringToolRef';

  static const String value_yes = '1';
  static const String value_no = '0';

  static const String value_y = 'Y';
  static const String value_n = 'N';
}
