-module(piqi_piqi).
-compile(export_all).

-include_lib("piqi/include/piqirun.hrl").
-include("piqi_piqi.hrl").

-spec gen_piq_word/2 :: (Code :: piqirun_code(), X :: string() | binary()) -> iolist().
gen_piq_word(Code, X) ->
    piqirun:string_to_block(Code, X).

-spec gen_string/2 :: (Code :: piqirun_code(), X :: string() | binary()) -> iolist().
gen_string(Code, X) ->
    piqirun:string_to_block(Code, X).

-spec gen_int32/2 :: (Code :: piqirun_code(), X :: integer()) -> iolist().
gen_int32(Code, X) ->
    piqirun:integer_to_zigzag_varint(Code, X).


packed_gen_int32(X) ->
    piqirun:integer_to_packed_zigzag_varint(X).

-spec gen_piq_any/2 :: (Code :: piqirun_code(), X :: piqi_any()) -> iolist().
gen_piq_any(Code, X) ->
    gen_piqi_any(Code, X).

-spec gen_int64/2 :: (Code :: piqirun_code(), X :: integer()) -> iolist().
gen_int64(Code, X) ->
    piqirun:integer_to_zigzag_varint(Code, X).


packed_gen_int64(X) ->
    piqirun:integer_to_packed_zigzag_varint(X).

-spec gen_uint64/2 :: (Code :: piqirun_code(), X :: non_neg_integer()) -> iolist().
gen_uint64(Code, X) ->
    piqirun:non_neg_integer_to_varint(Code, X).


packed_gen_uint64(X) ->
    piqirun:non_neg_integer_to_packed_varint(X).

-spec gen_float/2 :: (Code :: piqirun_code(), X :: number()) -> iolist().
gen_float(Code, X) ->
    piqirun:float_to_fixed64(Code, X).


packed_gen_float(X) ->
    piqirun:float_to_packed_fixed64(X).

-spec gen_bool/2 :: (Code :: piqirun_code(), X :: boolean()) -> iolist().
gen_bool(Code, X) ->
    piqirun:boolean_to_varint(Code, X).


packed_gen_bool(X) ->
    piqirun:boolean_to_packed_varint(X).

-spec gen_binary/2 :: (Code :: piqirun_code(), X :: binary()) -> iolist().
gen_binary(Code, X) ->
    piqirun:binary_to_block(Code, X).

-spec gen_word/2 :: (Code :: piqirun_code(), X :: word()) -> iolist().
gen_word(Code, X) ->
    gen_piq_word(Code, X).

-spec gen_wire_type/2 :: (Code :: piqirun_code(), X :: wire_type()) -> iolist().
gen_wire_type(Code, X) ->
    piqirun:integer_to_signed_varint(Code,
        case X of
            varint -> 329594984;
        zigzag_varint -> 99211597;
        fixed32 -> 136997651;
        fixed64 -> 136998322;
        signed_varint -> 441915897;
        signed_fixed32 -> 488499298;
        signed_fixed64 -> 488499969;
        block -> 352089421
        end
    ).


packed_gen_wire_type(X) ->
    piqirun:integer_to_packed_signed_varint(
        case X of
            varint -> 329594984;
        zigzag_varint -> 99211597;
        fixed32 -> 136997651;
        fixed64 -> 136998322;
        signed_varint -> 441915897;
        signed_fixed32 -> 488499298;
        signed_fixed64 -> 488499969;
        block -> 352089421
        end
    ).

