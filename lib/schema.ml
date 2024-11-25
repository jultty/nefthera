type time = { halt : bool; grain : int }
type universe = { time : time }

let seed = {
  time = {
    halt = false;
    grain = 0
  }
}
