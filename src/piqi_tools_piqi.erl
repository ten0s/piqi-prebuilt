-module(piqi_tools_piqi).
-compile(export_all).

-include_lib("piqi/include/piqirun.hrl").
-include("piqi_tools_piqi.hrl").

-spec gen_binary/2 :: (Code :: piqirun_code(), X :: binary()) -> iolist().
gen_binary(Code, X) ->
    piqirun:binary_to_block(Code, X).

-spec gen_string/2 :: (Code :: piqirun_code(), X :: string() | binary()) -> iolist().
gen_string(Code, X) ->
    piqirun:string_to_block(Code, X).

-spec gen_bool/2 :: (Code :: piqirun_code(), X :: boolean()) -> iolist().
gen_bool(Code, X) ->
    piqirun:boolean_to_varint(Code, X).


packed_gen_bool(X) ->
    piqirun:boolean_to_packed_varint(X).

-spec gen_format/2 :: (Code :: piqirun_code(), X :: piqi_tools_format()) -> iolist().
gen_format(Code, X) ->
    piqirun:integer_to_signed_varint(Code,
        case X of
            piq -> 1;
        json -> 2;
        pb -> 3;
        xml -> 4
        end
    ).


packed_gen_format(X) ->
    piqirun:integer_to_packed_signed_varint(
        case X of
            piq -> 1;
        json -> 2;
        pb -> 3;
        xml -> 4
        end
    ).

