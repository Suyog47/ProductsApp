import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/constants/constants.dart';
import 'package:products/controllers/basic_controllers.dart';
import 'package:products/controllers/user_controller.dart';
import 'package:products/custom_class/navigations.dart';
import 'package:products/firebase_services/crud_service.dart';
import 'package:products/widgets/cards.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _userController = Get.put(UserController(), tag: "user_controller");
  final _basicController = Get.put(BasicController(), tag: "basic_controller");
  int listLength;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    CrudService().prodStream();
    _refreshController.refreshCompleted();
  }

  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (_basicController.lmt.value < listLength) {
        _basicController.limitIncrement();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartRefresher(
        enablePullDown: true,
        physics: BouncingScrollPhysics(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: WaterDropMaterialHeader(),
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: Text(
              "Your Products",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            toolbarHeight: 70,
            backgroundColor: darkBlueColor,
            centerTitle: true,
            actions: [
              InkWell(
                  onTap: () => _userController.logout(),
                  child: Icon(Icons.power_settings_new, color: redColor)),
              width10,
              width5,
            ],
          ),
          body: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: CrudService().prodStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading..."));
                  }
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image(
                                  image: AssetImage("assets/no-data.png")),
                            ),
                            height10,
                            Text("No Products Found", style: TextStyle(letterSpacing: 1, fontSize: 15))
                          ],
                        ));
                  }
                  listLength = snapshot.data.docs.length;
                  return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Obx(() => StaggeredGridView.countBuilder(
                          controller: controller,
                          crossAxisCount: 4,
                          physics: BouncingScrollPhysics(),
                          itemCount: (listLength > _basicController.lmt.value)
                              ? _basicController.lmt.value
                              : listLength,
                          itemBuilder: (BuildContext context, int index) {
                            return HomeCard(str: snapshot.data.docs[index]);
                          },
                          staggeredTileBuilder: (int index)  =>
                              new StaggeredTile.fit(2),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0)));
                }),
          ),
          floatingActionButton: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35), color: darkBlueColor),
            child: RawMaterialButton(
                onPressed: () {
                  Navigate().toAddImage(context);
                },
                child: Icon(
                  Icons.add,
                  color: whiteColor,
                  size: 30,
                )),
          ),
        ),
      ),
    );
  }
}
