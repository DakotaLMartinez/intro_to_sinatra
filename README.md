# Intro to Sinatra

In this lecture, we'll be covering the following topics:
- HTTP and the Request-Response Cycle
- MVC (Model-View-Controller) Architecture
- Using Sinatra to build an API for a web application
- Making API calls from a client-side React application to a Sinatra API

# Project Preview

## Requirements

1. Access a Sqlite3 database using Active Record.
2. Have a minimum of two models with a one to many relationship.
3. Build out a simple **React** frontend that incorporates at least
   one GET request and one non-GET request (POST, PATCH, DELETE).
      Example: A user should be able to build out a todo list. 
      A user should be able to create a new task (POST), see all the tasks (GET), 
      update a specific task (PATCH) and delete a task (DELETE). Tasks can be grouped into many
      categories, so a task has many categories and categories have many tasks.
4. Use good OO design patterns. Have separate classes for your
   models and incorporate instance and class methods where appropriate.

## Getting Started

- Clone down the starter repo for our Sinatra API and give our project a name while we're at it.

```bash
git clone git@github.com:learn-co-curriculum/sinatra-API.git name_of_your_project
```

- move into the project directory and remove the remote pointing to the starter repo.
```bash
cd name_of_your_project
git remote rm origin
```
- We should see no printout here. To verify it worked we can run `git remote -v` and we should again see no output.

- Create a [new repository on github](https://github.com/new) for our project making sure to leave all checkboxes for adding a README.md, .gitignore and license are left blank (we can add those later if we like). 

- Copy the second code block that appears in the body of the new repo page on github by clicking on the clipboard next to it. (It should look something like this)
```bash
git remote add origin git@github.com:DakotaLMartinez/testing.git
git branch -M main
git push -u origin main
```
- Wait a moment for the push to complete, then refresh the page on GitHub and we should see our code there at this point.
- Back in our code editor, we can run `bundle install` to install the dependencies for our backend.

From there we can start building out our code. Before we do that, however, let's take a minute to talk about Sinatra, what it does and how we're going to adjust our thinking to work with it. 

## Understanding Sinatra

[Sinatra](http://sinatrarb.com/) is a DSL (Domain Specific Language) for quickly creating web applications in Ruby with minimal effort:

```rb
require 'sinatra'
get '/frank-says' do
  'Put this in your pipe & smoke it!'
end
```

So, Sinatra gives us a collection of methods we can use to create web applications. 

Okay, but what does web application mean? Simply put, a web application is a program that runs on a web server instead of on your local machine. So, in order for users to interact with a web application they have to interact with that web server. 

## Interacting with a Web Server

There are two key protocols that we can use to manage the interaction between browsers and servers: HTTP & Websockets. 

> Note that Websockets are usually used for real time communications like chat that require connections to stay open in both directions. 

For our purposes, we'll be focusing on HTTP, which is short for HyperText Transfer Protocol. 

You may recognize the HyperText part of that acronym from the HTML acronym (HyperText Markup Language). This is fitting, as HTTP was the original protocol used for delivering HTML documents from web servers to clients (web browsers). Before we get deeper into the HTTP protocol, let's talk through what this looks like from the perspective of the URL.

## Identifying Resources on the Web

The following is borrowed from an [article on MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web). 

The target of an HTTP request is called a "resource", whose nature isn't defined further; it can be a document, a photo, or anything else. Each resource is identified by a Uniform Resource Identifier (URI) used throughout HTTP for identifying resources. 

The most common form of URI is the URL (Uniform Resource Locator) commonly referred to as a web address. The following are examples.

```
https://developer.mozilla.org
https://developer.mozilla.org/en-US/docs/Learn/
https://developer.mozilla.org/en-US/search?q=URL
```

The URL contains instructions to the web server that are used to determine what information should be part of the response that it sends back to the client.

A URL is composed of different parts, some mandatory and others are optional. A more complex example might look like this:

```
http://www.example.com:80/path/to/myfile.html?key1=value1&key2=value2#SomewhereInTheDocument
```

We'll be breaking this url down into pieces below:

### Protocol

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web/mdn-url-protocol@x2.png)

This is an indicator to the browser that it should use the HTTP protocol to handle this request. Other common protocols or schemes) that might be used here include: 

|protocol|use|
|----|----|
|`mailto:`| Used to open the user's default mail program with a new email draft to the email address that follows `mailto:`|
|`file:`| Used when the browser is used to open a file that exists within the user's local computer. The path to the file will follow `file:`|
|`view-source:`| used when the browser's `View Page Source` menu option is selected. It opens the source code for the web address following `view-source:`|

Other examples can be found [in the MDN article](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web#syntax_of_uniform_resource_identifiers_uris)

### Authority

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web/mdn-url-domain@x2.png)

www.example.com is the domain name or authority that governs the namespace. It indicates which Web server is being requested. Alternatively, it is possible to directly use an [IP address](https://developer.mozilla.org/en-US/docs/Glossary/IP_Address), but because it is less convenient, it is not often used on the Web.

### Port

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web/mdn-url-port@x2.png)

:80 is the port in this instance. It indicates the technical "gate" used to access the resources on the web server. It is usually omitted if the web server uses the standard ports of the HTTP protocol (80 for HTTP and 443 for HTTPS) to grant access to its resources. Otherwise it is mandatory.

