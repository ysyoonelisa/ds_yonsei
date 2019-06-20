
library(shiny)
library(tidyverse)
library(readxl)
library(viridis)
library(ggthemes)
library(leaflet)
library(leaflet.extras)
library(extrafont)
library(viridisLite)
library(ggiraph)
library(gganimate)
library(gapminder)
library(maps)
loadfonts()

# Data
data_1 <- read_csv("raw_data_nation.csv") 
data_1() %>%
group_by(year) %>%
  summarize(suicide_per_100k = (sum(as.numeric(suicides_no)) / sum(as.numeric(population))) * 100000) %>%

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Suiside_year_world"),
  
  # Sidebar with a slider input for year movement
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Suiside_year:", min = 1986, max = 2016, value = 2000,
                  animate = animationOptions(interval = 1000), sep = "")
    ),
    
    # Show a plot
    mainPanel(
      plotOutput("trend_plot")
    )
  )
)


# Define server logic
server <- function(input, output) {
  
  selectedData<-reactive({
    req(input$year)
    
    data_1 %>% 
      filter(year <= input$year)
  })
  
  output$trend_plot <- renderPlot({
    
    selectedData %>%
      ggplot(aes(x = year, y = suicide_per_100k, color=age, group=age)) + 
      facet_grid(age ~ ., scales = "free_y") + 
      geom_point(aes(size=suicide_100K)) + 
      geom_line() +
      scale_color_viridis(discrete = TRUE) +
      theme_bw(base_family="NanumGothic") +
      labs(title="Trends Over Time, by Age",
           x="Year", y="Suicides per 100k", size="Student(10,000)") +
      scale_y_continuous(labels = scales::comma) +
      theme(legend.position = "top",
            plot.title = element_text(size=18))
    
  })
}


# Run the application 
shinyApp(ui = ui, server = server)
