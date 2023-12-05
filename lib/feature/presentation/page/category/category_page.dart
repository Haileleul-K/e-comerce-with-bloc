import 'package:ecommerce_test/config/device_utils.dart';
import 'package:ecommerce_test/core/app_theam.dart';
import 'package:ecommerce_test/dependency_injection.dart';
import 'package:ecommerce_test/feature/presentation/bloc/categories_bloc/catagories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int selectedIndex = 0;

  @override
  void initState() {
    sl<CatagoriesBloc>().add(GetCatigories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.appbodyColor,
      appBar: PreferredSize(
          child: headerWidget(),
          preferredSize: Size.fromHeight(
            height * 0.1,
          )),
      body: categoryBody(),
    );
  }

  headerWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10.w, top: 40),
      child: Center(
        child: ListTile(
          leading: IconButton(
            onPressed: (){},
          icon: Icon( Icons.arrow_back,
            size: 20.w,
          ),),
          title: Text(
            'Categories',
            style: AppTheme.lightHeadingText(fsize: 20),
          ),
        ),
      ),
    );
  }

  categoryBody() {
    return BlocBuilder<CatagoriesBloc, CatagoriesState>(
      builder: (context, state) {
        return state is CategoriesLoading
            ? Center(child: CircularProgressIndicator.adaptive())
            : state is CategoriesLoaded
                ? GridView.count(
                    padding: EdgeInsets.fromLTRB(20.w, 15, 20, 0),
                    crossAxisCount: 2, // Two columns
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1,
                    children: List.generate(
                      state.categories.data.length,
                      (index) {
                        return InkWell(
                          onTap: () => setState(() {
                            selectedIndex = index;
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              border: selectedIndex == index
                                  ? Border.all(
                                      color: AppTheme.favouriteIconColor)
                                  : null,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.lightOnPrimaryColor
                                        .withOpacity(0.5),
                                    blurRadius: 3.0,
                                    spreadRadius: 1,
                                    offset: Offset(0, 5))
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  customIcons[index],
                                  size: 80,
                                  color: AppTheme.secondaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    state.categories.data[index].name,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox();
      },
    );
  }
}