### Path

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web/mdn-url-path@x2.png)

`/path/to/myfile.html` is the path to the resource on the Web server. In the early days of the Web, a path like this represented a physical file location on the Web server. Nowadays, it is mostly an abstraction handled by Web servers without any physical reality. A bit later on, we'll use the `path` as part of the `routes` that we create.

### Query 

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web/mdn-url-parameters@x2.png)

`?key1=value1&key2=value2` are extra parameters provided to the Web server. Those parameters are a list of key/value pairs separated with the & symbol. The Web server can use those parameters to do extra stuff before returning the resource to the user. Each Web server has its own rules regarding parameters, and the only reliable way to know how a specific Web server is handling parameters is by asking the Web server owner. 

In Sinatra, we'll be able to access query parameters using a hash called `params`. The example above would be accessible to us like so:

```rb
params[:key1] #=> "value1"
params[:key2] #=> "value2"
```

### Fragment

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web/mdn-url-anchor@x2.png)

`#SomewhereInTheDocument` is an anchor to another part of the resource itself. An anchor represents a sort of "bookmark" inside the resource, giving the browser the directions to show the content located at that "bookmarked" spot. On an HTML document, for example, the browser will scroll to the point where the anchor is defined; on a video or audio document, the browser will try to go to the time the anchor represents. It is worth noting that the part after the #, also known as fragment identifier, is never sent to the server with the request. 

What this means is that clicking on anchor links within the same HTML document will not trigger a page refresh. They will tell the browser to move the viewport to the appropriate place.

## Breaking Down the HTTP Protocol

In the example URL above, we mainly focused on one HTTP verb: `GET`. When you type a url into the browser and hit enter or click on a link, generally the browser will send a GET request to a particular URL. There are other HTTP verbs that we'll use as well. MDN's article on [HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview) is a good place to review for further reading.
![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvqTN_pZMrazSvvj6FIzxMXUa8dlMkdFIXCg&usqp=CAU)

The basic idea is that the client (browser) sends a request to the server and the server sends a response back to the client. 

There are different types of HTTP requests that you should be aware of. These are called request methods. The following are the most relevant to what we'll be working with in Sinatra and later in Rails.

- [GET](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET) - for retrieving (not modifying) information
- [POST](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/POST) - for sending new information
- [PUT](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PUT) - for updating existing information
- [PATCH](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH) - for updating existing information
- [DELETE](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE) - for deleting stored information

Here's an example of what an HTTP request might look like:

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview/http_request.png)

Requests consist of the following elements:

