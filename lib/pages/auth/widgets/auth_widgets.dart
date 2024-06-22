import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_university_app/state/state.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthWidgets {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Future<Map<String, dynamic>?> getRole(User? user) async {
    CollectionReference userRef = _firebaseFirestore.collection("users");
    var userDoc =
        userRef.doc(user!.email.toString()); //{name: taha, surname:bike}
    var response =
        await userDoc.get() as DocumentSnapshot<Map<String, dynamic>>;
    /* var negelmis = response.data();
    print(negelmis?["rol"]); */
    return response.data();
  }

  Future<Map<String, dynamic>?> getCalendars(String section) async {
    CollectionReference calendarRef =
        _firebaseFirestore.collection("calendars");
    var calendarDoc = calendarRef.doc(section); //{name: taha, surname:bike}
    var response =
        await calendarDoc.get() as DocumentSnapshot<Map<String, dynamic>>;
    return response.data();
  }

  Future<Map<String, dynamic>?> getApiKey() async {
    CollectionReference apiRef = _firebaseFirestore.collection("privacy");
    var apiDoc = apiRef.doc("apikey"); //{name: taha, surname:bike}
    var response = await apiDoc.get() as DocumentSnapshot<Map<String, dynamic>>;
    return response.data();
  }

  Future<Map<String, dynamic>?> getBaseUrl() async {
    CollectionReference baseRef = _firebaseFirestore.collection("privacy");
    var baseDoc = baseRef.doc("baseurl"); //{name: taha, surname:bike}
    var response =
        await baseDoc.get() as DocumentSnapshot<Map<String, dynamic>>;
    return response.data();
  }

  Future<Map<String, dynamic>?> asistanSelector({required String user}) async {
    late String selection = "";
    if (user == "admin") {
      selection = "admin";
    } else {
      selection = "user";
    }
    CollectionReference adminasistanRef =
        _firebaseFirestore.collection("privacy");
    var asDoc = adminasistanRef.doc(selection); //{name: taha, surname:bike}
    var response = await asDoc.get() as DocumentSnapshot<Map<String, dynamic>>;
    return response.data();
  }

  Future<List<String>> getEvents() async {
    CollectionReference<Map<String, dynamic>> eventRef =
        _firebaseFirestore.collection("etkinlikler");

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await eventRef.get();

    List<String> urls = [];
    querySnapshot.docs.forEach((doc) {
      // Assuming the URL is stored under a field called "url"
      String? url = doc.data()["url"];
      if (url != null) {
        urls.add(url);
      }
    });

    return urls;
  }

  Future<List<Map<String, dynamic>>> getNews() async {
    CollectionReference<Map<String, dynamic>> newsRef =
        _firebaseFirestore.collection("haberler");

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await newsRef.get();

    List<Map<String, dynamic>> news = [];
    querySnapshot.docs.forEach((doc) {
      news.add(doc.data());
    });

    return news;
  }

  Future<List<Map<String, dynamic>>> getAnnounces() async {
    CollectionReference<Map<String, dynamic>> announcesRef =
        _firebaseFirestore.collection("anons");

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await announcesRef.get();

    List<Map<String, dynamic>> announces = [];
    querySnapshot.docs.forEach((doc) {
      announces.add(doc.data());
    });

    return announces;
  }

  Text loginTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: CustomColors.white),
    );
  }

  Text greyTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: CustomColors.grey),
    );
  }

  Container topImageContainer(String image) {
    return Container(
      height: 300,
      width: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
        ),
      ),
    );
  }

  Widget bottomImageContainer(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Container(
        height: 70,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }

  Widget bottomImageContainerLink(String image, Uri link) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          launchUrl(link, mode: LaunchMode.inAppWebView);
        },
        child: Container(
          height: 170,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField({required TextEditingController emailController}) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.mintGreen,
          border: Border.all(color: CustomColors.white),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextField(
          obscureText: false,
          controller: emailController,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            suffixIcon:
                Icon(UniconsLine.envelope, color: CustomColors.darkPurple),
            border: InputBorder.none,
            hintText: "Email",
            hintStyle: TextStyle(color: CustomColors.grey),
          ),
        ),
      ),
    );
  }
}

class passwordField extends StatelessWidget {
  final StateManage vm = StateManage();
  passwordField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        decoration: BoxDecoration(
            color: CustomColors.mintGreen,
            border: Border.all(color: CustomColors.white),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            obscureText: vm.obscureText,
            controller: passwordController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    vm.obscureText ? UniconsLine.eye_slash : UniconsLine.eye,
                    color: CustomColors.darkPurple,
                  ),
                  onPressed: () => vm.showHide()),
              border: InputBorder.none,
              hintText: "Şifre",
              hintStyle: const TextStyle(color: CustomColors.grey),
            ),
          ),
        ),
      );
    });
  }
}

class SignIn extends StatelessWidget {
  final StateManage vm = StateManage();
  SignIn({
    Key? key,
    required this.passwordController,
    required this.emailController,
  }) : super(key: key);
  final TextEditingController passwordController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(color: CustomColors.mintGreen),
              ),
            ),
            backgroundColor:
                const WidgetStatePropertyAll(CustomColors.transparent)),
        onPressed: () {
          vm.checkEmail(emailController: emailController);

          if (vm.isIstunEmail == true) {
            vm.signInWithEmailAndPassword(
                emailController: emailController,
                passwordController: passwordController);
          } else {
            //  print("istun maili gir");
            Utils.showSnackBar("Lütfen Istün Mailinizi Giriniz");
            //  Navigator.of(context).pop();
          }
        },
        child: const Center(
          child: Text(
            "Giriş Yap",
            style: TextStyle(color: CustomColors.mintGreen),
          ),
        ),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  final StateManage vm = StateManage();

  SignUp({
    Key? key,
    required this.passwordController,
    required this.emailController,
  });

  final TextEditingController passwordController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(color: CustomColors.mintGreen),
              ),
            ),
            backgroundColor:
                const WidgetStatePropertyAll(CustomColors.transparent)),
        onPressed: () {
          vm.checkEmail(emailController: emailController);

          if (vm.isIstunEmail == true) {
            vm.createUserWithEmailAndPassword(
                context: context,
                emailController: emailController,
                passwordController: passwordController);
          } else {
            Utils.showSnackBar("Lütfen Istün Mailinizle Kayıt Olunuz");
          }
        },
        child: const Center(
          child: Text(
            "Kayıt Ol",
            style: TextStyle(color: CustomColors.mintGreen),
          ),
        ),
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  final StateManage vm = StateManage();
  ForgotPassword({
    Key? key,
    required this.emailController,
  }) : super(key: key);
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(color: CustomColors.mintGreen),
              ),
            ),
            backgroundColor:
                const WidgetStatePropertyAll(CustomColors.transparent)),
        onPressed: () {
          vm.checkEmail(emailController: emailController);

          if (vm.isIstunEmail == true) {
            vm.resetPassword(
                emailController: emailController, context: context);
          } else {
            Utils.showSnackBar("Lütfen Istün Mailinizi Giriniz");
          }
        },
        child: const Center(
          child: Text(
            "Şifreyi Sıfırla",
            style: TextStyle(color: CustomColors.mintGreen),
          ),
        ),
      ),
    );
  }
}
