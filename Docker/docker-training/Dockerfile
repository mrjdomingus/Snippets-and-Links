# What Docker image will we use as a starting point?
FROM node:8-alpine
# Who is the maintainer of this new image?
MAINTAINER YOUR NAME
# Install necessary tools
RUN apk add git
# Expose port 3000 so the outside world can access the app
EXPOSE 3000
# Switch to directory /app in the image (will create if not exists already)
WORKDIR /app
# Clone the todomvc repo in directory /app of the image
# The following RUN command should be entered as SINGLE line!
RUN git clone -b redis5 --single-branch https://github.com/mrjdomingus/todomvc.git 
# Switch to the directory containing the todo-app
WORKDIR /app/todomvc
# Install required npm packages for the todo-app
RUN npm install
# Partial rewrite of file components/header.vue using sed
# The following RUN command should be entered as SINGLE line!
RUN sed -i -e 's/<h1>todos<\/h1>/<h1 style="font-size:30px; margin-top:50px">todos of YOUR NAME<\/h1>/g' components/header.vue
# Impersonate root as default user when spinning up a container
USER root
# Run below command when a container is spun up from this image.
CMD ["npm", "run", "dev"]
