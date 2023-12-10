import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newsapp/ui/bloc/news_bloc.dart';
import 'package:flutter_newsapp/ui/bloc/news_event.dart';
import 'package:flutter_newsapp/ui/bloc/news_state.dart';
import 'package:flutter_newsapp/ui/views/home/widgets/headlines_widgets.dart';
import 'package:flutter_newsapp/ui/views/home/widgets/home_app_bar_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../custom_files/app_colors.dart';
import 'helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(NewsHeadlinesFetchEvent('bbc-news'));
    context.read<NewsBloc>().add(NewsCategoriesFetchEvent('general'));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar:
          PreferredSize(preferredSize: Size(0, 59), child: HomeAppBarWidget()),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (BuildContext context, state) {
                switch (state.status) {
                  case Status.initial:
                    return const Center(
                      child: SpinKitCircle(
                        color: AppColors.blue,
                        size: 50,
                      ),
                    );
                  case Status.success:
                    return ListView.builder(
                      itemCount: state.newsList!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        String dt = dateTimeParse(
                            state.newsList!.articles![index].publishedAt ?? "");
                        return HeadlinesWidget(dateAndTime: dt, index: index);
                      },
                    );
                  case Status.failure:
                    return Text(state.message);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (BuildContext context, state) {
                final item = state.categoryNewsList?.articles;
                switch (state.status) {
                  case Status.initial:
                    return const Center(
                      child: SpinKitCircle(
                        color: AppColors.blue,
                        size: 50,
                      ),
                    );
                  case Status.success:
                    return ListView.builder(
                      itemCount: item?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String dt =
                            dateTimeParse(item![index].publishedAt ?? "");
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  item[index].urlToImage ?? "",
                                  fit: BoxFit.cover,
                                  height: height * .18,
                                  width: width * .3,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
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
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    );
                                  },
                                ),
                                // child: CachedNetworkImage(
                                //   imageUrl: item[index].urlToImage ?? "",
                                //   fit: BoxFit.cover,
                                //   height: height * .18,
                                //   width: width * .3,
                                //   placeholder: (context, url) => Container(
                                //     child: const Center(
                                //       child: SpinKitCircle(
                                //         color: AppColors.blue,
                                //         size: 50,
                                //       ),
                                //     ),
                                //   ),
                                //   errorWidget: (context, url, error) =>
                                //       const Icon(
                                //     Icons.error_outline,
                                //     color: Colors.red,
                                //   ),
                                // ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height * .18,
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        item[index].title ?? "",
                                        maxLines: 3,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item[index].source!.name ?? "",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            dt,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  case Status.failure:
                    return Text(state.message.toString());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
