# Use the official Ruby image as the base image
FROM ruby:3.0

# Set an environment variable to avoid warnings
ENV LANG=C.UTF-8

# Install system dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Create and set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN gem install bundler && bundle install

# Copy the rest of the application code into the container
COPY . .

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
