-ifndef(__PIQI_PIQI_HRL__).
-define(__PIQI_PIQI_HRL__, 1).

-type(word() :: string() | binary()).
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
-type(ast_list() :: [ast()]).
-type(name() :: word()).
-record(named, {
    name :: name(),
    value :: ast()
}).
-record(typed, {
    type :: word(),
    value :: piqi_any()
}).
-type(piqdef() :: 
      {piq_record, piq_record()}
    | {variant, variant()}
    | {enum, enum()}
    | {alias, alias()}
    | {piq_list, piq_list()}
).
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
-type(type() :: 
      {name, name()}
    | piqtype()
).
-type(field_mode() :: 
      required
    | optional
    | repeated
).
-type(enum() :: variant()).
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
-record(include, {
    module :: word()
}).
-record(import, {
    module :: word(),
    name :: name()
}).
-record(extend, {
    name = [] :: [name()],
    piq_any = [] :: [piqi_any()]
}).
-type(function_param() :: 
      {name, name()}
    | {record, anonymous_record()}
    | {variant, anonymous_variant()}
    | {enum, anonymous_enum()}
    | {list, anonymous_list()}
).
-record(anonymous_record, {
    field = [] :: [field()]
}).
-record(anonymous_variant, {
    option = [] :: [option()]
}).
-type(anonymous_enum() :: anonymous_variant()).
-record(anonymous_list, {
    type :: type()
}).
-type(erlang_string_type() :: 
      binary
    | list
).
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
-record(piq_list, {
    name :: name(),
    type :: type(),
    wire_packed :: boolean(),
    proto_name :: string() | binary(),
    proto_custom = [] :: [string() | binary()],
    json_name :: string() | binary(),
    erlang_name :: string() | binary()
}).
-record(piq_record, {
    name :: name(),
    field = [] :: [field()],
    proto_name :: string() | binary(),
    proto_custom = [] :: [string() | binary()],
    json_name :: string() | binary(),
    erlang_name :: string() | binary()
}).
-record(variant, {
    name :: name(),
    option = [] :: [option()],
    proto_name :: string() | binary(),
    proto_custom = [] :: [string() | binary()],
    json_name :: string() | binary(),
    erlang_name :: string() | binary()
}).
-record(piqi, {
    module :: word(),
    custom_field = [] :: [word()],
    piqdef = [] :: [piqdef()],
    extend = [] :: [extend()],
    include = [] :: [include()],
    import = [] :: [import()],
    func = [] :: [func()],
    proto_package :: string() | binary(),
    proto_custom = [] :: [string() | binary()],
    erlang_module :: string() | binary(),
    erlang_type_prefix :: string() | binary(),
    erlang_string_type :: erlang_string_type()
}).
-record(func, {
    name :: name(),
    input :: function_param(),
    output :: function_param(),
    error :: function_param(),
    erlang_name :: string() | binary()
}).
-record(piqi_any, {
    ast :: ast(),
    binobj :: binary()
}).

-type(named() :: #named{}).
-type(typed() :: #typed{}).
-type(include() :: #include{}).
-type(import() :: #import{}).
-type(extend() :: #extend{}).
-type(anonymous_record() :: #anonymous_record{}).
-type(anonymous_variant() :: #anonymous_variant{}).
-type(anonymous_list() :: #anonymous_list{}).
-type(alias() :: #alias{}).
-type(field() :: #field{}).
-type(option() :: #option{}).
-type(piq_list() :: #piq_list{}).
-type(piq_record() :: #piq_record{}).
-type(variant() :: #variant{}).
-type(piqi() :: #piqi{}).
-type(func() :: #func{}).
-type(piqi_any() :: #piqi_any{}).


-endif.
