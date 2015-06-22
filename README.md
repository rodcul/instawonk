# INSTAWONK!

Followerwonk for Instagram

https://followerwonk.com/
--------------------------

### Project setup on local environment

```
git clone https://github.com/ashleigh090990/instawonk.git
cd instawonk
bundle
bin/rake db:create RAILS_ENV=development
rails s
```
Now visit http://localhost:3000/ in your browser!

### Seed database with 1000 users
(an error will be thrown if the rails server is running)

```bin/rake db:seed```

Reset database:

```bin/rake db:reset```


User Stories
============

As a nosey user
So that I can see important instagram accounts
I want a list of users on the homepage, showing their full name, username, profile picture, followers, following and bio

As a site admin
So that I can provide the latest detailed user data
I want to have 50,000 records in my database

As a nosey user
So that the insta accounts are easy to read
I want some pretty styling on the homepage

As a nosey user
So that I can find users of a particular topic
I want a search box that lets me search insta users by topic

Waffle
======
https://waffle.io/ashleigh090990/instawonk