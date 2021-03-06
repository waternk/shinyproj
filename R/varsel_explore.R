#' Interactive variable selection using projpred
#'
#' Visualize the results of the variable selection using shiny.
#'
#' @param fit_cv An object returned by \link[=cv_varsel]{cv_varsel}.
#' @param nv Maximum number of variables in the submodel. Defaults to
#' \code{min(12, length(fit_cv$varsel$vind))}.
#'
#' @export
varsel_explore <- function(fit_cv, nv = min(12, length(fit_cv$varsel$vind))) {

  # check that cv_varsel has been run and perform the projection
  if(!validate_varsel(fit_cv))
    stop("Input does not contain cross-validated variable selection information.")

  server_data <- extract_data(fit_cv, nv)
  if (is.null(.GlobalEnv$.shinyproj_logs)) {
    .GlobalEnv$.shinyproj_logs <-
      tibble(cur = list(), new = list(),
             type = character(0), time = character(0))
  }
  log_event(empty_numeric(), empty_numeric(), "start")

  app <- list(ui = get_ui(), server = get_server(server_data))
  runApp(app)
}
