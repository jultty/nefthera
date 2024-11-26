type time = { halt : bool; grain : int }
type player = { name : string; title : string }
type universe = { time : time; player: player }

let seed: universe = {
  time = {
    halt = false;
    grain = 0;
  };
  player = {
    name = "Void";
    title = "Mother of All Matter";
  };
}
