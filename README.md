# README


## Description

### Problem statement
Create an application that helps users find the most relevant prompts based on entered
words
### Objective
Deliver an application prototype to answer the above problem statement.
By prototype, we mean:
- something usable, yet as simple as possible
- UI / design is not important
We expect to use this prototype as a starting point to discuss current implementation details and
ideas for improvement.
Tech must-haves

- Ruby on Rails
- MySQL or PostgreSQL
- A search engine such as ElasticSearch or any other
- A web interface (can be VERY simple)
### Bonus points
- Application is dockerized
- Application is hosted on Heroku
### Data
[Data Set](https://huggingface.co/datasets/Gustavosta/Stable-Diffusion-Prompts)

Source code of the application hosted on Github

### Conclusion
We wish you the best of luck with the assignment and look forward to reviewing your
submission. If you have any questions or concerns, please do not hesitate to reach out to us.

### Ruby version

```ruby-3.0.3```

* Configuration

```
docker-compose build
docker-compose up

```

### Database creation
```
docker-compose run web rails db:create
docker-compose run web rails db:migrate

```

### Database initialization

docker-compose run web rails db:seed

### How to run the test suite
```
docker-compose run web rspec
```




