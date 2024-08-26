class MyReferralsModel {
  String name;
  String email;
  int contactNumber;
  String date;
  String signUpStatus;
  MyReferralsModel({
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.date,
    required this.signUpStatus,
  });

  static List<MyReferralsModel> modelList = [
    MyReferralsModel(
      name: "Alex Smith",
      email: "abc@example.com",
      contactNumber: 342423324234,
      date: "05 May 2022",
      signUpStatus: "signup",
    ),
    MyReferralsModel(
      name: "Bret Lee",
      email: "abc@example.com",
      contactNumber: 342423324234,
      date: "05 May 2022",
      signUpStatus: "signup",
    ),
    MyReferralsModel(
      name: "Altamash",
      email: "abc@example.com",
      contactNumber: 342423324234,
      date: "05 May 2022",
      signUpStatus: "signup",
    ),
    MyReferralsModel(
      name: "John Lee",
      email: "abc@example.com",
      contactNumber: 342423324234,
      date: "05 May 2022",
      signUpStatus: "signup",
    ),
  ];
}
