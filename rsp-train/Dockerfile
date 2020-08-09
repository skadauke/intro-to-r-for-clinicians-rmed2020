FROM rstudio/rstudio-server-pro:latest

# Install additional system packages ------------------------------------------#

RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
        libxml2-dev \
        vim \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
# Install R packages ----------------------------------------------------------#

RUN R -e 'install.packages("devtools", repos="https://packagemanager.rstudio.com/cran/__linux__/bionic/latest")' && \
    R -e 'install.packages("tidyverse", repos="https://packagemanager.rstudio.com/cran/__linux__/bionic/latest")' && \
    R -e 'install.packages("shiny", repos="https://packagemanager.rstudio.com/cran/__linux__/bionic/latest")' && \
    R -e 'install.packages("flexdashboard", repos="https://packagemanager.rstudio.com/cran/__linux__/bionic/latest")' && \
    R -e 'install.packages("rmarkdown", repos="https://packagemanager.rstudio.com/cran/__linux__/bionic/latest")'

# Install course materials ----------------------------------------------------#

RUN git clone https://github.com/skadauke/intro-to-r-for-clinicians-rmed2020 /tmp/materials && \
    cp -a /tmp/materials/exercises /home/rmed000/ && \
    cp -a /tmp/materials/solutions /home/rmed000/ && \
    cp -a /tmp/materials/slides /home/rmed000/ && \
    rm -rf /tmp/materials
    
# Create additional users -----------------------------------------------------#

