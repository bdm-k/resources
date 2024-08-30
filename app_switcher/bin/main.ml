let aerospace_bin = "/opt/homebrew/bin/aerospace"
let open_bin = "/usr/bin/open"

type window = { id: int; app: string }

(* Parse query results from AeroSpace *)
let rec parse input =
  let parse_line s = Scanf.sscanf s "%i | %s@|"
    (fun id app -> { id = id; app = String.trim app }) in
  try
    let line = input_line input in
    (parse_line line) :: (parse input)
  with
    End_of_file -> []

(*
Get the next window of the specified window in 'lst'.
Return None if no matching window is found.
*)
let rec next_window lst id =
  match lst with
  | curr :: next :: rest -> (
    if curr.id == id then Some next
    else next_window (next :: rest) id)
  | _ -> None

let _ =
  let app_to_focus = Sys.argv.(1) in

  (* Get the currently focused window *)
  let input = Unix.open_process_args_in
    aerospace_bin [|"aerospace"; "list-windows"; "--focused"|] in
  let curr_window = parse input |> List.hd in

  (* If the user wants to focus a different app *)
  if curr_window.app <> app_to_focus then
    Unix.execv open_bin [|"open"; "-a"; app_to_focus|];

  (* If the user wants to focus another window of the same app *)
  let input = Unix.open_process_args_in
    aerospace_bin [|"aerospace"; "list-windows"; "--all"|] in
  let app_windows =
    parse input
    |> List.filter (fun w -> w.app = app_to_focus)
    |> List.sort (fun w0 w1 -> w0.id - w1.id) in
  let window_to_focus = next_window app_windows curr_window.id in
  let window_to_focus = match window_to_focus with
  | Some w -> w
  | None -> List.hd app_windows in
  Unix.execv
    aerospace_bin
    [|"aerospace"; "focus"; "--window-id"; string_of_int window_to_focus.id|]
