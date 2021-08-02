import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:wall_hunt/service/response/model/featured_model.dart';
import 'package:wall_hunt/utils/app_color.dart';
import 'package:wall_hunt/utils/ui_utils.dart';

class PostAdapter extends StatelessWidget {
  final WallsModel featuredModel;

  const PostAdapter({this.featuredModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.symmetric(vertical: UIUtils().getProportionalWidth(5)),
        color: AppColor.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: UIUtils().getProportionalWidth(40)),
                  child: FancyShimmerImage(
                    imageUrl: featuredModel.downloadLinks.thumbnail,
                    width: double.infinity,
                    height: 400,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: UIUtils().getProportionalWidth(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl: featuredModel.artistAvatar,
                            height: UIUtils().getProportionalWidth(70),
                            width: UIUtils().getProportionalWidth(70),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: UIUtils().getProportionalWidth(12),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            featuredModel.artistName,
                            style: UIUtils().getTextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            featuredModel.location,
                            style: UIUtils().getTextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColor.orGreyColor),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: UIUtils().getProportionalWidth(18),
                vertical: UIUtils().getProportionalWidth(15),
              ),
              child: Text(
                featuredModel.title,
                style: UIUtils().getTextStyle(
                  fontSize: 15,
                  color: AppColor.lightTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Divider(
              color: AppColor.textFieldBorderColor,
              height: 0,
            ),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UIUtils().getProportionalWidth(18),
                  vertical: UIUtils().getProportionalWidth(15),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: AppColor.orGreyColor,
                    ),
                    SizedBox(
                      width: UIUtils().getProportionalWidth(10),
                    ),
                    Text(
                      featuredModel.likes,
                      style: UIUtils().getTextStyle(
                        fontSize: 15,
                        color: AppColor.orGreyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )),
            Container(
              height: UIUtils().getProportionalWidth(15),
              color: AppColor.textFieldBorderColor,
            )
          ],
        ));
  }
}
