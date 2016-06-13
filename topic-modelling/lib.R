stopQuietly <- function(...) {
  blankMsg <- sprintf("\r%s\r", paste(rep(" ", getOption("width")-1L), collapse=" "));
  stop(simpleError(blankMsg));
}

printf <- function(...) cat(sprintf(...))

showHelp <- function() {
    !interactive() && length(intersect(argv, c("-h", "-help", "--help")) > 0)
}
