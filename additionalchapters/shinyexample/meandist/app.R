# Shiny Example for the CSWR Course

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Random Samples and their Mean"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("N",
                        "Number of samples:",
                        min = 10,
                        max = 100,
                        value = 50),
            sliderInput("n",
                        "Number of draws per sample:",
                        min = 1,
                        max = 100,
                        value = 1),
            checkboxInput("showdensity", "Show Density?", value = FALSE, width = NULL),
            numericInput("seed", "Seed", value=NULL, min = 0, max = 10000, step = 1,
                         width = NULL)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        
        if(!is.na(input$seed)) set.seed(input$seed)
        rngmat <- matrix(rnorm(input$n*input$N), nrow = input$n, ncol=input$N)
        meanvec <- apply(rngmat, 2, mean)
        
        xseq <- seq(-5,5,length.out = 1000)
        y <- sapply(xseq, function(x){dnorm(x, mean(rngmat),sd(rngmat))})
        ymean <- sapply(xseq, function(x){dnorm(x, mean(meanvec),sd(meanvec))})
        
        ymax <- ceiling(max(c(y,ymean)))
        ymax <- ifelse(is.finite(ymax),ymax, 1)
        
        MASS::truehist(rngmat, col=rgb(0,0,1,1/6),xlim=c(-5,5),ylim=c(0,ymax),xlab="")
        if(input$showdensity) lines(xseq,y,type="l",col="blue",lwd=2)
        par(new=T)
        MASS::truehist(meanvec,col=rgb(1,0,0,1/4),xlim=c(-5,5),ylim=c(0,ymax),xlab="")
        if(input$showdensity) lines(xseq,ymean,type="l",col="red",lwd=2)
        

    })
}

# Run the application 
shinyApp(ui = ui, server = server)
