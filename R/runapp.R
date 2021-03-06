#' Run a ShinyDashboard App created using ShinyBones
#'
#' @export
#'
sb_create_app <- function(app_dir = ".", data_global = list()){
  config <- yaml::read_yaml(file.path(app_dir, '_site.yml'))
  # UI ----
  ui <- function(request){
    shinydashboard::dashboardPage(
      # Header ----
      shinydashboard::dashboardHeader(title = config$name),

      # Sidebar ----
      shinydashboard::dashboardSidebar(
        sb_create_sidebar(config, data_global)
      ),

      # Body -----
      shinydashboard::dashboardBody(
        sb_create_tab_items(config, data_global)
      )
    )
  }

  # Server -----
  server <- function(input, output, session){
    sb_call_modules(config, data_global)
  }

  shiny::shinyApp(ui = ui, server = server)
}
