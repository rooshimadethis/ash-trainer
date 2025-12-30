// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AIRequestImpl _$$AIRequestImplFromJson(Map<String, dynamic> json) =>
    _$AIRequestImpl(
      systemPrompt: json['systemPrompt'] as String,
      taskPrompt: json['taskPrompt'] as String,
      context: json['context'] as Map<String, dynamic>,
      responseSchema: json['responseSchema'] as Map<String, dynamic>?,
      tools: (json['tools'] as List<dynamic>?)
          ?.map((e) => FunctionDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AIRequestImplToJson(_$AIRequestImpl instance) =>
    <String, dynamic>{
      'systemPrompt': instance.systemPrompt,
      'taskPrompt': instance.taskPrompt,
      'context': instance.context,
      'responseSchema': instance.responseSchema,
      'tools': instance.tools,
    };

_$FunctionDeclarationImpl _$$FunctionDeclarationImplFromJson(
        Map<String, dynamic> json) =>
    _$FunctionDeclarationImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      parameters: json['parameters'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$FunctionDeclarationImplToJson(
        _$FunctionDeclarationImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'parameters': instance.parameters,
    };
