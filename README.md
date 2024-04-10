# Simple Blog API

An example demo simple blog API web application using the [Athena Framework](https://athenaframework.org/#athena-framework).
Demonstrates what a real-world API using the framework would look like, with some [considerations](#considerations).

The blog is intended to showcase various framework features while still being approachable and not overly complex.
This includes:

* A controller to handle CRUD operations on an `Article` entity, leveraging a simple repository pattern ORM
* A custom [ACON::Command](https://athenaframework.org/Console/Command/) to run DB migrations
* A simple request/transaction ID implementation using a dedicated [service](https://athenaframework.org/why_athena/#services) and [Event Listener](https://athenaframework.org/EventDispatcher/Annotations/AsEventListener/)
* A database focused [ATHR::Interface](https://athenaframework.org/Framework/Controller/ValueResolvers/Interface/) to resolve an entity from the DB as a controller action argument
* Unit/integration test on all of the above

The application was created using the [Athena Skeleton](https://github.com/athena-framework/skeleton) template,
which would be a good starting point to learn about the overall suggested organizational structure of an Athena Framework application.
The blog API continues on with the pattern of including a `README.md` file within each directory that adds some commentary/explanation of what each directory/file does.
This allows one to easily peruse/learn without having to study the code/look for comments within the code itself; which also leaves the code itself less cluttered.

If you prefer a more hands on approach, keep reading on to learn how to get it running locally.

## Getting Started

* Install dependencies
  * `shards install`
* Start the database
  * Via the provided `docker-compose.yaml` file: `docker compose up -d`
* Scaffold the DB schema
  * `shards run console -- db:migrate`
* Validate the setup by running the specs
  * `crystal spec`
* Start the server
  * `shards run server`

## Considerations

While this example is intended to be as real-world as possible, some things are a just bit out of scope or too complex to cover here.
These particulars and their impact are noted below.

### Levels of Abstraction

Every application is going to have its own requirements and as such require the code to behave in a particular way.
Because of this, the abstractions that application requires may differ from those used in this more simple/naive implementation.
This application uses abstractions that are simpler, while still being impactful, but what/when to define some is ultimately up to the end user.

Some examples of this include:

* The dedicated entity modules for `created_at`, `updated_at`, `deleted_at`
  * Aren't really needed with there only being a single entity, but are simple/straightforward enough and will benefit things when more are needed
* Using the `Article` entity as both the DB entity itself, and as a way to represent the request/response body
  * Given how simple the entity is, it probably is fine, but comes at the cost of tightly coupling your DB schema with the resource exposed to the client.
    A more flexible (but more verbose) option is to leverage dedicated [Data Transfer Objects](https://en.wikipedia.org/wiki/Data_transfer_object), such as `ArticleCreate` or `ArticleRead`
    that _only_ handle (de)serialization and validation, leaving all the business/DB logic up to the `Article` entity itself.
    The extra verbosity comes from not only the extra types, but also the logic required to map the one type to another.
* The hard coded insert/update methods within `EntityManager`
  * Could choose to handle these automatically by making some assumptions and defining like `#column_names` and `#column_values` methods on the base `Entity` type.
    Then from here could build out the SQL to perform the insert.
    The benefit being not needing to remember to define those/write the SQL by hand, but at the cost of possible edge cases if the assumptions don't hold true 100% of the time.

### Production Deployments

How to best deploy an application can be tricky since no application is the same, with each having its own unique set of requirements.
As such, we are not going to get into the specifics of _HOW_ to deploy the blog API to production, but a few things to keep in mind when thinking about how you are:

* Have some way to run the DB migrations
  * Either continue using [micrate](https://github.com/amberframework/micrate), manually handling it, or some other external solution
  * TIP: Don't forget to include the `db/` directory!
* Use ENV vars for differences in infrastructure between environments
  * Code should be able to be open sourced at any moment without compromising any credentials
* Write tests
  * Detecting defects is much less costly if detected _before_ it makes it to production
* Deploy both entrypoints
  * The server itself of course, but also the `console` binary

## Contributing

Have an idea/feature common/useful enough to be worthy of including into the application?
Create an issue and we can see about having it included.
