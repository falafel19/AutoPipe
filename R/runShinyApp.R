#' @export runShinyApp
runShinyApp=function() {
  appDir <- system.file("shiny-examples", "myapp", package = "AutoPipe")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}