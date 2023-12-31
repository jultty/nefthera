use super::print;
use crate::base::space::entity::EntityMap;
use crate::util::instruction::Instruction;
use crate::util::logger::log;
use crate::util::logger::LoggerOptions;
use std::env;

pub fn parse_input<'a>(input: &'a str, entities: &'a EntityMap) -> Result<Instruction<'a>, String> {
    let log_opts = LoggerOptions { debug: false };

    match input.split_whitespace().next() {
        Some("move") => {
            log("Action triggered: move", None, &log_opts);
            let v: Vec<&str> = input.split(' ').collect();

            // TODO parse based on n/s/e/w/, f/b/l/r, u/d, respective full words
            Ok(Instruction::new_move_instruction(
                true,
                v[1].parse().unwrap(),
                v[2].parse().unwrap(),
                v[3].parse().unwrap(),
                entities,
            ))
        }
        Some("passage") => {
            log("Action triggered: enter passage", None, &log_opts);
            let v: Vec<&str> = input.split(' ').collect();
            Ok(Instruction::new_enter_passage_instruction(
                true,
                v[1..v.len()].join(" "),
                entities,
            ))
        }
        Some("sense") => {
            log("Action triggered: sense", None, &log_opts);
            Ok(Instruction::new_sense_instruction(true, None, entities))
        }
        Some("quit" | "exit") => {
            log("Action triggered: quit", None, &log_opts);
            Ok(Instruction::new_quit_instruction(true, entities))
        }
        _ => {
            log("Unknown command:", Some(input), &log_opts);
            Err("Unknown command".to_string())
        }
    }
}

// argument parsing

pub struct Arguments {
    pub debug: bool,
    pub start: bool,
    pub demo: bool,
}

pub fn parse_arguments(log_opts: &mut LoggerOptions) -> Arguments {
    let arguments: Vec<String> = env::args().collect();

    let mut return_arguments: Arguments = Arguments {
        debug: false,
        start: false,
        demo: false,
    };

    for arg in &arguments {
        match arg.as_str() {
            "--debug" => {
                return_arguments.debug = true;
                log_opts.debug = true;
                log("Debug flag set", None, log_opts);
            }
            "--demo" => {
                return_arguments.demo = true;
                log("Demo flag set", None, log_opts);
            }
            "--start" => return_arguments.start = true,
            _ => log("Invalid argument", Some(arg), log_opts),
        }

        log("Read argument", Some(arg), log_opts);
    }

    log("Done reading arguments", None, log_opts);

    return_arguments
}

// from clap/examples/repl.rs
pub fn readline() -> Result<String, String> {
    print("> ", false);

    let mut buffer = String::new();
    std::io::stdin()
        .read_line(&mut buffer)
        .map_err(|e| e.to_string())?;
    Ok(buffer)
}
