
## Example

```ocaml

let ( >>| ) = Belt.Option.map
let resolve = Js.Promise.resolve

let () =
  let zip_file = Zip.make () in

  (* Create & manipulate *)
  zip_file
  |> Zip.add_file "README.md" "Hi! I'm inside this zip file!"
  |> Zip.add_file "some_binary" (Node.Fs.readFileSync "foo" `binary)
  |> Zip.folder "src"
  |> Zip.add_file "hello.py" "print \"Hello, world!\"\n"
  |> ignore;

  (* Show contents *)
  Zip.each (fun path file ->
    Printf.printf "is %s a directory? %b\n" path file##dir) zip_file;

  (* Load *)
  Node.Fs.readFileSync "my_files.zip" `binary
  |> Zip.load
  |> Js.Promise.then_ (fun zip ->
    zip
    |> Zip.folder "things"
    |> Zip.folder "stuff"
    |> Zip.get_file "something.txt"
    >>| Zip.Object.get_contents
    >>| Js.Promise.then_ (fun x -> Js.log x |> resolve)
    |> resolve)
  |> ignore;

  (* Generate *)
  Zip.generate zip_file
  |> Js.Promise.then_ (fun b ->
    Node.Fs.writeFileSync "out.zip" b `binary
    |> resolve)
  |> ignore

```
