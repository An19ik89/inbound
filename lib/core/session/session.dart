

abstract class Session
{

  final String LOGIN = 'login';
  final String SCANNER = 'scanner';
  final String defaut_user = 'tarzan';
  final String default_password = 'tarzan1234';
  final String default_db = 'db123456';
  final String USER = 'USER';
  final String PASSWORD = 'PASSWORD';
  final String ASSIGN_WORKER = 'ASSIGN WORKER';


  final String ContainerSl = 'Container Sl';
  final String SealNo = 'Seal No.';
  final String WareHouse = 'Warehouse';
  final String MaterialNo = 'Metarial No.';
  final String Qyt = 'Qyt';
  final String ReelNo = 'Reel No.';
  final String Date = 'Date';
  final String Sl = 'Sl';




  void setBool(String name, bool value);
  bool getBool(String name);


  void setString(String name, String value);
  String getString(String name);

  void setLoginUser( String value);
  String getLoginUser();

  void setLoginPassword( String value);
  String getLoginPassword();

  void setAssignWorker( String value);
  String getAssignWorker();

  void removeAll();
}

