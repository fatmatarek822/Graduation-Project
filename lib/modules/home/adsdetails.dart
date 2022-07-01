import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/post_model.dart';
import 'package:realestateapp/models/user_model.dart';
import 'package:realestateapp/modules/chat/chatdetails.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/setting/userprofile.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class Ads_Details extends StatefulWidget {
  PostModel? model;

  Ads_Details({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<Ads_Details> createState() => _Ads_DetailsState();
}

class _Ads_DetailsState extends State<Ads_Details> {
  UserModel? usermodel;

  var ADSController = PageController();

  void chatwithOwner(context) {
    if (AppCubit.get(context).users == usermodel!.uid) {
      for (var i = 0; i > AppCubit.get(context).users.length; i++) {
        print(AppCubit.get(context).users[i]);
        navigateTo(context,
            ChatDetailsScreen(userModel: AppCubit.get(context).users[i]));

        print('=================================');
        print('successs');
      }
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppAddToFavoritesSuccessState) {
          showToast(
              text: 'favorite added successfully '.tr().toString(),
              state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        var usermodel = AppCubit.get(context).userModel;
        var postmodel = AppCubit.get(context).postModel;

        return Scaffold(
          appBar: AppBar(
            title: Text('Ads Details'.tr().toString()),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: [
                  builditems(widget.model!, usermodel!, context),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            onPressed: () {
                              // navigateTo(context,
                              //     ChatDetailsScreen(userModel: usermodel));
                              //  },
                              // chatwithOwner(context);
                            },
                            child: Row(
                              children:  [
                                const Icon(Icons.email,
                                  color: Colors.greenAccent,
                                ),
                                Text(' Email'.tr().toString()) ,
                              ],
                            )),
                        const SizedBox(
                          width: 5.0,
                        ),
                        MaterialButton(
                          onPressed: () {
                            AppCubit.get(context).whatsAppOpen(
                                usermodel.phone!);
                          },
                          child: Row(
                            children:  [
                              const Icon(Icons.whatsapp_sharp,
                                color: Colors.greenAccent,
                              ),
                              Text(' whatsapp'.tr().toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              launch('tel:01097442188');
            },
            child: const Icon(Icons.phone),
          ),
        );
      },
    );
  }

  Widget builditems(
    PostModel model,
    UserModel userModel,
    context,
  ) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                width: double.infinity,
                height: 300.0,
                child: PageView.builder(
                  controller: ADSController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Image(
                    image: NetworkImage('${model.postImage![index]}'),
                    width: double.infinity,
                    height: 120.0,
                  ),
                  itemCount: model.postImage!.length,
                ),
              ),
              Positioned(
                right: appPadding / 2,
                top: appPadding / 2,
                child: Container(
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                      icon: AppCubit.get(context).favorites.length == 0
                          ? const Icon(
                              Icons.favorite_rounded,
                            )
                     :  const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        var index =0;
                        AppCubit.get(context).favorites.length == 0
                            ? AppCubit.get(context).addtofav(
                                AppCubit.get(context).posts[index],
                                AppCubit.get(context).postsId[index],
                              )  //the errro cause of null index  should br solved
                            : showToast(
                                text: 'Aleardy Added'.tr().toString(),
                                state: ToastStates.WARNING);
                      },
                    )),
              ),
              SmoothPageIndicator(
                controller: ADSController,
                count: model.postImage!.length,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.0,
                  activeDotColor: Colors.greenAccent,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Report',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(Icons.widgets_outlined),
              Text(
                ' Type '.tr().toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '${model.type}',
              ),
            ]),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Icon(
                Icons.king_bed_outlined,
              ),
              Text(
                ' Number of room'.tr().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '${model.no_of_room}',
              ),
            ]),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Icon(
                Icons.bathtub_outlined,
              ),
              Text(
                ' Number of bathroom'.tr().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '${model.no_of_bathroom}',
              ),
            ]),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Icon(
                Icons.area_chart_outlined,
              ),
              Text(
                ' Area'.tr().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '${model.area}',
              ),
            ]),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Icon(
                Icons.house_siding_outlined,
              ),
              const Text(
                ' Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '${model.namePost}',
              ),
            ]),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.description_outlined,
                      ),
                      Text(
                        ' Description'.tr().toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 6,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 90.0,
                    child: Text(
                      '${model.description}',
                      maxLines: 15,
                    ),
                  ),
                ]),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Icon(
                Icons.gps_fixed_rounded,
              ),
              Text(
                ' location'.tr().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Text(
                '${model.place}',
              ),
            ]),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Icon(
                Icons.price_change_outlined,
              ),
              Text(
                ' Price'.tr().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '${model.price}',
              ),
            ]),
          ),
          myDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Icon(
                Icons.category_outlined,
              ),
              Text(
                ' Category Type '.tr().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '${model.category}',
              ),
            ]),
          ),
        ]));
  }
}
