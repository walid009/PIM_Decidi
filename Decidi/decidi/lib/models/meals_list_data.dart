class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/Course/spring.png',
      titleTxt: 'Spring',
      kacl: 1,
      meals: <String>['CRUD,', 'Batch,', 'Security'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/Course/swift.jpg',
      titleTxt: 'Swift',
      kacl: 59,
      meals: <String>['MVVM,', 'Auto Layout,', 'swift 5'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/Course/symfony.png',
      titleTxt: 'Symfony',
      kacl: 19,
      meals: <String>['Security:', 'CRUD'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/Course/netCore.png',
      titleTxt: '.NETCORE',
      kacl: 2,
      meals: <String>['CRUD:', 'Security'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
