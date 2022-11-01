

abstract class Session
{

  final String LOGIN = 'login';
  final String ContainerSl = 'Container Sl';
  final String SealNo = 'Seal No.';
  final String WareHouse = 'Warehouse';
  final String MaterialNo = 'Metarial No.';
  final String Qyt = 'Qyt';
  final String ReelNo = 'Reel No.';
  final String Date = 'Date';
  final String Sl = 'sl';




  void setBool(String name, bool value);
  bool getBool(String name);


  void setString(String name, String value);
  String getString(String name);

  void removeAll();
}

