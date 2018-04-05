
(** Abstract type representing the whole zip file object. *)
type t

module Obj : sig
  (** Internal ZipObject, which represents an individual file/folder. *)
  type t = <
    name : string;
    dir  : bool;
    date : Js.Date.t;
  > Js.t

  (** Gets the contents of the desired file, encapsulating it in a promise. *)
  val get_contents : t -> string Js.Promise.t
end

(** Constructs an empty Zip.t *)
val make : unit -> t

(** Adds a new file to the archive, raises an error when the operation is
    impossible. *)
val add_file : string -> string -> t -> t

(** Changes the current directory to a new one under the current root. If the
    directory does not exist, it will be automatically created.

    The folder in question will be the new root of the returned Zip.t.
    The old Zip.t root will remain the same. *)
val folder : string -> t -> t

(** Iterates over all the files and directories of the zip file. *)
val each : (string -> Obj.t -> unit) -> t -> unit

(** Gets the Zip.Obj.t of a file or folder with the matched name. *)
val get : string -> t -> Obj.t option

(** Removes a file or a directory tree from the Zip.t. *)
val remove : string -> t ->  t

(** Returns an array of the file objetcs filtered by the function *)
val filter : (string -> Obj.t -> bool) -> t -> Obj.t array

(** Serializes a Zip.t into a binary string *)
val generate : t -> string Js.Promise.t

(** Loads a binary string into a Zip.t *)
val load : string -> t Js.Promise.t
