# Use an official R runtime as a parent image
FROM rocker/shiny-verse:latest

# Install necessary R packages
RUN R -e 'install.packages(c("shiny", "leaflet", "sf"))'

# Copy the app directory into the Docker image
COPY ./app /srv/shiny-server/app

# Expose port 3838 to the outside world
EXPOSE 3838

# Run the app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/app')"]