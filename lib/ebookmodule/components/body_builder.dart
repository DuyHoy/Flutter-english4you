import 'package:flutter/material.dart';
import 'package:sample2/ebookmodule/components/error_widget.dart';
import 'package:sample2/ebookmodule/components/loading_widget.dart';
import 'package:sample2/ebookmodule/util/enum/api_request_status.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus apiRequestStatus;
  final Widget child;
  final Function reload;

  const BodyBuilder(
      {Key? key,
      required this.apiRequestStatus,
      required this.child,
      required this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return LoadingWidget();
      case APIRequestStatus.unInitialized:
        return LoadingWidget();
      case APIRequestStatus.connectionError:
        return MyErrorWidget(
          refreshCallBack: reload,
          isConnection: true,
        );
      case APIRequestStatus.error:
        return MyErrorWidget(
          refreshCallBack: reload,
          isConnection: false,
        );
      case APIRequestStatus.loaded:
        return child;
      default:
        return LoadingWidget();
    }
  }
}