- An HTTP method, usually a verb like GET, POST or a noun like OPTIONS or HEAD that defines the operation the client wants to perform. Typically, a client wants to fetch a resource (using GET) or post the value of an HTML form (using POST), though more operations may be needed in other cases.
- The path of the resource to fetch; the URL of the resource stripped from elements that are obvious from the context, for example without the protocol (http://), the domain (here, developer.mozilla.org), or the TCP port (here, 80).
- The version of the HTTP protocol.
- Optional headers that convey additional information for the servers. *We'll use these to indicate that we want to format the body of our requests in JSON and to receive responses in JSON format*
- Or a body, for some methods like POST, similar to those in responses, which contain the resource sent. *In our case, the body of a request might be form data extracted from the state in one of our controlled forms*

And here's an example HTTP Response

![](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview/http_response.png)

Responses consist of the following elements:

- The version of the HTTP protocol they follow.
- A status code, indicating if the request was successful, or not, and why.
- A status message, a non-authoritative short description of the status code.
- HTTP headers, like those for requests.
- Optionally, a body containing the fetched resource.

## Getting Started with Sinatra

When we're first building web applications as an API backend, our focus is on building out endpoints. An endpoint is a route to which requests can be sent in order to retrieve a particular response. When we speak about a `route` we mean a path that a user can take through your application to go from a request to a response. The main ideas we have to manage when building a route/endpoint for our API are these:

- the HTTP verb (get, post, put, patch, or delete)
- the path (`"/"`, `"/paintings"`, `"/artists"`)
- the JSON that we want to send back as a response
  - We might make a query to our database using `Painting.all` and then convert the results to JSON and return that 

An example might look like this:

```rb
get "/paintings" do
  Painting.all.to_json
end
```
  
Other HTTP details we'll have to account for:
- any headers we need to include
  - `"Accept": "application/json"`
  - `"Content-Type": "application/json"`
- Allowing requests across origins 
  - important so that we can ensure that our API will respond if we make a fetch request from another domain.
  - this is necessary because we may be deploying the react app somewhere like [Netlify](https://www.netlify.com/) while our Sinatra API is deployed on [Heroku](https://www.heroku.com/). They would both have different web addresses, so we'd need to make sure that our API on Heroku will accept requests originating from our react app on Netlify.

## Introducing MVC

Before we can hop in and start writing code, we need to understand one of the main design patterns that Ruby on Rails follows. This is important now because we'll be applying that same design pattern to our Sinatra application. This pattern is called **Model-View-Controller**, or **MVC** for short. It looks something like this:

![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVnObsmAMBWv4xbev4TmmLezWslQ87Ugtn2g&usqp=CAU)

Connecting the diagram to our HTTP request/response cycle, we can say that the Browser sends a request to our server and the controller is the part of our sinatra code that decides how to respond. It may interact with one of our Models to get data from the database and then render a response back to the browser utilizing a view. 

The way we've used React so far, we've been doing all rendering of HTML within the browser. While Sinatra has the ability to render html from the server side, we won't be doing so because we want to do that in React. Instead, we'll be thinking of our *view* code as a way of describing what the JSON representation of our data should look like when we send a response back to our client side react code.

### Key Concepts:

- **Model** - class that inherits from ActiveRecord::Base that can make queries to the DB and get a collection of objects back
- **Controller** - class that defines routes and decides how our server will respond to incoming requests
- **View** - the code that determines the structure of the JSON that the controller will respond with. Later, we can move this code to separate files called serializers, but for now, we'll keep this code right inside our controller's routes.

Models should be familiar at this point, so the new concepts are the Controller and the View. In Sinatra, the controller is where we define the routes our application will respond to. 
> This is slightly different in Rails–there are controllers in Rails as well, but the routes are defined in a separate file. In Sinatra, routes live in the controller.

For the example today, we'll be building a Sinatra API to go withthe Sinatra Paintr app that we built in Phase 2.

# [Paintr](https://github.com/DakotaLMartinez/paintr_react) App

Let's speed through the first part of this process as we've done it a bit with other domains at this point. Here's a sample of a domain model plan matching the format presented last week.

## Domain Model

Paintr application allows users to view and sort a collection of Paintings. 

### Key Features

- Users can view all the paintings
- Users van upvote paintings (add persistence)
- Users can search through paintings
- Users can view information about a painting's artist
- Users can create new paintings (new feature to build)

### Tables
- paintings
  - image (string)
  - title (string)
  - date (string)
  - width (float)
  - height (float)
  - collecting_institution (string)
  - dimensions_text (string)
  - depth (float)
  - diameter (float)
  - slug (string)
  - votes (integer)
  - artist_id (foreign key)

```rb
class Painting < ActiveRecord::Base
  belongs_to :artist
end
```
- artists
  - name (string)
  - hometown (string)
  - birthday (string)
  - deathday (string)
```rb
class Artist < ActiveRecord::Base
  has_many :paintings
end
```

Currently, the react code works by importing the data from another file within the project. We'll want to rework that code so that it pulls the data from our Sinatra API instead. Before we get there, let's take a look at the Ruby source code we're starting out with.
## Digging into the Source Code

Now, let's take some time to look through the Gemfile, Rakefile and file structure and get oriented with how the Sinatra gem changes the way we'll be thinking about our Ruby code here. 

```rb
# Gemfile 
source 'http://rubygems.org'

# rack-contrib gives us access to Rack::JSONBodyParser allowing Sinatra (which is built on Rack) to parse requests whose body is in JSON format
gem 'rack-contrib', '~> 2.3', :require => 'rack/contrib'
# sinatra-cross_origin allows our Sinatra API to respond to cross-origin requests
gem 'sinatra-cross_origin'

# these should be familiar from before. Allow us to set up our sqlite3 database with activerecord and sinatra.
gem 'activerecord', '~> 5.2'
gem 'sinatra-activerecord'
gem 'rake'

gem 'require_all'
gem 'sqlite3'

# thin is a basic web server we can use to respond to requests in production
gem 'thin'
# shotgun is a development server that will respond to requests with the latest version of our code (we don't need to restart the server when we change code–though we will need to refresh the browser unlike with the react dev server)
gem 'shotgun'
# you know about pry at this point, used to allow us to stop our code while it's running for debugging purposes.
gem 'pry'
# bcrypt is a gem used to encrypt user passwords so that they are not stored in plain text within the database.
gem 'bcrypt'
# tux adds a command called `tux` that has access to all of our classes (similar to what we did with rake console manually)
gem 'tux'

# these gems are specialized for testing our application.
group :test do
  gem 'rspec'
  gem 'capybara' # for feature tests
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git' # for resetting the test database before and after the test suite runs
end
```

And now the Rakefile:

```rb
# Rakefile
ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
# loads our rake tasks for interacting with the db
require 'sinatra/activerecord/rake'

# we can use this or just run `tux`
desc "Start our app console"
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end
```
And because the Rakefile is loading a file called `environment.rb`, located in the `config` directory, let's look at that as well:

```rb
# config/environment.rb
# sets the default environment to "development" so our normal rake commands will interact with the development database.
ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

# uses our SINATRA_ENV variable to set the name of the database file. This will create a separate database when we run `rspec`
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

# this loads up our application controller and then all files in the app directory.
require './app/controllers/application_controller'
require_all 'app'
```

Lastly, there's an important file that all rack based applications have to have. It's called `config.ru`.

```rb
# config.ru
require './config/environment'

use Rack::JSONBodyParser
run ApplicationController
```

Again, this loads up our environment file so all of our code and our database connection is accessible. Next the `use` line enables the Rack middleware that will allow us to send a JSON formatted body in our requests. Finally, the `run` method accepts a controller and allows our app to respond to all of the routes defined therein. If you want to create multiple controllers, you'll need to add them to the config.ru file like so:

```rb
# config.ru
require './config/environment'

use Rack::JSONBodyParser
run ApplicationController
use PaintingsController
use ArtistsController
```

Later on, you will want to spread out your routes into multiple controllers, and there are more conventions you'll learn about when we get to rails. But, because we have so few routes today, we'll keep them all in the `ApplicationController`. Speaking of, let's take a closer look at the `ApplicationController` file:

```rb
# app/controllers/application_controller.rb
class ApplicationController < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, "*" 
    set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
    set :expose_headers, ['Content-Type']
  end

  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    200
  end

  # method "/path" do
    
  # end

end
```

Both the `configure` and `options` methods and the blocks we pass are designed to ensure that our Sinatra API is properly configured to respond to cross-origin (CORS) requests. Because some browsers will send an options request before performing a CORS request, we allow options requests and we indicate which request methods and headers are allowed within responses.

Now that we've gotten all of that boilerplate and configuration behind us, let's start building out our API endpoints by adding routes to the application_controller.

## Our First API endpoint

Let's jump in and try some stuff out. First, let's add this to the application controller.
```rb
get "/hi" do 
  { hello: "world" }
end
```

Next, we'll use `shotgun` to start our development server. 

```bash
shotgun
```

You should see something like this:

```bash
== Shotgun/Thin on http://127.0.0.1:9393/
2021-06-21 21:50:20 -0700 Thin web server (v1.8.1 codename Infinite Smoothie)
2021-06-21 21:50:20 -0700 Maximum connections set to 1024
2021-06-21 21:50:20 -0700 Listening on 127.0.0.1:9393, CTRL+C to stop
```

Now, let's go over to the browser and visit:

```
http://localhost:9393/hi
```

Uh oh!

![](/img/non-string-error.png)

OK, so let's break this down. Rack is expecting the return value for the route to be a string, but the body is yielding a non string value. We know we want our api to repsond with JSON, so let's convert the hash to json:

```rb
get "/hi" do 
  { hello: "world" }.to_json
end
```

And try it again:

![](/img/json-output.png)

If it doesn't look so nice for you, I recommend installing the [JSONView](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en) chrome extension. After installing, reload the page in the browser and you should see the same formatting as the image above. 

So, when it comes to building out an API endpoint (route) these are the 3 things we need to do:

1. define the request method (get/post/patch/put/delete)
2. define the path to the route ('/hi')
3. pass a block that returns a JSON formatted string (which will be our response body)

## Pulling Data from the Database

For our case, we'll want to have an endpoint `/paintings` that will return an array of paintings. This will replace the import we used in our react code previously. For this to work, we need to have the two models and associated database tables created. 

```bash
rake db:create_migration NAME=create_artists
```

```rb
class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :hometown
      t.string :birthday
      t.string :deathday
    end
  end
end
```

Then

```bash
rake db:create_migration NAME=create_paintings
```

```rb
class CreatePaintings < ActiveRecord::Migration[5.2]
  def change
    create_table :paintings do |t|
      t.string :image, null: false
      t.string :title, null: false
      t.string :date
      t.string :dimensions_text
      t.float :width
      t.float :height
      t.string :collecting_institution
      t.float :depth
      t.float :diameter
      t.string :slug
      t.integer :votes
      t.references :artist
    end
  end
end
```

Then 

```bash
rake db:migrate
```

Then we'll need models for `Artist` and `Painting`:

```rb
# app/models/artist.rb
class Artist < ActiveRecord::Base
  has_many :paintings

  validates :name, presence: true
end
```

```rb
# app/models/painting.rb
class Painting < ActiveRecord::Base
  belongs_to :artist
  validates :title, :image, presence: true
  validates :slug, uniqueness: true
end
```

And finally, we'll add some seeds using the data from `painting_data.js` in the paintr react code as a guide.

```rb
# db/seeds.rb
[Painting, Artist].each{|m| m.destroy_all }

artist_data = [
  {
    name: 'Petrus Christus',
    hometown: 'Baarle-Hertog, Belgium',
    birthday: '1410',
    deathday: '1475'
  },
  {
    name: 'Johannes Vermeer',
    hometown: 'Delft, Netherlands',
    birthday: '1632',
    deathday: '1675'
  },
  {
    name: 'Rembrandt van Rijn',
    hometown: 'Leiden, Netherlands',
    birthday: '1606',
    deathday: '1669'
  },
  {
    name: 'Peter Paul Rubens',
    hometown: 'Siegen, Westphalia',
    birthday: '1577',
    deathday: '1640'
  },
  {
    name: 'Bartholomaeus Spranger',
    hometown: 'Antwerp, Belgium',
    birthday: '1546',
    deathday: '1611'
  },
  {
    name: 'Frans Hals',
    hometown: 'Antwerp, Belgium',
    birthday: '1582',
    deathday: '1666'
  }
]

artists = artist_data.map{|attributes| Artist.create(attributes)}

painting_data =  [
  {
    date: '1446',
    dimensions_text: '11 1/2 Ã— 8 1/2 in',
    height: 11.5,
    width: 8.5,
    slug: 'petrus-christus-portrait-of-a-carthusian',
    title: 'Portrait of a Carthusian',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/pVc7CubFzVlPhbErTAqyYg/medium.jpg',
    artist: artists.first,
    votes: 64
  },
  {
    date: 'ca. 1665â€“1667',
    dimensions_text: '17 1/2 Ã— 15 3/4 in',
    height: 17.5,
    width: 15.75,
    slug: 'johannes-vermeer-study-of-a-young-woman',
    title: 'Study of a Young Woman',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/pLcp7hFbgtfYnmq-b_LXvg/medium.jpg',
    artist: artists[1],
    votes: 21
  },
  {
    date: '1665â€“1667',
    dimensions_text: '44 3/8 Ã— 34 1/2 in',
    height: 44.375,
    width: 34.5,
    slug: 'rembrandt-van-rijn-portrait-of-gerard-de-lairesse',
    title: 'Portrait of Gerard de Lairesse',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/6b4QduWxeA1kSnrifgm2Zw/medium.jpg',
    artist: artists[2],
    votes: 30
  },
  {
    date: '1600â€“1626',
    dimensions_text: '10 7/16 Ã— 6 15/16 in',
    height: 10.4375,
    width: 6.9375,
    slug: 'peter-paul-rubens-bust-of-pseudo-seneca',
    title: 'Bust of Pseudo-Seneca',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/RcoWk2PHQq6yqX7dpSyt-g/medium.jpg',
    artist: artists[3],
    votes: 96
  },
  {
    date: '1449',
    dimensions_text: '39 3/8 Ã— 33 3/4 in',
    height: 39.375,
    width: 33.75,
    slug: 'petrus-christus-a-goldsmith-in-his-shop',
    title: 'A Goldsmith in his Shop',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/0-QXL43Ox2QgwqkYoCjAjg/medium.jpg',
    artist: artists.first,
    votes: 80
  },
  {
    date: 'ca. 1635',
    dimensions_text: '80 1/4 Ã— 62 1/4 in',
    height: 80.25,
    width: 62.25,
    slug:
      'peter-paul-rubens-rubens-his-wife-helena-fourment-1614-1673-and-their-son-frans-1633-1678',
    title:
      'Rubens, His Wife Helena Fourment (1614â€“1673), and Their Son Frans (1633â€“1678)',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/miBYVNx3iV4AtBWgierQrg/medium.jpg',
    artist: artists[3],
    votes: 47
  },
  {
    date: '1653',
    dimensions_text: '56 1/2 Ã— 53 3/4 in',
    height: 56.5,
    width: 53.75,
    slug: 'rembrandt-van-rijn-aristotle-with-a-bust-of-homer',
    title: 'Aristotle with a Bust of Homer',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/q5OTabe7_Bu8kfxzK_UUag/medium.jpg',
    artist: artists[2],
    votes: 46
  },
  {
    date: 'ca. 1662',
    dimensions_text: '18 Ã— 16 in',
    height: 18,
    width: 16,
    slug: 'johannes-vermeer-young-woman-with-a-water-pitcher',
    title: 'Young Woman with a Water Pitcher',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/pdRjIGw58ecojporcDG0_w/medium.jpg',
    artist: artists[1],
    votes: 95
  },
  {
    date: '1660',
    dimensions_text: '31 5/8 Ã— 26 1/2 in',
    height: 31.625,
    width: 26.5,
    slug: 'rembrandt-van-rijn-self-portrait-1661',
    title: 'Self-Portrait',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/7EthRD-B57oEJovV77WH0Q/medium.jpg',
    artist: artists[2],
    votes: 41
  },
  {
    date: '1617',
    dimensions_text: '17 9/16 Ã— 9 3/4 in',
    height: 17.5625,
    width: 9.75,
    slug: 'peter-paul-rubens-portrait-of-nicolas-trigault-in-chinese-costume',
    title: 'Portrait of Nicolas Trigault in Chinese Costume',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/-VmrYlEp4nXEjtSa8-C7PA/medium.jpg',
    artist: artists[3],
    votes: 37
  },
  {
    date: 'ca. 1580â€“1585',
    dimensions_text: '16 1/4 Ã— 12 5/8 in',
    height: 16.25,
    width: 12.625,
    slug: 'bartholomaeus-spranger-diana-and-actaeon',
    title: 'Diana and Actaeon',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/FaqwCA1k4QjgaiGN8PElUQ/medium.jpg',
    artist: artists[4],
    votes: 30
  },
  {
    date: '1645',
    dimensions_text: '30 5/16 Ã— 25 3/16 in',
    height: 30.3125,
    width: 25.1875,
    slug: 'frans-hals-willem-coymans',
    title: 'Willem Coymans',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/gXMChrE5re4HdlIP6__LXQ/medium.jpg',
    artist: artists[5],
    votes: 25
  }
];
  
paintings = painting_data.map{|attributes| Painting.create(attributes)}

Pry.start
```

If we run the seeds and try out the following in the pry:

```rb
Artist.first.paintings
```

We should see something like this:

```rb
=> [#<Painting:0x00007f86e9b3b588
  id: 1,
  image: "https://d32dm0rphc51dk.cloudfront.net/pVc7CubFzVlPhbErTAqyYg/medium.jpg",
  title: "Portrait of a Carthusian",
  date: "1446",
  dimensions_text: "11 1/2 Ã— 8 1/2 in",
  width: 8.5,
  height: 11.5,
  collection_institution: nil,
  depth: nil,
  diameter: nil,
  slug: "petrus-christus-portrait-of-a-carthusian",
  votes: 64,
  artist_id: 13>,
 #<Painting:0x00007f86e9b3b358
  id: 5,
  image: "https://d32dm0rphc51dk.cloudfront.net/0-QXL43Ox2QgwqkYoCjAjg/medium.jpg",
  title: "A Goldsmith in his Shop",
  date: "1449",
  dimensions_text: "39 3/8 Ã— 33 3/4 in",
  width: 33.75,
:
```

Then, if we try this:

```rb
Painting.first.artist
```

We should see something like this:

```rb
=> #<Artist:0x00007f86e6c672e8
 id: 13,
 name: "Petrus Christus",
 hometown: "Baarle-Hertog, Belgium",
 birthday: "1410",
 deathday: "1475">
```

Okay, now that we've got artists and paintings in our database, let's work on getting them into the browser when we make a request to an api endpoint. To do that, we'll add another method to the `ApplicationController`. Within it, we'll want to get all of the paintings and then [convert the collection to JSON](https://apidock.com/rails/ActiveRecord/Serialization/to_json). 

```rb
# app/controllers/application_controller.rb
class ApplicationController < Sinatra::Base
  # ...

  get "/hi" do 
    { hello: "world" }.to_json
  end

  get "/paintings" do 
    paintings = Painting.all
    paintings.to_json
  end

end

```

And to test this out, let's open the following url in our browser (with the shotgun development server still running)

```
http://localhost:9393/paintings
```

It should look something like this:

![](/img/paintings-json.png)

Let's take a closer look at the data structure we had in our javascript:

```js
const paintingData =  [
  {
    id: '59bd5a519c18db5297a32479',
    collecting_institution: '',
    date: '1446',
    dimensions_text: '11 1/2 Ã— 8 1/2 in',
    height: 11.5,
    width: 8.5,
    depth: null,
    diameter: null,
    slug: 'petrus-christus-portrait-of-a-carthusian',
    title: 'Portrait of a Carthusian',
    image:
      'https://d32dm0rphc51dk.cloudfront.net/pVc7CubFzVlPhbErTAqyYg/medium.jpg',
    artist: {
      name: 'Petrus Christus',
      hometown: 'Baarle-Hertog, Belgium',
      birthday: '1410',
      deathday: '1475'
    },
    votes: 64
  },
  // ...
```

In looking at this, one of the main things that stands out is that `artist` is showing up as a key with artist data as a value in our JS data. But, within our API endpoint response, we're seeing the `artist_id` foreign key and nothing more. If we want to include the associated artist in the json we get back, we can pass an option to the `to_json` method when we call it from the controller.

```rb
get "/paintings" do 
  paintings = Painting.all
  paintings.to_json(include: :artist)
end
```

Now, when we refresh the endpoint in our browser, we get the following:

![](/img/paintings-json-with-artist.png)

Great! Now, we can replace our frontend code that imports the data directly with code that will fetch the paintings from our API endpoint. Here's the original code:

```js
// Component Imports
import Painting from './Painting';

// Hooks Imports
import { useState } from 'react';

// Material-UI Imports
import { Container, Button, Box, Grid, TextField } from '@material-ui/core';
import paintingsData from './painting_data';

function PaintingsList() {

  const [paintings, paintingsSetter] = useState(paintingsData);
  const [sorted, sortedSetter] = useState(false);


  // Create callback function to change Parent's "paintings" state to be sorted by votes
  function sortPaintings() {
    
    // Use the spread (...) operator to clone the state / prompt React to ackowledge the state change
    let originalList = [...paintingsData];
    
    const sortedList = originalList.sort((currentPainting, nextPainting) => {
      let votesCurrentPainting = currentPainting.votes;
      let votesNextPainting = nextPainting.votes;

      // Compare the two vote amounts
      if (votesCurrentPainting < votesNextPainting) return 1;
      if (votesCurrentPainting > votesNextPainting) return -1;
      return 0;
    });
    paintingsSetter(sortedList);
  }

  function removeSort() {
    paintingsSetter(paintingsData)
  }

  function toggleSort() {
    if (sorted) {
      removeSort();
    } else {
      sortPaintings();
    }
    sortedSetter(!sorted);
  }
  
  const [searchTerm, setSearchTerm] = useState("");

  function searchResults() {
    return paintings.filter(painting => {
      const title = painting.title.toLowerCase();
      return title.includes(searchTerm.toLowerCase())
    })
  }

  function handleSearch(e) {
    setSearchTerm(e.target.value);
  }

  return(
    <div>

      <Container align="center">
        <h1>Paintings</h1>
        <hr />
        {/* <Box width={1/3}> */}
        <Box display="flex" style={{ justifyContent: "space-between" }}>
          <TextField 
            id="filled-basic" 
            label="Search" 
            variant="filled" 
            onChange={handleSearch}
            />
        
            <Button variant="contained" onClick={toggleSort}>{sorted ? 'Unsort Paintings' : 'Sort Paintings'}</Button>  
        </Box>
        {/* </Box> */}
        

        {/* Implement Material-UI */}
        <Box m={5}>
          <Grid
            container
            spacing={10}
            direction="row"
          >
            {
              searchResults().map(painting => (
                <Grid
                  item
                  xs={3}
                  key={painting.id}
                >
                  <Painting
                    painting={painting}
                  />
                </Grid>
              ))
            }
          </Grid>
        </Box>
      </Container>
    
    {/* </> */}
    </div>
  );
}

export default PaintingsList;
```

We'll want to remove the import here and add a useEffect that will run when the component mounts to load the paintings from the API. We'll only need to edit the beginning of the file

```js
// src/PaintingsList.js
// Component Imports
import Painting from './Painting';

// Hooks Imports
import { useState, useEffect } from 'react';

// Material-UI Imports
import { Container, Button, Box, Grid, TextField } from '@material-ui/core';

function PaintingsList() {

  const [paintingsData, paintingsDataSetter] = useState([])
  const [paintings, paintingsSetter] = useState([]);
  const [sorted, sortedSetter] = useState(false);

  useEffect(() => {
    fetch("http://localhost:9393/paintings")
      .then((response) => response.json())
      .then(paintings => {
        console.log(paintings);
        paintingsDataSetter(paintings);
        paintingsSetter(paintings)
      })
  }, [])
  // ...
```

The main things that are different here are:
- we're replacing the `paintingsData` import with a state hook for `paintingsData` and we're setting the initial value for both that and the `paintings` state variable to an empty array.
- we're adding a useEffect hook import
- we're invoking useEffect when the component mounts to:
  - trigger a fetch request to load the paintings from the API
  - parse the JSON string so it's a JavaScript array of objects
  - log the paintings array to the console
  - set that array as the value for both `paintingsData` and `paintings`. 

Here are some screenshots of the devtools so we can see this in action.

![](/img/paintings-via-fetch-console.png)

Network Headers tab

![](/img/paintings-via-fetch-network-headers.png)

Network Preview tab
![](/img/paintings-via-fetch-network-preview.png)

If we refresh the page here, you'll notice that the paintings are invisible at first and then become visible shortly after the initial load. This is because they are now being loaded asynchronously via fetch. Before, they were loaded via the import, which was synchronous, so we didn't notice a delay.

## Creating new records via fetch requests to the API

Okay, so what's different when we create a painting?

- we need to send a **POST** request instead of **GET**.
- we'll need to send a **body** along with the request containing information about the painting
- we'll need to send **headers** along with the request indicating that we'll be sending and want to receive JSON data.
- we'll need to access the data in the body of the request within our Sinatra API to create a new Painting (and Artist). Sinatra makes the body of a **POST** request available to us within the `params` hash.

### Building the API endpoint.

For this, we'll want to add a route to create a new painting:

```rb
# app/controllers/application_controller.rb
post "/new_painting" do
  puts params.inspect
  params.inspect
end
```
We'll come back and fill this in later, but for now let's get it working so we can see a response when we send a request.

For the react side, we'll need to open up the PaintingForm component. We'll take a look at its current form here:

```js
// import useState hook to initialize our states and make them re-settable
import { useState } from 'react';
import { useHistory } from 'react-router-dom'
import { TextField, Container, Box, Button } from '@material-ui/core';

function PaintingForm() {
  const history = useHistory();

  const [imgUrl, imgUrlSetter] = useState("");
  const [title, titleSetter] = useState("");
  const [artistName, artistNameSetter] = useState("");
  const [date, dateSetter] = useState("");
  const [width, widthSetter] = useState("");
  const [height, heightSetter] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    // make fetch request here
    history.push('/')
  }

  return(
    <Container>
      <Box
        mx="auto"
        // width={1 / 2}
        align="center"
      >
        <h1> Add a new Painting</h1>
        
        <form onSubmit={handleSubmit}>
          {/* Controlled Input */}
            <TextField 
              type="text"
              placeholder="ImgURL"
              variant="filled"
              onChange={(e) => imgUrlSetter(e.target.value)}
              value={imgUrl}
              style={{
                margin: "0.5em 0",
                display: "block"
              }}
            />
          

            <TextField 
              type="text"
              placeholder="title"
              variant="filled"
              onChange={e => titleSetter(e.target.value)}
              value={title}
              style={{
                margin: "0.5em 0",
                display: "block"
              }}
            />
          

            <TextField 
              type="text"
              placeholder="Artist Name"
              variant="filled"
              onChange={e => artistNameSetter(e.target.value)}
              value={artistName}
              style={{
                margin: "0.5em 0",
                display: "block"
              }}
            />
          

            <TextField 
              type="text"
              placeholder="date"
              variant="filled"
              onChange={e => dateSetter(e.target.value)}
              value={date}
              style={{
                margin: "0.5em 0",
                display: "block"
              }}
            />
          

            <TextField 
              type="number"
              placeholder="width"
              variant="filled"
              onChange={e => widthSetter(e.target.value)}
              value={width}
              style={{
                margin: "0.5em 0",
                display: "block"
              }}
            />
          

            <TextField 
              type="number"
              placeholder="height"
              variant="filled"
              onChange={e => heightSetter(e.target.value)}
              value={height}
              style={{
                margin: "0.5em 0 1em",
                display: "block"
              }}
            />

          <Button variant="contained" color="primary" type="submit">Add New Painting</Button>
        </form>
      </Box>
    </Container>
  )
}

export default PaintingForm
```

Again, the changes here will be near the top of the component. We'll need to update our submit handler to:

- Submit event handler to the form should
  - preventDefault
  - send a **POST** request to our API with:
    - the form data in the body
    - headers to indicate we want to send/receive JSON data
    - console.log the response from the API
    - redirect us to the home page where all paintings are displayed

To do this, we'll need to pass in [options to our fetch request](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) as a second argument. 

The three options we'll need are:
- **method** - post
- **headers**  
  - "Accept": "application/json"
  - "Content-Type": "application/json"
- **body** - form data as string in JSON format

To get a sense of what the body should look like, we need to look at the model and schema for the record we're about to create–in this case `Painting`.

```rb
# app/models/painting.rb
class Painting < ActiveRecord::Base
  belongs_to :artist
  validates :title, :image, presence: true
  validates :slug, uniqueness: true
end
# db/schema.rb
create_table "paintings", force: :cascade do |t|
  t.string "image", null: false
  t.string "title", null: false
  t.string "date"
  t.string "dimensions_text"
  t.float "width"
  t.float "height"
  t.string "collection_institution"
  t.float "depth"
  t.float "diameter"
  t.string "slug"
  t.integer "votes"
  t.integer "artist_id"
  t.index ["artist_id"], name: "index_paintings_on_artist_id"
end
```

Our form has inputs for `imageUrl`, `title`, `artistName`, `date`, `width`, & `height`. We have database columns for 4 of those, so we can pass them along unaltered and we should be good to go. The 2 that don't match are `imageUrl` and `artistName`.

- `imageUrl` is actually `image` in our db, so we can rename the key we pass into the body object that we stringify and pass along.
- `artistName` is actually `artist_id` in our db. For this, we'll want to add a method called `artist_name` to the `Painting` model that can:
  - accept an artist_name as an argument 
  - find_or_create an artist by that name
  - associate the painting with that created artist

  ```rb
  class Painting < ActiveRecord::Base
    belongs_to :artist
    validates :title, :image, presence: true
    validates :slug, uniqueness: true

    def artist_name=(artist_name)
      self.artist = Artist.find_or_create_by(name: artist_name)
    end
  end
  ```
From the react end, we'll configure our fetch to send the body in such a way that our Sinatra API backend will be able to use the data to create a new Painting (and associated artist)
```js
// ... imports

function PaintingForm() {
    // create a state to keep track of ImgURL
    // const [stateName, setterMethod] = useState(initialStateValue);
  const history = useHistory();

  const [imgUrl, imgUrlSetter] = useState("");
  const [title, titleSetter] = useState("");
  const [artistName, artistNameSetter] = useState("");
  const [date, dateSetter] = useState("");
  const [width, widthSetter] = useState("");
  const [height, heightSetter] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    fetch("http://localhost:9393/new_painting", {
      method: 'POST',
      headers: {
        "Accept": "application/json", 
        "Content-Type": "application/json"
      }, 
      body : JSON.stringify({
        image: imgUrl,
        title,
        artist_name: artistName,
        date,
        width,
        height
      })
    })
      .then(console.log)
    history.push('/')
  }
  // ...
```

Now, let's try this out by visiting our app in the react dev server and seeing if we can see the form data from react within our sinatra api backend. We'll be using the following values:

**imgUrl**
```
https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/300px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg
```
**title**
```
Mona Lisa
```
**Artist Name**
```
Leonardo Da Vinci
```
**date**
```
c. 1503–1506, perhaps continuing until c. 1517
```
**width**
```
21
```
**height**
```
30
```

Now, if we visit the app in the browser, fill in the form to create a new painting, and look at the terminal running our Shotgun server, we can see the output of our puts statement:

```
{"image"=>"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/300px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg", "title"=>"Mona Lisa", "artist_name"=>"Leonardo Da Vinci", "date"=>"c. 1503–1506, perhaps continuing until c. 1517", "width"=>"21", "height"=>"20"}
```

Now that we have this, all we need is to:
- Painting.create(params)
  - This is actually unsafe, as it would allow users to call whatever method they would want on the new painting object. So, it would be better to select just what we want from the params hash first:
  ```rb
  painting_params = params.select do |key| 
    ["image", "title", "artist_name", "date", "width", "height"].include?(key)
  end
  Painting.create(painting_params)
  ```

So the route in our controller will look like this:

```rb
post "/new_painting" do 
  puts params.inspect
  painting_params = params.select do |key|
    ["image", "title", "artist_name", "date", "width", "height"].include?(key)
  end
  painting = Painting.create(painting_params)
  painting.to_json
end
```

## Handling Upvoting

If we wanted to handle upvoting within the current domain model, we would be updating a painting. So, in that case, we'd want to send a patch request to make the update. Because we're only going to be handling updating the votes by one, we don't need to send any additional information with the request. But, we do need to have a way of identifying which painting we're updating. We can do this in one of two ways:

1. Include a URL parameter for the painting's id in the route we create
2. Add the painting's id to the body of the patch request we send

While both would work, if we're trying to figure out which record to update, we'll generally see that done with the 1st path.

```rb
# app/controllers/application_controller.rb
patch "/paintings/:id/upvote" do 
  painting = Painting.find(params[:id])
  painting.increment!(:votes)
  painting.to_json
end
```

If we rework our react component, we can tweak it so that it sends a fetch request to update the backend and only update the DOM after the response from the API is received.