type time = { halt : bool; grain : int }
type player = { name : string; title : string }
type meta = { message : string }
type universe = { time : time; player: player; meta: meta }

let seed: universe = {
  time = {
    halt = false;
    grain = 0;
  };
  player = {
    name = "Void";
    title = "Mother of All Matter";
  };
  meta = {
    message =
      "Whoever has spun Time into motion, know:\n" ^
      "I am The Beholder, and I will carry your words into the Realm.\n" ^
      "If you are lost, be wise enough to ask for help.";
  }
}
