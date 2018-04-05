
type t

module Obj = struct
  type t = <
    name : string;
    dir  : bool;
    date : Js.Date.t;
  > Js.t

  external _get_contents : t -> string -> string Js.Promise.t = "async"
  [@@bs.send]

  let get_contents file = _get_contents file "string"
end

external make : unit -> t = "jszip" [@@bs.new] [@@bs.module]

external add_file : string -> string -> t = "file"[@@bs.send.pipe: t]
external folder : string -> t = "folder" [@@bs.send.pipe: t]
external each : (string -> Obj.t -> unit) -> unit = "forEach" [@@bs.send.pipe: t]
external get : string -> Obj.t option = "file" [@@bs.send.pipe: t][@@bs.return nullable]
external remove : string -> t = "remove" [@@bs.send.pipe: t]
external filter : (string -> Obj.t -> bool) -> Obj.t array = "filter" [@@bs.send.pipe: t]

external _generate : t -> 'a -> string Js.Promise.t = "generateAsync" [@@bs.send]
external _load : t -> string -> t Js.Promise.t = "loadAsync" [@@bs.send]

let generate zip = _generate zip [%raw {| { type: 'string' } |}]
let load filename = _load (make ()) filename