-spec gen_variant/2 :: (Code :: piqirun_code(), X :: variant()) -> iolist().
gen_variant(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_optional_field(31586877, fun gen_string/2, X#variant.erlang_name),
        piqirun:gen_optional_field(139663632, fun gen_string/2, X#variant.proto_name),
        piqirun:gen_required_field(150958667, fun gen_name/2, X#variant.name),
        piqirun:gen_repeated_field(192598901, fun gen_option/2, X#variant.option),
        piqirun:gen_repeated_field(405875126, fun gen_string/2, X#variant.proto_custom),
        piqirun:gen_optional_field(515275216, fun gen_string/2, X#variant.json_name)
    ]).

-spec gen_typed/2 :: (Code :: piqirun_code(), X :: typed()) -> iolist().
gen_typed(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_required_field(218690234, fun gen_word/2, X#typed.type),
        piqirun:gen_required_field(297303921, fun gen_piqi_any/2, X#typed.value)
    ]).

-spec gen_type/2 :: (Code :: piqirun_code(), X :: type()) -> iolist().
gen_type(Code, X) ->
    piqirun:gen_variant(Code,
        case X of
            {name, Y} -> gen_name(150958667, Y);
            {piq_record, _} -> gen_piqtype(170743570, X);
            {variant, _} -> gen_piqtype(170743570, X);
            {enum, _} -> gen_piqtype(170743570, X);
            {alias, _} -> gen_piqtype(170743570, X);
            {piq_list, _} -> gen_piqtype(170743570, X);
            int -> gen_piqtype(170743570, X);
            float -> gen_piqtype(170743570, X);
            bool -> gen_piqtype(170743570, X);
            string -> gen_piqtype(170743570, X);
            binary -> gen_piqtype(170743570, X);
            text -> gen_piqtype(170743570, X);
            word -> gen_piqtype(170743570, X);
            any -> gen_piqtype(170743570, X)
        end
    ).

-spec gen_piq_record/2 :: (Code :: piqirun_code(), X :: piq_record()) -> iolist().
gen_piq_record(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_repeated_field(9671866, fun gen_field/2, X#piq_record.field),
        piqirun:gen_optional_field(31586877, fun gen_string/2, X#piq_record.erlang_name),
        piqirun:gen_optional_field(139663632, fun gen_string/2, X#piq_record.proto_name),
        piqirun:gen_required_field(150958667, fun gen_name/2, X#piq_record.name),
        piqirun:gen_repeated_field(405875126, fun gen_string/2, X#piq_record.proto_custom),
        piqirun:gen_optional_field(515275216, fun gen_string/2, X#piq_record.json_name)
    ]).

-spec gen_piqtype/2 :: (Code :: piqirun_code(), X :: piqtype()) -> iolist().
gen_piqtype(Code, X) ->
    piqirun:gen_variant(Code,
        case X of
            {piq_record, _} -> gen_piqdef(134785133, X);
            {variant, _} -> gen_piqdef(134785133, X);
            {enum, _} -> gen_piqdef(134785133, X);
            {alias, _} -> gen_piqdef(134785133, X);
            {piq_list, _} -> gen_piqdef(134785133, X);
            int -> piqirun:gen_bool_field(5246191, true);
            float -> piqirun:gen_bool_field(43435420, true);
            bool -> piqirun:gen_bool_field(18580522, true);
            string -> piqirun:gen_bool_field(288368849, true);
            binary -> piqirun:gen_bool_field(218872833, true);
            text -> piqirun:gen_bool_field(217697453, true);
            word -> piqirun:gen_bool_field(251462090, true);
            any -> piqirun:gen_bool_field(4848364, true)
        end
    ).

-spec gen_piqi/2 :: (Code :: piqirun_code(), X :: piqi()) -> iolist().
gen_piqi(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_optional_field(13841580, fun gen_word/2, X#piqi.module),
        piqirun:gen_optional_field(19040580, fun gen_erlang_string_type/2, X#piqi.erlang_string_type),
        piqirun:gen_repeated_field(134785133, fun gen_piqdef/2, X#piqi.piqdef),
        piqirun:gen_repeated_field(142778725, fun gen_import/2, X#piqi.import),
        piqirun:gen_optional_field(330902611, fun gen_string/2, X#piqi.erlang_type_prefix),
        piqirun:gen_optional_field(333467105, fun gen_string/2, X#piqi.proto_package),
        piqirun:gen_repeated_field(340962072, fun gen_func/2, X#piqi.func),
        piqirun:gen_repeated_field(405875126, fun gen_string/2, X#piqi.proto_custom),
        piqirun:gen_optional_field(492641566, fun gen_string/2, X#piqi.erlang_module)
    ]).

-spec gen_piqdef/2 :: (Code :: piqirun_code(), X :: piqdef()) -> iolist().
gen_piqdef(Code, X) ->
    piqirun:gen_variant(Code,
        case X of
            {piq_record, Y} -> gen_piq_record(502036113, Y);
            {variant, Y} -> gen_variant(484589701, Y);
            {enum, Y} -> gen_enum(51800833, Y);
            {alias, Y} -> gen_alias(26300816, Y);
            {piq_list, Y} -> gen_piq_list(129178718, Y)
        end
    ).

-spec gen_option/2 :: (Code :: piqirun_code(), X :: option()) -> iolist().
gen_option(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_optional_field(29667629, fun gen_int32/2, X#option.code),
        piqirun:gen_optional_field(31586877, fun gen_string/2, X#option.erlang_name),
        piqirun:gen_optional_field(139663632, fun gen_string/2, X#option.proto_name),
        piqirun:gen_optional_field(150958667, fun gen_name/2, X#option.name),
        piqirun:gen_optional_field(215188758, fun gen_word/2, X#option.getopt_letter),
        piqirun:gen_optional_field(218690234, fun gen_type/2, X#option.type),
        piqirun:gen_optional_field(442330184, fun gen_string/2, X#option.getopt_doc),
        piqirun:gen_optional_field(515275216, fun gen_string/2, X#option.json_name)
    ]).

-spec gen_named/2 :: (Code :: piqirun_code(), X :: named()) -> iolist().
gen_named(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_required_field(150958667, fun gen_name/2, X#named.name),
        piqirun:gen_required_field(297303921, fun gen_ast/2, X#named.value)
    ]).

-spec gen_name/2 :: (Code :: piqirun_code(), X :: name()) -> iolist().
gen_name(Code, X) ->
    gen_word(Code, X).

-spec gen_piq_list/2 :: (Code :: piqirun_code(), X :: piq_list()) -> iolist().
gen_piq_list(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_optional_field(31586877, fun gen_string/2, X#piq_list.erlang_name),
        piqirun:gen_optional_field(139663632, fun gen_string/2, X#piq_list.proto_name),
        piqirun:gen_required_field(150958667, fun gen_name/2, X#piq_list.name),
        piqirun:gen_required_field(218690234, fun gen_type/2, X#piq_list.type),
        piqirun:gen_repeated_field(405875126, fun gen_string/2, X#piq_list.proto_custom),
        piqirun:gen_flag( 422905280 ,  X#piq_list.wire_packed ),
        piqirun:gen_optional_field(515275216, fun gen_string/2, X#piq_list.json_name)
    ]).

-spec gen_import/2 :: (Code :: piqirun_code(), X :: import()) -> iolist().
gen_import(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_required_field(13841580, fun gen_word/2, X#import.module),
        piqirun:gen_optional_field(150958667, fun gen_name/2, X#import.name)
    ]).

-spec gen_function_param/2 :: (Code :: piqirun_code(), X :: function_param()) -> iolist().
gen_function_param(Code, X) ->
    piqirun:gen_variant(Code,
        case X of
            {name, Y} -> gen_name(150958667, Y);
            {record, Y} -> gen_anonymous_record(502036113, Y);
            {variant, Y} -> gen_anonymous_variant(484589701, Y);
            {enum, Y} -> gen_anonymous_enum(51800833, Y);
            {list, Y} -> gen_anonymous_list(129178718, Y)
        end
    ).

-spec gen_func/2 :: (Code :: piqirun_code(), X :: func()) -> iolist().
gen_func(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_optional_field(31586877, fun gen_string/2, X#func.erlang_name),
        piqirun:gen_required_field(150958667, fun gen_name/2, X#func.name),
        piqirun:gen_optional_field(209784577, fun gen_function_param/2, X#func.output),
        piqirun:gen_optional_field(321506248, fun gen_function_param/2, X#func.error),
        piqirun:gen_optional_field(505267210, fun gen_function_param/2, X#func.input)
    ]).

-spec gen_field_mode/2 :: (Code :: piqirun_code(), X :: field_mode()) -> iolist().
gen_field_mode(Code, X) ->
    piqirun:gen_variant(Code,
        case X of
            required -> piqirun:gen_bool_field(308449631, true);
            optional -> piqirun:gen_bool_field(510570400, true);
            repeated -> piqirun:gen_bool_field(274054266, true)
        end
    ).

-spec gen_field/2 :: (Code :: piqirun_code(), X :: field()) -> iolist().
gen_field(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_optional_field(29667629, fun gen_int32/2, X#field.code),
        piqirun:gen_optional_field(31586877, fun gen_string/2, X#field.erlang_name),
        piqirun:gen_optional_field(139663632, fun gen_string/2, X#field.proto_name),
        piqirun:gen_optional_field(140563299, fun gen_field_mode/2, X#field.mode),
        piqirun:gen_optional_field(150958667, fun gen_name/2, X#field.name),
        piqirun:gen_optional_field(215188758, fun gen_word/2, X#field.getopt_letter),
        piqirun:gen_optional_field(218690234, fun gen_type/2, X#field.type),
        piqirun:gen_flag( 422905280 ,  X#field.wire_packed ),
        piqirun:gen_optional_field(442330184, fun gen_string/2, X#field.getopt_doc),
        piqirun:gen_optional_field(465819841, fun gen_piq_any/2, X#field.default),
        piqirun:gen_optional_field(515275216, fun gen_string/2, X#field.json_name)
    ]).

-spec gen_erlang_string_type/2 :: (Code :: piqirun_code(), X :: erlang_string_type()) -> iolist().
gen_erlang_string_type(Code, X) ->
    piqirun:integer_to_signed_varint(Code,
        case X of
            binary -> 218872833;
        list -> 129178718
        end
    ).


packed_gen_erlang_string_type(X) ->
    piqirun:integer_to_packed_signed_varint(
        case X of
            binary -> 218872833;
        list -> 129178718
        end
    ).

-spec gen_enum/2 :: (Code :: piqirun_code(), X :: enum()) -> iolist().
gen_enum(Code, X) ->
    gen_variant(Code, X).

-spec gen_ast_list/2 :: (Code :: piqirun_code(), X :: ast_list()) -> iolist().
gen_ast_list(Code, X) ->
    piqirun:gen_list(Code, fun gen_ast/2, X).

-spec gen_ast/2 :: (Code :: piqirun_code(), X :: ast()) -> iolist().
gen_ast(Code, X) ->
    piqirun:gen_variant(Code,
        case X of
            {int, Y} -> gen_int64(5246191, Y);
            {uint, Y} -> gen_uint64(228983706, Y);
            {float, Y} -> gen_float(43435420, Y);
            {bool, Y} -> gen_bool(18580522, Y);
            {word, Y} -> gen_word(251462090, Y);
            {ascii_string, Y} -> gen_string(90831757, Y);
            {utf8_string, Y} -> gen_string(387197869, Y);
            {binary, Y} -> gen_binary(218872833, Y);
            {text, Y} -> gen_string(217697453, Y);
            {name, Y} -> gen_name(150958667, Y);
            {named, Y} -> gen_named(377786297, Y);
            {type, Y} -> gen_word(218690234, Y);
            {typed, Y} -> gen_typed(449540202, Y);
            {list, Y} -> gen_ast_list(129178718, Y);
            {control, Y} -> gen_ast_list(427912029, Y)
        end
    ).

-spec gen_piqi_any/2 :: (Code :: piqirun_code(), X :: piqi_any()) -> iolist().
gen_piqi_any(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_optional_field(4849474, fun gen_ast/2, X#piqi_any.ast),
        piqirun:gen_optional_field(219565456, fun gen_binary/2, X#piqi_any.binobj)
    ]).

-spec gen_anonymous_variant/2 :: (Code :: piqirun_code(), X :: anonymous_variant()) -> iolist().
gen_anonymous_variant(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_repeated_field(192598901, fun gen_option/2, X#anonymous_variant.option)
    ]).

-spec gen_anonymous_record/2 :: (Code :: piqirun_code(), X :: anonymous_record()) -> iolist().
gen_anonymous_record(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_repeated_field(9671866, fun gen_field/2, X#anonymous_record.field)
    ]).

-spec gen_anonymous_list/2 :: (Code :: piqirun_code(), X :: anonymous_list()) -> iolist().
gen_anonymous_list(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_required_field(218690234, fun gen_type/2, X#anonymous_list.type)
    ]).

-spec gen_anonymous_enum/2 :: (Code :: piqirun_code(), X :: anonymous_enum()) -> iolist().
gen_anonymous_enum(Code, X) ->
    gen_anonymous_variant(Code, X).

-spec gen_alias/2 :: (Code :: piqirun_code(), X :: alias()) -> iolist().
gen_alias(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_optional_field(9699074, fun gen_wire_type/2, X#alias.wire_type),
        piqirun:gen_optional_field(31586877, fun gen_string/2, X#alias.erlang_name),
        piqirun:gen_optional_field(99318444, fun gen_string/2, X#alias.erlang_type),
        piqirun:gen_optional_field(139663632, fun gen_string/2, X#alias.proto_name),
        piqirun:gen_required_field(150958667, fun gen_name/2, X#alias.name),
        piqirun:gen_optional_field(207395199, fun gen_string/2, X#alias.proto_type),
        piqirun:gen_required_field(218690234, fun gen_type/2, X#alias.type),
        piqirun:gen_optional_field(515275216, fun gen_string/2, X#alias.json_name)
    ]).

-spec gen_piq_word/1 :: (X :: string() | binary()) -> iolist().
gen_piq_word(X) ->
    gen_piq_word('undefined', X).

-spec gen_string/1 :: (X :: string() | binary()) -> iolist().
gen_string(X) ->
    gen_string('undefined', X).

-spec gen_int32/1 :: (X :: integer()) -> iolist().
gen_int32(X) ->
    gen_int32('undefined', X).

-spec gen_piq_any/1 :: (X :: piqi_any()) -> iolist().
gen_piq_any(X) ->
    gen_piq_any('undefined', X).

-spec gen_int64/1 :: (X :: integer()) -> iolist().
gen_int64(X) ->
    gen_int64('undefined', X).

-spec gen_uint64/1 :: (X :: non_neg_integer()) -> iolist().
gen_uint64(X) ->
    gen_uint64('undefined', X).

-spec gen_float/1 :: (X :: number()) -> iolist().
gen_float(X) ->
    gen_float('undefined', X).

-spec gen_bool/1 :: (X :: boolean()) -> iolist().
gen_bool(X) ->
    gen_bool('undefined', X).

-spec gen_binary/1 :: (X :: binary()) -> iolist().
gen_binary(X) ->
    gen_binary('undefined', X).

-spec gen_word/1 :: (X :: word()) -> iolist().
gen_word(X) ->
    gen_word('undefined', X).

-spec gen_wire_type/1 :: (X :: wire_type()) -> iolist().
gen_wire_type(X) ->
    gen_wire_type('undefined', X).

-spec gen_variant/1 :: (X :: variant()) -> iolist().
gen_variant(X) ->
    gen_variant('undefined', X).

-spec gen_typed/1 :: (X :: typed()) -> iolist().
gen_typed(X) ->
    gen_typed('undefined', X).

-spec gen_type/1 :: (X :: type()) -> iolist().
gen_type(X) ->
    gen_type('undefined', X).

-spec gen_piq_record/1 :: (X :: piq_record()) -> iolist().
gen_piq_record(X) ->
    gen_piq_record('undefined', X).

-spec gen_piqtype/1 :: (X :: piqtype()) -> iolist().
gen_piqtype(X) ->
    gen_piqtype('undefined', X).

-spec gen_piqi/1 :: (X :: piqi()) -> iolist().
gen_piqi(X) ->
    gen_piqi('undefined', X).

-spec gen_piqdef/1 :: (X :: piqdef()) -> iolist().
gen_piqdef(X) ->
    gen_piqdef('undefined', X).

-spec gen_option/1 :: (X :: option()) -> iolist().
gen_option(X) ->
    gen_option('undefined', X).

-spec gen_named/1 :: (X :: named()) -> iolist().
gen_named(X) ->
    gen_named('undefined', X).

-spec gen_name/1 :: (X :: name()) -> iolist().
gen_name(X) ->
    gen_name('undefined', X).

-spec gen_piq_list/1 :: (X :: piq_list()) -> iolist().
gen_piq_list(X) ->
    gen_piq_list('undefined', X).

-spec gen_import/1 :: (X :: import()) -> iolist().
gen_import(X) ->
    gen_import('undefined', X).

-spec gen_function_param/1 :: (X :: function_param()) -> iolist().
gen_function_param(X) ->
    gen_function_param('undefined', X).

-spec gen_func/1 :: (X :: func()) -> iolist().
gen_func(X) ->
    gen_func('undefined', X).

-spec gen_field_mode/1 :: (X :: field_mode()) -> iolist().
gen_field_mode(X) ->
    gen_field_mode('undefined', X).

-spec gen_field/1 :: (X :: field()) -> iolist().
gen_field(X) ->
    gen_field('undefined', X).

-spec gen_erlang_string_type/1 :: (X :: erlang_string_type()) -> iolist().
gen_erlang_string_type(X) ->
    gen_erlang_string_type('undefined', X).

-spec gen_enum/1 :: (X :: enum()) -> iolist().
gen_enum(X) ->
    gen_enum('undefined', X).

-spec gen_ast_list/1 :: (X :: ast_list()) -> iolist().
gen_ast_list(X) ->
    gen_ast_list('undefined', X).

-spec gen_ast/1 :: (X :: ast()) -> iolist().
gen_ast(X) ->
    gen_ast('undefined', X).

-spec gen_piqi_any/1 :: (X :: piqi_any()) -> iolist().
gen_piqi_any(X) ->
    gen_piqi_any('undefined', X).

-spec gen_anonymous_variant/1 :: (X :: anonymous_variant()) -> iolist().
gen_anonymous_variant(X) ->
    gen_anonymous_variant('undefined', X).

-spec gen_anonymous_record/1 :: (X :: anonymous_record()) -> iolist().
gen_anonymous_record(X) ->
    gen_anonymous_record('undefined', X).

-spec gen_anonymous_list/1 :: (X :: anonymous_list()) -> iolist().
gen_anonymous_list(X) ->
    gen_anonymous_list('undefined', X).

-spec gen_anonymous_enum/1 :: (X :: anonymous_enum()) -> iolist().
gen_anonymous_enum(X) ->
    gen_anonymous_enum('undefined', X).

-spec gen_alias/1 :: (X :: alias()) -> iolist().
gen_alias(X) ->
    gen_alias('undefined', X).

-spec parse_piq_word/1 :: (X :: piqirun_buffer()) -> binary().
parse_piq_word(X) ->
    piqirun:binary_string_of_block(X).

-spec parse_string/1 :: (X :: piqirun_buffer()) -> binary().
parse_string(X) ->
    piqirun:binary_string_of_block(X).

-spec parse_int32/1 :: (X :: piqirun_buffer()) -> integer().
parse_int32(X) ->
    piqirun:integer_of_zigzag_varint(X).


packed_parse_int32(X) ->
    piqirun:integer_of_packed_zigzag_varint(X).

-spec parse_piq_any/1 :: (X :: piqirun_buffer()) -> piqi_any().
parse_piq_any(X) ->
    parse_piqi_any(X).

-spec parse_int64/1 :: (X :: piqirun_buffer()) -> integer().
parse_int64(X) ->
    piqirun:integer_of_zigzag_varint(X).


packed_parse_int64(X) ->
    piqirun:integer_of_packed_zigzag_varint(X).

-spec parse_uint64/1 :: (X :: piqirun_buffer()) -> non_neg_integer().
parse_uint64(X) ->
    piqirun:non_neg_integer_of_varint(X).


packed_parse_uint64(X) ->
    piqirun:non_neg_integer_of_packed_varint(X).

-spec parse_float/1 :: (X :: piqirun_buffer()) -> float().
parse_float(X) ->
    piqirun:float_of_fixed64(X).


packed_parse_float(X) ->
    piqirun:float_of_packed_fixed64(X).

-spec parse_bool/1 :: (X :: piqirun_buffer()) -> boolean().
parse_bool(X) ->
    piqirun:boolean_of_varint(X).


packed_parse_bool(X) ->
    piqirun:boolean_of_packed_varint(X).

-spec parse_binary/1 :: (X :: piqirun_buffer()) -> binary().
parse_binary(X) ->
    piqirun:binary_of_block(X).

-spec parse_word/1 :: (X :: piqirun_buffer()) -> binary().
parse_word(X) ->
    parse_piq_word(X).

-spec parse_wire_type/1 :: (X :: piqirun_buffer()) -> wire_type().
parse_wire_type(X) ->
    case piqirun:integer_of_signed_varint(X) of
        329594984 -> varint;
        99211597 -> zigzag_varint;
        136997651 -> fixed32;
        136998322 -> fixed64;
        441915897 -> signed_varint;
        488499298 -> signed_fixed32;
        488499969 -> signed_fixed64;
        352089421 -> block;
        Y -> piqirun:error_enum_const(Y)
    end.


packed_parse_wire_type(X) ->
    {Code, Rest} = piqirun:integer_of_packed_signed_varint(X),
    {case Code of
        329594984 -> varint;
        99211597 -> zigzag_varint;
        136997651 -> fixed32;
        136998322 -> fixed64;
        441915897 -> signed_varint;
        488499298 -> signed_fixed32;
        488499969 -> signed_fixed64;
        352089421 -> block;
        Y -> piqirun:error_enum_const(Y)
    end, Rest}.

-spec parse_variant/1 :: (X :: piqirun_buffer()) -> variant().
parse_variant(X) -> 
    R0 = piqirun:parse_record(X),
    {_Erlang_name, R1} = piqirun:parse_optional_field(31586877, fun parse_string/1, R0),
    {_Proto_name, R2} = piqirun:parse_optional_field(139663632, fun parse_string/1, R1),
    {_Name, R3} = piqirun:parse_required_field(150958667, fun parse_name/1, R2),
    {_Option, R4} = piqirun:parse_repeated_field(192598901, fun parse_option/1, R3),
    {_Proto_custom, R5} = piqirun:parse_repeated_field(405875126, fun parse_string/1, R4),
    {_Json_name, R6} = piqirun:parse_optional_field(515275216, fun parse_string/1, R5),
    piqirun:check_unparsed_fields(R6),
    #variant{
        erlang_name = _Erlang_name,
        proto_name = _Proto_name,
        name = _Name,
        option = _Option,
        proto_custom = _Proto_custom,
        json_name = _Json_name
    }.

-spec parse_typed/1 :: (X :: piqirun_buffer()) -> typed().
parse_typed(X) -> 
    R0 = piqirun:parse_record(X),
    {_Type, R1} = piqirun:parse_required_field(218690234, fun parse_word/1, R0),
    {_Value, R2} = piqirun:parse_required_field(297303921, fun parse_piqi_any/1, R1),
    piqirun:check_unparsed_fields(R2),
    #typed{
        type = _Type,
        value = _Value
    }.

-spec parse_type/1 :: (X :: piqirun_buffer()) -> type().
parse_type(X) ->
    {Code, Obj} = piqirun:parse_variant(X),
    case Code of
        150958667 -> {name, parse_name(Obj)};
        170743570 -> parse_piqtype(Obj);
        _ -> piqirun:error_option(Obj, Code)
    end.

-spec parse_piq_record/1 :: (X :: piqirun_buffer()) -> piq_record().
parse_piq_record(X) -> 
    R0 = piqirun:parse_record(X),
    {_Field, R1} = piqirun:parse_repeated_field(9671866, fun parse_field/1, R0),
    {_Erlang_name, R2} = piqirun:parse_optional_field(31586877, fun parse_string/1, R1),
    {_Proto_name, R3} = piqirun:parse_optional_field(139663632, fun parse_string/1, R2),
    {_Name, R4} = piqirun:parse_required_field(150958667, fun parse_name/1, R3),
    {_Proto_custom, R5} = piqirun:parse_repeated_field(405875126, fun parse_string/1, R4),
    {_Json_name, R6} = piqirun:parse_optional_field(515275216, fun parse_string/1, R5),
    piqirun:check_unparsed_fields(R6),
    #piq_record{
        field = _Field,
        erlang_name = _Erlang_name,
        proto_name = _Proto_name,
        name = _Name,
        proto_custom = _Proto_custom,
        json_name = _Json_name
    }.

-spec parse_piqtype/1 :: (X :: piqirun_buffer()) -> piqtype().
parse_piqtype(X) ->
    {Code, Obj} = piqirun:parse_variant(X),
    case Code of
        134785133 -> parse_piqdef(Obj);
        5246191 when Obj == 1 -> int;
        43435420 when Obj == 1 -> float;
        18580522 when Obj == 1 -> bool;
        288368849 when Obj == 1 -> string;
        218872833 when Obj == 1 -> binary;
        217697453 when Obj == 1 -> text;
        251462090 when Obj == 1 -> word;
        4848364 when Obj == 1 -> any;
        _ -> piqirun:error_option(Obj, Code)
    end.

-spec parse_piqi/1 :: (X :: piqirun_buffer()) -> piqi().
parse_piqi(X) -> 
    R0 = piqirun:parse_record(X),
    {_Module, R1} = piqirun:parse_optional_field(13841580, fun parse_word/1, R0),
    {_Erlang_string_type, R2} = piqirun:parse_optional_field(19040580, fun parse_erlang_string_type/1, R1, <<8,129,248,174,104>>),
    {_Piqdef, R3} = piqirun:parse_repeated_field(134785133, fun parse_piqdef/1, R2),
    {_Import, R4} = piqirun:parse_repeated_field(142778725, fun parse_import/1, R3),
    {_Erlang_type_prefix, R5} = piqirun:parse_optional_field(330902611, fun parse_string/1, R4),
    {_Proto_package, R6} = piqirun:parse_optional_field(333467105, fun parse_string/1, R5),
    {_Func, R7} = piqirun:parse_repeated_field(340962072, fun parse_func/1, R6),
    {_Proto_custom, R8} = piqirun:parse_repeated_field(405875126, fun parse_string/1, R7),
    {_Erlang_module, R9} = piqirun:parse_optional_field(492641566, fun parse_string/1, R8),
    piqirun:check_unparsed_fields(R9),
    #piqi{
        module = _Module,
        erlang_string_type = _Erlang_string_type,
        piqdef = _Piqdef,
        import = _Import,
        erlang_type_prefix = _Erlang_type_prefix,
        proto_package = _Proto_package,
        func = _Func,
        proto_custom = _Proto_custom,
        erlang_module = _Erlang_module
    }.

-spec parse_piqdef/1 :: (X :: piqirun_buffer()) -> piqdef().
parse_piqdef(X) ->
    {Code, Obj} = piqirun:parse_variant(X),
    case Code of
        502036113 -> {piq_record, parse_piq_record(Obj)};
        484589701 -> {variant, parse_variant(Obj)};
        51800833 -> {enum, parse_enum(Obj)};
        26300816 -> {alias, parse_alias(Obj)};
        129178718 -> {piq_list, parse_piq_list(Obj)};
        _ -> piqirun:error_option(Obj, Code)
    end.

-spec parse_option/1 :: (X :: piqirun_buffer()) -> option().
parse_option(X) -> 
    R0 = piqirun:parse_record(X),
    {_Code, R1} = piqirun:parse_optional_field(29667629, fun parse_int32/1, R0),
    {_Erlang_name, R2} = piqirun:parse_optional_field(31586877, fun parse_string/1, R1),
    {_Proto_name, R3} = piqirun:parse_optional_field(139663632, fun parse_string/1, R2),
    {_Name, R4} = piqirun:parse_optional_field(150958667, fun parse_name/1, R3),
    {_Getopt_letter, R5} = piqirun:parse_optional_field(215188758, fun parse_word/1, R4),
    {_Type, R6} = piqirun:parse_optional_field(218690234, fun parse_type/1, R5),
    {_Getopt_doc, R7} = piqirun:parse_optional_field(442330184, fun parse_string/1, R6),
    {_Json_name, R8} = piqirun:parse_optional_field(515275216, fun parse_string/1, R7),
    piqirun:check_unparsed_fields(R8),
    #option{
        code = _Code,
        erlang_name = _Erlang_name,
        proto_name = _Proto_name,
        name = _Name,
        getopt_letter = _Getopt_letter,
        type = _Type,
        getopt_doc = _Getopt_doc,
        json_name = _Json_name
    }.

-spec parse_named/1 :: (X :: piqirun_buffer()) -> named().
parse_named(X) -> 
    R0 = piqirun:parse_record(X),
    {_Name, R1} = piqirun:parse_required_field(150958667, fun parse_name/1, R0),
    {_Value, R2} = piqirun:parse_required_field(297303921, fun parse_ast/1, R1),
    piqirun:check_unparsed_fields(R2),
    #named{
        name = _Name,
        value = _Value
    }.

-spec parse_name/1 :: (X :: piqirun_buffer()) -> binary().
parse_name(X) ->
    parse_word(X).

-spec parse_piq_list/1 :: (X :: piqirun_buffer()) -> piq_list().
parse_piq_list(X) -> 
    R0 = piqirun:parse_record(X),
    {_Erlang_name, R1} = piqirun:parse_optional_field(31586877, fun parse_string/1, R0),
    {_Proto_name, R2} = piqirun:parse_optional_field(139663632, fun parse_string/1, R1),
    {_Name, R3} = piqirun:parse_required_field(150958667, fun parse_name/1, R2),
    {_Type, R4} = piqirun:parse_required_field(218690234, fun parse_type/1, R3),
    {_Proto_custom, R5} = piqirun:parse_repeated_field(405875126, fun parse_string/1, R4),
    {_Wire_packed, R6} = piqirun:parse_flag(422905280, R5),
    {_Json_name, R7} = piqirun:parse_optional_field(515275216, fun parse_string/1, R6),
    piqirun:check_unparsed_fields(R7),
    #piq_list{
        erlang_name = _Erlang_name,
        proto_name = _Proto_name,
        name = _Name,
        type = _Type,
        proto_custom = _Proto_custom,
        wire_packed = _Wire_packed,
        json_name = _Json_name
    }.

-spec parse_import/1 :: (X :: piqirun_buffer()) -> import().
parse_import(X) -> 
    R0 = piqirun:parse_record(X),
    {_Module, R1} = piqirun:parse_required_field(13841580, fun parse_word/1, R0),
    {_Name, R2} = piqirun:parse_optional_field(150958667, fun parse_name/1, R1),
    piqirun:check_unparsed_fields(R2),
    #import{
        module = _Module,
        name = _Name
    }.

-spec parse_function_param/1 :: (X :: piqirun_buffer()) -> function_param().
parse_function_param(X) ->
    {Code, Obj} = piqirun:parse_variant(X),
    case Code of
        150958667 -> {name, parse_name(Obj)};
        502036113 -> {record, parse_anonymous_record(Obj)};
        484589701 -> {variant, parse_anonymous_variant(Obj)};
        51800833 -> {enum, parse_anonymous_enum(Obj)};
        129178718 -> {list, parse_anonymous_list(Obj)};
        _ -> piqirun:error_option(Obj, Code)
    end.

-spec parse_func/1 :: (X :: piqirun_buffer()) -> func().
parse_func(X) -> 
    R0 = piqirun:parse_record(X),
    {_Erlang_name, R1} = piqirun:parse_optional_field(31586877, fun parse_string/1, R0),
    {_Name, R2} = piqirun:parse_required_field(150958667, fun parse_name/1, R1),
    {_Output, R3} = piqirun:parse_optional_field(209784577, fun parse_function_param/1, R2),
    {_Error, R4} = piqirun:parse_optional_field(321506248, fun parse_function_param/1, R3),
    {_Input, R5} = piqirun:parse_optional_field(505267210, fun parse_function_param/1, R4),
    piqirun:check_unparsed_fields(R5),
    #func{
        erlang_name = _Erlang_name,
        name = _Name,
        output = _Output,
        error = _Error,
        input = _Input
    }.

-spec parse_field_mode/1 :: (X :: piqirun_buffer()) -> field_mode().
parse_field_mode(X) ->
    {Code, Obj} = piqirun:parse_variant(X),
    case Code of
        308449631 when Obj == 1 -> required;
        510570400 when Obj == 1 -> optional;
        274054266 when Obj == 1 -> repeated;
        _ -> piqirun:error_option(Obj, Code)
    end.

-spec parse_field/1 :: (X :: piqirun_buffer()) -> field().
parse_field(X) -> 
    R0 = piqirun:parse_record(X),
    {_Code, R1} = piqirun:parse_optional_field(29667629, fun parse_int32/1, R0),
    {_Erlang_name, R2} = piqirun:parse_optional_field(31586877, fun parse_string/1, R1),
    {_Proto_name, R3} = piqirun:parse_optional_field(139663632, fun parse_string/1, R2),
    {_Mode, R4} = piqirun:parse_optional_field(140563299, fun parse_field_mode/1, R3, <<248,149,210,152,9,1>>),
    {_Name, R5} = piqirun:parse_optional_field(150958667, fun parse_name/1, R4),
    {_Getopt_letter, R6} = piqirun:parse_optional_field(215188758, fun parse_word/1, R5),
    {_Type, R7} = piqirun:parse_optional_field(218690234, fun parse_type/1, R6),
    {_Wire_packed, R8} = piqirun:parse_flag(422905280, R7),
    {_Getopt_doc, R9} = piqirun:parse_optional_field(442330184, fun parse_string/1, R8),
    {_Default, R10} = piqirun:parse_optional_field(465819841, fun parse_piq_any/1, R9),
    {_Json_name, R11} = piqirun:parse_optional_field(515275216, fun parse_string/1, R10),
    piqirun:check_unparsed_fields(R11),
    #field{
        code = _Code,
        erlang_name = _Erlang_name,
        proto_name = _Proto_name,
        mode = _Mode,
        name = _Name,
        getopt_letter = _Getopt_letter,
        type = _Type,
        wire_packed = _Wire_packed,
        getopt_doc = _Getopt_doc,
        default = _Default,
        json_name = _Json_name
    }.

-spec parse_erlang_string_type/1 :: (X :: piqirun_buffer()) -> erlang_string_type().
parse_erlang_string_type(X) ->
    case piqirun:integer_of_signed_varint(X) of
        218872833 -> binary;
        129178718 -> list;
        Y -> piqirun:error_enum_const(Y)
    end.


packed_parse_erlang_string_type(X) ->
    {Code, Rest} = piqirun:integer_of_packed_signed_varint(X),
    {case Code of
        218872833 -> binary;
        129178718 -> list;
        Y -> piqirun:error_enum_const(Y)
    end, Rest}.

-spec parse_enum/1 :: (X :: piqirun_buffer()) -> variant().
parse_enum(X) ->
    parse_variant(X).

-spec parse_ast_list/1 :: (X :: piqirun_buffer()) -> ast_list().
parse_ast_list(X) ->
    piqirun:parse_list(fun parse_ast/1,  X).

-spec parse_ast/1 :: (X :: piqirun_buffer()) -> ast().
parse_ast(X) ->
    {Code, Obj} = piqirun:parse_variant(X),
    case Code of
        5246191 -> {int, parse_int64(Obj)};
        228983706 -> {uint, parse_uint64(Obj)};
        43435420 -> {float, parse_float(Obj)};
        18580522 -> {bool, parse_bool(Obj)};
        251462090 -> {word, parse_word(Obj)};
        90831757 -> {ascii_string, parse_string(Obj)};
        387197869 -> {utf8_string, parse_string(Obj)};
        218872833 -> {binary, parse_binary(Obj)};
        217697453 -> {text, parse_string(Obj)};
        150958667 -> {name, parse_name(Obj)};
        377786297 -> {named, parse_named(Obj)};
        218690234 -> {type, parse_word(Obj)};
        449540202 -> {typed, parse_typed(Obj)};
        129178718 -> {list, parse_ast_list(Obj)};
        427912029 -> {control, parse_ast_list(Obj)};
        _ -> piqirun:error_option(Obj, Code)
    end.

-spec parse_piqi_any/1 :: (X :: piqirun_buffer()) -> piqi_any().
parse_piqi_any(X) -> 
    R0 = piqirun:parse_record(X),
    {_Ast, R1} = piqirun:parse_optional_field(4849474, fun parse_ast/1, R0),
    {_Binobj, R2} = piqirun:parse_optional_field(219565456, fun parse_binary/1, R1),
    piqirun:check_unparsed_fields(R2),
    #piqi_any{
        ast = _Ast,
        binobj = _Binobj
    }.

-spec parse_anonymous_variant/1 :: (X :: piqirun_buffer()) -> anonymous_variant().
parse_anonymous_variant(X) -> 
    R0 = piqirun:parse_record(X),
    {_Option, R1} = piqirun:parse_repeated_field(192598901, fun parse_option/1, R0),
    piqirun:check_unparsed_fields(R1),
    #anonymous_variant{
        option = _Option
    }.

-spec parse_anonymous_record/1 :: (X :: piqirun_buffer()) -> anonymous_record().
parse_anonymous_record(X) -> 
    R0 = piqirun:parse_record(X),
    {_Field, R1} = piqirun:parse_repeated_field(9671866, fun parse_field/1, R0),
    piqirun:check_unparsed_fields(R1),
    #anonymous_record{
        field = _Field
    }.

-spec parse_anonymous_list/1 :: (X :: piqirun_buffer()) -> anonymous_list().
parse_anonymous_list(X) -> 
    R0 = piqirun:parse_record(X),
    {_Type, R1} = piqirun:parse_required_field(218690234, fun parse_type/1, R0),
    piqirun:check_unparsed_fields(R1),
    #anonymous_list{
        type = _Type
    }.

-spec parse_anonymous_enum/1 :: (X :: piqirun_buffer()) -> anonymous_variant().
parse_anonymous_enum(X) ->
    parse_anonymous_variant(X).

-spec parse_alias/1 :: (X :: piqirun_buffer()) -> alias().
parse_alias(X) -> 
    R0 = piqirun:parse_record(X),
    {_Wire_type, R1} = piqirun:parse_optional_field(9699074, fun parse_wire_type/1, R0),
    {_Erlang_name, R2} = piqirun:parse_optional_field(31586877, fun parse_string/1, R1),
    {_Erlang_type, R3} = piqirun:parse_optional_field(99318444, fun parse_string/1, R2),
    {_Proto_name, R4} = piqirun:parse_optional_field(139663632, fun parse_string/1, R3),
    {_Name, R5} = piqirun:parse_required_field(150958667, fun parse_name/1, R4),
    {_Proto_type, R6} = piqirun:parse_optional_field(207395199, fun parse_string/1, R5),
    {_Type, R7} = piqirun:parse_required_field(218690234, fun parse_type/1, R6),
    {_Json_name, R8} = piqirun:parse_optional_field(515275216, fun parse_string/1, R7),
    piqirun:check_unparsed_fields(R8),
    #alias{
        wire_type = _Wire_type,
        erlang_name = _Erlang_name,
        erlang_type = _Erlang_type,
        proto_name = _Proto_name,
        name = _Name,
        proto_type = _Proto_type,
        type = _Type,
        json_name = _Json_name
    }.



