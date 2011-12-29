.onAttach <- function(...) {
  if (.Platform$OS.type != "windows") return()
  
  rtools <- normalizePath("c:\\Rtools\\bin", mustWork = FALSE)
  
  if (.Platform$OS$r_arch == "x64") {
    mingw <- normalizePath("C:\\Rtools\\MinGW64\\bin", mustWork = FALSE)    
  } else {
    mingw <- normalizePath("C:\\Rtools\\MinGW\\bin", mustWork = FALSE)
  }

  if (!file.exists(rtools)) {
    packageStartupMessage("Rtools not installed in default location.")
    return()
  }

  paths <- strsplit(Sys.getenv("PATH"), ";")[[1]]
  paths <- normalizePath(paths, mustWork = FALSE)

  in_path <- any(paths == rtools)
  if (!in_path) {
    packageStartupMessage("Rtools not in path, adding automatically.")
    path <- paste(c(rtools, mingw, paths), collapse = ";")
    Sys.setenv(PATH = path)
  }
}
