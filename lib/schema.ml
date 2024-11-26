type time = { halt : bool; grain : int }
type universe = { time : time }

let seed: universe = {
  time = {
    halt = false;
    grain = 0
  }
}
