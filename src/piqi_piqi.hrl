-ifndef(__PIQI_PIQI_HRL__).
-define(__PIQI_PIQI_HRL__, 1).

-type(word() :: string() | binary()).
-type(wire_type() :: 
      varint
    | zigzag_varint
    | fixed32
    | fixed64
    | signed_varint
    | signed_fixed32
    | signed_fixed64
    | block
).
-record(variant, {
    name :: name(),
    option = [] :: [option()],
    proto_name :: string() | binary(),
    proto_custom = [] :: [string() | binary()],
    json_name :: string() | binary(),
    erlang_name :: string() | binary()
}).
-record(typed, {
    type :: word(),
    value :: piqi_any()
}).
-type(type() :: 
      {name, name()}
    | piqtype()
).
-record(piq_record, {
    name :: name(),
    field = [] :: [field()],
    proto_name :: string() | binary(),
    proto_custom = [] :: [string() | binary()],
    json_name :: string() | binary(),
    erlang_name :: string() | binary()
}).
-type(piqtype() :: 
      piqdef()
    | int
    | float
    | bool
    | string
    | binary
    | text
    | word
    | any
).
-record(piqi, {
    module :: word(),
    piqdef = [] :: [piqdef()],
    import = [] :: [import()],
    func = [] :: [func()],
    proto_package :: string() | binary(),
    proto_custom = [] :: [string() | binary()],
    erlang_module :: string() | binary(),
    erlang_type_prefix :: string() | binary(),
    erlang_string_type :: erlang_string_type()
}).
-type(piqdef() :: 
      {piq_record, piq_record()}
    | {variant, variant()}
    | {enum, enum()}
    | {alias, alias()}
    | {piq_list, piq_list()}
).
-record(option, {
    name :: name(),
    type :: type(),
    code :: integer(),
    proto_name :: string() | binary(),
    json_name :: string() | binary(),
    getopt_letter :: word(),
    getopt_doc :: string() | binary(),
    erlang_name :: string() | binary()
}).
-record(named, {
    name :: name(),
    value :: ast()
}).
-type(name() :: word()).
-record(piq_list, {
    name :: name(),
    type :: type(),
    wire_packed :: boolean(),
    proto_name :: string() | binary(),
    proto_custom = [] :: [string() | binary()],
    json_name :: string() | binary(),
    erlang_name :: string() | binary()
}).
-record(import, {
    module :: word(),
    name :: name()
}).
-type(function_param() :: 
      {name, name()}
    | {record, anonymous_record()}
    | {variant, anonymous_variant()}
    | {enum, anonymous_enum()}
    | {list, anonymous_list()}
).
-record(func, {
    name :: name(),
    input :: function_param(),
    output :: function_param(),
    error :: function_param(),
    erlang_name :: string() | binary()
}).
-type(field_mode() :: 
      required
    | optional
    | repeated
).
-record(field, {
    name :: name(),
    type :: type(),
    mode :: field_mode(),
    default :: piqi_any(),
    code :: integer(),
    wire_packed :: boolean(),
    proto_name :: string() | binary(),
    json_name :: string() | binary(),
    getopt_letter :: word(),
    getopt_doc :: string() | binary(),
    erlang_name :: string() | binary()
}).
-type(erlang_string_type() :: 
      binary
    | list
).
-type(enum() :: variant()).
-type(ast_list() :: [ast()]).
-type(ast() :: 
      {int, integer()}
    | {uint, non_neg_integer()}
    | {float, number()}
    | {bool, boolean()}
    | {word, word()}
    | {ascii_string, string() | binary()}
    | {utf8_string, string() | binary()}
    | {binary, binary()}
    | {text, string() | binary()}
    | {name, name()}
    | {named, named()}
    | {type, word()}
    | {typed, typed()}
    | {list, ast_list()}
    | {control, ast_list()}
).
-record(piqi_any, {
    ast :: ast(),
    binobj :: binary()
}).
-record(anonymous_variant, {
    option = [] :: [option()]
}).
-record(anonymous_record, {
    field = [] :: [field()]
}).
-record(anonymous_list, {
    type :: type()
}).
-type(anonymous_enum() :: anonymous_variant()).
-record(alias, {
    name :: name(),
    type :: type(),
    wire_type :: wire_type(),
    proto_name :: string() | binary(),
    proto_type :: string() | binary(),
    json_name :: string() | binary(),
    erlang_name :: string() | binary(),
    erlang_type :: string() | binary()
}).

-type(variant() :: #variant{}).
-type(typed() :: #typed{}).
-type(piq_record() :: #piq_record{}).
-type(piqi() :: #piqi{}).
-type(option() :: #option{}).
-type(named() :: #named{}).
-type(piq_list() :: #piq_list{}).
-type(import() :: #import{}).
-type(func() :: #func{}).
-type(field() :: #field{}).
-type(piqi_any() :: #piqi_any{}).
-type(anonymous_variant() :: #anonymous_variant{}).
-type(anonymous_record() :: #anonymous_record{}).
-type(anonymous_list() :: #anonymous_list{}).
-type(alias() :: #alias{}).


-endif.
