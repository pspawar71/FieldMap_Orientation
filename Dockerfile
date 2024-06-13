# Use an official R runtime as a parent image
FROM rocker/shiny:4.0.5

# Install necessary R packages
RUN R -e 'install.packages(c("shiny", "leaflet", "sf"))'

# Copy the app directory into the Docker image
COPY ./app /srv/shiny-server/FieldMap_Orientation


# Expose port 3838 to the outside world
EXPOSE 3838

# Run the app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/FieldMap_Orientation')"]
