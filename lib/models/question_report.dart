import 'package:json_annotation/json_annotation.dart';
part 'question_report.g.dart';

@JsonSerializable()
class QuestionReport {
  final int? question_report_id;
  final int? user_id;
  final int question_id;
  final DateTime? report_date;
  final String report;

  QuestionReport(
      {required this.question_id,
      this.user_id,
      required this.report,
      this.question_report_id,
      this.report_date});

  factory QuestionReport.fromJson(Map<String, dynamic> json) =>
      _$QuestionReportFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionReportToJson(this);
}
