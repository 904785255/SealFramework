
import 'package:onepartner/library_import.dart';
import 'package:onepartner/page/error_page.dart';

import 'package:onepartner/config/dependencies.dart';
import 'application.dart';

class AppInit {
  static void main(){
    catchException((){
      run();
    });
  }
  static void run(){
    WidgetsFlutterBinding.ensureInitialized();
    runApp(
      MultiProvider(
        providers: Dependencies.providersLocal,
        child: Application(),
      ),
    );




  }

  static void catchException<T>(T callback()){
    FlutterError.onError = (FlutterErrorDetails details) {
      reportErrorAndLog(details);
    };
    runZonedGuarded(() async {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
        return ErrorPage(details);
      };
      callback();
    }, 
    (error, stackTrace){
      var details = createFlutterErrorDetails(error, stackTrace,null);
      reportErrorAndLog(details);
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(parent, zone, line);
      },
    ),
    );
  }
  static void collectLog(ZoneDelegate parent, Zone zone, String line){
    parent.print(zone, "日志拦截: $line");
  }
  static void reportErrorAndLog(FlutterErrorDetails details) {
    print("上报错误和日志逻辑: $details");
  }
  static FlutterErrorDetails createFlutterErrorDetails(
    Object error,
    StackTrace stackTrace,
    InformationCollector? informationCollector,
  ) {
    print("未捕获的异常: $error  $stackTrace");
    return FlutterErrorDetails(
      exception: error,
      stack: stackTrace,
      informationCollector: informationCollector,
    );
  }


}