-spec gen_add_piqi_input/2 :: (Code :: piqirun_code(), X :: piqi_tools_add_piqi_input()) -> iolist().
gen_add_piqi_input(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_required_field(1, fun gen_format/2, X#piqi_tools_add_piqi_input.format),
        piqirun:gen_repeated_field(2, fun gen_binary/2, X#piqi_tools_add_piqi_input.data)
    ]).

-spec gen_add_piqi_error/2 :: (Code :: piqirun_code(), X :: piqi_tools_add_piqi_error()) -> iolist().
gen_add_piqi_error(Code, X) ->
    gen_string(Code, X).

-spec gen_convert_input/2 :: (Code :: piqirun_code(), X :: piqi_tools_convert_input()) -> iolist().
gen_convert_input(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_required_field(1, fun gen_string/2, X#piqi_tools_convert_input.type_name),
        piqirun:gen_required_field(2, fun gen_binary/2, X#piqi_tools_convert_input.data),
        piqirun:gen_required_field(3, fun gen_format/2, X#piqi_tools_convert_input.input_format),
        piqirun:gen_required_field(4, fun gen_format/2, X#piqi_tools_convert_input.output_format),
        piqirun:gen_optional_field(5, fun gen_bool/2, X#piqi_tools_convert_input.pretty_print),
        piqirun:gen_optional_field(6, fun gen_bool/2, X#piqi_tools_convert_input.json_omit_null_fields),
        piqirun:gen_optional_field(7, fun gen_bool/2, X#piqi_tools_convert_input.use_strict_parsing)
    ]).

-spec gen_convert_output/2 :: (Code :: piqirun_code(), X :: piqi_tools_convert_output()) -> iolist().
gen_convert_output(Code, X) ->
    piqirun:gen_record(Code, [
        piqirun:gen_required_field(1, fun gen_binary/2, X#piqi_tools_convert_output.data)
    ]).

-spec gen_convert_error/2 :: (Code :: piqirun_code(), X :: piqi_tools_convert_error()) -> iolist().
gen_convert_error(Code, X) ->
    gen_string(Code, X).

-spec gen_binary/1 :: (X :: binary()) -> iolist().
gen_binary(X) ->
    gen_binary('undefined', X).

-spec gen_string/1 :: (X :: string() | binary()) -> iolist().
gen_string(X) ->
    gen_string('undefined', X).

-spec gen_bool/1 :: (X :: boolean()) -> iolist().
gen_bool(X) ->
    gen_bool('undefined', X).

-spec gen_format/1 :: (X :: piqi_tools_format()) -> iolist().
gen_format(X) ->
    gen_format('undefined', X).

-spec gen_add_piqi_input/1 :: (X :: piqi_tools_add_piqi_input()) -> iolist().
gen_add_piqi_input(X) ->
    gen_add_piqi_input('undefined', X).

-spec gen_add_piqi_error/1 :: (X :: piqi_tools_add_piqi_error()) -> iolist().
gen_add_piqi_error(X) ->
    gen_add_piqi_error('undefined', X).

-spec gen_convert_input/1 :: (X :: piqi_tools_convert_input()) -> iolist().
gen_convert_input(X) ->
    gen_convert_input('undefined', X).

-spec gen_convert_output/1 :: (X :: piqi_tools_convert_output()) -> iolist().
gen_convert_output(X) ->
    gen_convert_output('undefined', X).

-spec gen_convert_error/1 :: (X :: piqi_tools_convert_error()) -> iolist().
gen_convert_error(X) ->
    gen_convert_error('undefined', X).

-spec parse_binary/1 :: (X :: piqirun_buffer()) -> binary().
parse_binary(X) ->
    piqirun:binary_of_block(X).

-spec parse_string/1 :: (X :: piqirun_buffer()) -> binary().
parse_string(X) ->
    piqirun:binary_string_of_block(X).

-spec parse_bool/1 :: (X :: piqirun_buffer()) -> boolean().
parse_bool(X) ->
    piqirun:boolean_of_varint(X).


packed_parse_bool(X) ->
    piqirun:boolean_of_packed_varint(X).

-spec parse_format/1 :: (X :: piqirun_buffer()) -> piqi_tools_format().
parse_format(X) ->
    case piqirun:integer_of_signed_varint(X) of
        1 -> piq;
        2 -> json;
        3 -> pb;
        4 -> xml;
        Y -> piqirun:error_enum_const(Y)
    end.


packed_parse_format(X) ->
    {Code, Rest} = piqirun:integer_of_packed_signed_varint(X),
    {case Code of
        1 -> piq;
        2 -> json;
        3 -> pb;
        4 -> xml;
        Y -> piqirun:error_enum_const(Y)
    end, Rest}.

-spec parse_add_piqi_input/1 :: (X :: piqirun_buffer()) -> piqi_tools_add_piqi_input().
parse_add_piqi_input(X) -> 
    R0 = piqirun:parse_record(X),
    {_Format, R1} = piqirun:parse_required_field(1, fun parse_format/1, R0),
    {_Data, R2} = piqirun:parse_repeated_field(2, fun parse_binary/1, R1),
    piqirun:check_unparsed_fields(R2),
    #piqi_tools_add_piqi_input{
        format = _Format,
        data = _Data
    }.

-spec parse_add_piqi_error/1 :: (X :: piqirun_buffer()) -> binary().
parse_add_piqi_error(X) ->
    parse_string(X).

-spec parse_convert_input/1 :: (X :: piqirun_buffer()) -> piqi_tools_convert_input().
parse_convert_input(X) -> 
    R0 = piqirun:parse_record(X),
    {_Type_name, R1} = piqirun:parse_required_field(1, fun parse_string/1, R0),
    {_Data, R2} = piqirun:parse_required_field(2, fun parse_binary/1, R1),
    {_Input_format, R3} = piqirun:parse_required_field(3, fun parse_format/1, R2),
    {_Output_format, R4} = piqirun:parse_required_field(4, fun parse_format/1, R3),
    {_Pretty_print, R5} = piqirun:parse_optional_field(5, fun parse_bool/1, R4, <<8,1>>),
    {_Json_omit_null_fields, R6} = piqirun:parse_optional_field(6, fun parse_bool/1, R5, <<8,1>>),
    {_Use_strict_parsing, R7} = piqirun:parse_optional_field(7, fun parse_bool/1, R6, <<8,0>>),
    piqirun:check_unparsed_fields(R7),
    #piqi_tools_convert_input{
        type_name = _Type_name,
        data = _Data,
        input_format = _Input_format,
        output_format = _Output_format,
        pretty_print = _Pretty_print,
        json_omit_null_fields = _Json_omit_null_fields,
        use_strict_parsing = _Use_strict_parsing
    }.

-spec parse_convert_output/1 :: (X :: piqirun_buffer()) -> piqi_tools_convert_output().
parse_convert_output(X) -> 
    R0 = piqirun:parse_record(X),
    {_Data, R1} = piqirun:parse_required_field(1, fun parse_binary/1, R0),
    piqirun:check_unparsed_fields(R1),
    #piqi_tools_convert_output{
        data = _Data
    }.

-spec parse_convert_error/1 :: (X :: piqirun_buffer()) -> binary().
parse_convert_error(X) ->
    parse_string(X).



