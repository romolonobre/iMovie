import 'package:flutter/material.dart';
import 'package:imovie_app/app/commons/extensions/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../commons/imovie_ui/iui_buttons.dart';
import '../../../commons/imovie_ui/iui_loader.dart';
import '../../../commons/imovie_ui/iui_text.dart';
import '../../../movie_details/ui/widgets/imdb_review_widget.dart';
import '../../interactor/serie_controller.dart';
import '../../interactor/series_states.dart';

class SerieDetailsContentWidget extends StatelessWidget {
  final String id;

  bool isDetailsScreen;

  SerieDetailsContentWidget({
    super.key,
    required this.id,
    this.isDetailsScreen = false,
  });

  final controller = SerieController();

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.sizeOf(context).width - 60;

    return ValueListenableBuilder(
      valueListenable: controller..getDetails(id),
      builder: (_, state, child) {
        //Loading state
        if (state is SeriesLoadingState) {
          return const IUILoader(size: 20);
        }
        // Error state
        if (state is SeriesErrorState) {
          return IUIText.heading(
            state.message,
            color: Colors.red,
            fontsize: 12,
          );
        }

        if (state is SerieDetailsLoadedState) {
          return Column(
            children: [
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                runSpacing: 2,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IUIText.heading('${state.details.seasons.length} Seasons - '),
                      IUIText.heading('${state.details.releaseDate.getYear()} - '),
                      ImdbReviewWidget(review: state.details.vote)
                    ],
                  ),
                  ...state.details.genres.map(
                    (e) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff242226),
                        ),
                        child: IUIText.heading(
                          e.name,
                          fontsize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ).paddingAll(5),
                      ).paddingAll(3);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  IUIButtons.icon(
                    icon: Icons.add,
                    label: 'Watchlist',
                    width: buttonSize,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      IUIButtons.icon(
                        icon: Icons.play_arrow,
                        label: 'Play',
                        width: buttonSize,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          _launchURL(state.details.homePageLink);
                        },
                      ),
                      IUIText.heading("(External Link)", fontsize: 10, color: Colors.black).paddingOnly(right: 10)
                    ],
                  ),
                ],
              ).paddingOnly(bottom: 10, top: 10)
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _getWidget({required List<Widget> children}) {
    return isDetailsScreen
        ? Column(mainAxisAlignment: MainAxisAlignment.center, children: children)
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
