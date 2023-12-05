import 'package:ecommerce_test/config/device_utils.dart';
import 'package:ecommerce_test/core/app_theam.dart';
import 'package:ecommerce_test/core/util/storage_helper.dart';
import 'package:ecommerce_test/custom_icons_icons.dart';
import 'package:ecommerce_test/dependency_injection.dart';
import 'package:ecommerce_test/feature/data/model/latest_products.dart';
import 'package:ecommerce_test/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_test/feature/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:ecommerce_test/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

void getUserData() async {
  String? token = await sl<LocalStorageService>().getStringFromDisk('token');
  sl<AuthBloc>().add(GetUserData(token: token ?? ''));
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    sl<HomeBloc>().add(GetLatestProducts());
    getUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor:  AppTheme.appbodyColor,
        appBar: PreferredSize(
            child: headerWidget(),
            preferredSize: Size.fromHeight(height * 0.2)),
        body: Container(
            
            height: height,
            margin: EdgeInsets.only(left: 20,),
            child: Column(
              children: [
                categoryList(),
                latestProducts(),
              ],
            )),
      ),
    );
  }

  headerWidget() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return (state is UserDataLoading)
            ? Container(
                child: Center(child: CircularProgressIndicator.adaptive()),
              )
            : (state is UserDataLoaded)
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    padding: EdgeInsets.symmetric(horizontal:20,vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0.h),
                          child: Text(
                            'Good Morning,',
                            style: AppTheme.lightBodyText(false, fsize: 18),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              bottom: 2,
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Text(
                                state.userData.data.name == ''
                                    ? 'No name'
                                    : state.userData.data.name,
                                style: AppTheme.lightHeadingText(fsize: 20),
                              ),
                              trailing: Icon(
                                Icons.notifications,
                                color: Colors.black,
                              ),
                            )),
                      ],
                    ))
                : SizedBox();
      },
    );
  }

  categoryList() {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          contentPadding: EdgeInsets.only(right: 20),
          leading:
              Text('Categories', style: AppTheme.lightHeadingText(fsize: 16)),
          trailing: 
    Icon( Icons.arrow_forward,
            color: Colors.black,
            size: 30.h,
          ),),
        
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: ListView.builder(
            itemCount: customIcons.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                height: 73.h,
                width: 93.h,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                // padding: EdgeInsets.symmetric(horizontal: 26.h,vertical: 17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.lightOnPrimaryColor.withOpacity(0.5),
                          blurRadius: 5.0,
                          spreadRadius: 3,
                          offset: Offset(0, 0))
                    ],
                    color: Colors.white),

                child: Center(
                    child: Icon(
                  customIcons[index],
                  size: 60,
                  color: AppTheme.categoryIconColor,
                )),
              );
            },
          ),
        ),
      ]),
    );
  }

  latestProducts() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text('Latest Products',
                      style: AppTheme.lightHeadingText(fsize: 18)),
                ),
                (state is HomeLoading)
                    ? CircularProgressIndicator.adaptive()
                    : (state is HomeLoaded)
                        ? Flexible(
                            child: GridView.count(
                              crossAxisCount: 2, // Two columns
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 150 / 200,
                              children: List.generate(
                                state.latestProductsResponse.data.length,
                                (index) {
                                  return singleProductDetail(
                                      state.latestProductsResponse.data[index]);
                                },
                              ),
                            ),
                          )
                        : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  singleProductDetail(Product singleProduct) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          height: 400,
          width: 150,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.lightOnPrimaryColor.withOpacity(0.5),
                          blurRadius: 2.0,
                          spreadRadius: 1,
                          offset: Offset(0, 0))
            ],
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Stack(         
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                 
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r)),
                ),
                child: Image.asset('assets/images/demo.png'), ///needs to be network image
                height: 120.h,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(top: 125.h, left: 5),
                child: Text(
                  singleProduct.name,
                  style: AppTheme.lightHeadingText(fsize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:180, left: 10.h, right: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Text(
                    '\$ ${singleProduct.singleDeal.originalPrice.toString()}',
                    style: AppTheme.lightHeadingText(fsize: 16),
                  ),
                  trailing: Text('Add to cart',style: TextStyle(color: AppTheme.favouriteIconColor),),
                ),
              ),
            Positioned(
              top: 10,
              left: 10,
              child:  Icon(Icons.favorite,size : 30,color: singleProduct.favorite?AppTheme.favouriteIconColor:AppTheme.lightOnPrimaryColor,)),
            ],
          ),
        );
      },
    );
  }
}
