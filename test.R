library(shiny)
library(shinyjs)

# 加载Tableau库
source('tableau-in-shiny-v1.2.R')

# 读取CSV文件（根据你的文件路径）
data <- read.csv("dataSet/landmarks-and-places-of-interest-including-schools-theatres-health-services-spor.csv", stringsAsFactors = FALSE)

# 定义UI
ui <- navbarPage(
  header = setUpTableauInShiny(),
  # Tableau专用标签页
  fluidRow(
    h2('Find a Good Place to Go in Melbourne'),
    tableauPublicViz(
      id = 'tableauViz',       
      url = 'https://public.tableau.com/views/A3Table/InterestPointOnMelbourneCity?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link',
      height = "600px"
    )
  )
)

# 服务器逻辑
server <- function(input, output, session) {}

# 运行应用
shinyApp(ui = ui, server = server)