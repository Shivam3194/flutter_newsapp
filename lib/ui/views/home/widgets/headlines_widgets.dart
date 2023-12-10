import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newsapp/ui/bloc/news_bloc.dart';
import 'package:flutter_newsapp/ui/bloc/news_state.dart';
import 'package:flutter_newsapp/ui/views/home/home_screen.dart';
import 'package:flutter_newsapp/ui/views/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../custom_files/app_colors.dart';

class HeadlinesWidget extends StatelessWidget {
  final String dateAndTime;
  final int index;
  const HeadlinesWidget({
    super.key,
    required this.dateAndTime,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      final item = state.newsList!.articles;
      return InkWell(
        onTap: () {
          String newsImage = state.newsList!.articles![index].urlToImage!;
          String newsTitle = state.newsList!.articles![index].title!;
          String newsDate = state.newsList!.articles![index].publishedAt!;
          String newsAuthor = state.newsList!.articles![index].author!;
          String newsDesc = state.newsList!.articles![index].description!;
          String newsContent = state.newsList!.articles![index].content!;
          String newsSource = state.newsList!.articles![index].source!.name!;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(
                      newsImage,
                      newsTitle,
                      newsDate,
                      newsAuthor,
                      newsDesc,
                      newsContent,
                      newsSource)));
        },
        child: SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: height * 0.6,
                width: width * .9,
                padding: EdgeInsets.symmetric(horizontal: height * .02),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    item![index].urlToImage ?? "",
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: SpinKitCircle(
                            color: AppColors.blue,
                            size: 50,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      );
                    },
                  ),
                  // child: CachedNetworkImage(
                  //   imageUrl: item![index].urlToImage ?? "",
                  //   fit: BoxFit.cover,
                  //   placeholder: (context, url) => Container(
                  //     child: spinKit2,
                  //   ),
                  //   errorWidget: (context, url, error) => const Icon(
                  //     Icons.error_outline,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(15),
                    height: height * .22,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width * .7,
                          child: Text(
                            item[index].title ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item[index].source!.name ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                dateAndTime,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
