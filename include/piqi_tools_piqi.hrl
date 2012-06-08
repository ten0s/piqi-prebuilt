-ifndef(__PIQI_TOOLS_PIQI_HRL__).
-define(__PIQI_TOOLS_PIQI_HRL__, 1).

-type(piqi_tools_format() :: 
      piq
    | json
    | pb
    | xml
).
-record(piqi_tools_add_piqi_input, {
    format :: piqi_tools_format(),
    data = [] :: [binary()]
}).
-type(piqi_tools_add_piqi_error() :: string() | binary()).
-record(piqi_tools_convert_input, {
    type_name :: string() | binary(),
    data :: binary(),
    input_format :: piqi_tools_format(),
    output_format :: piqi_tools_format(),
    pretty_print :: boolean(),
    json_omit_null_fields :: boolean(),
    use_strict_parsing :: boolean()
}).
-record(piqi_tools_convert_output, {
    data :: binary()
}).
-type(piqi_tools_convert_error() :: string() | binary()).

-type(piqi_tools_add_piqi_input() :: #piqi_tools_add_piqi_input{}).
-type(piqi_tools_convert_input() :: #piqi_tools_convert_input{}).
-type(piqi_tools_convert_output() :: #piqi_tools_convert_output{}).


-endif.
