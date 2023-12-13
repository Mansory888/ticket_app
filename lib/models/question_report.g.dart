// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionReport _$QuestionReportFromJson(Map<String, dynamic> json) =>
    QuestionReport(
      question_id: json['question_id'] as int,
      user_id: json['user_id'] as int?,
      report: json['report'] as String,
      question_report_id: json['question_report_id'] as int?,
      report_date: json['report_date'] == null
          ? null
          : DateTime.parse(json['report_date'] as String),
    );

Map<String, dynamic> _$QuestionReportToJson(QuestionReport instance) =>
    <String, dynamic>{
      'question_report_id': instance.question_report_id,
      'user_id': instance.user_id,
      'question_id': instance.question_id,
      'report_date': instance.report_date?.toIso8601String(),
      'report': instance.report,
    };
