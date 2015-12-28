[![Build Status](https://travis-ci.org/hamzakc/commerce.svg)](https://travis-ci.org/hamzakc/commerce)

# commerce
Exploration work for building a microservice e-commerce platform.

I am trying to produce a basic functioning e-commerce solution built with micro services. The initial build will be entirly in
Ruby and Sinatra as this is the easiest thing for me to get going.  But it will most likly become a cross language prospect in
the near future. 

The services will be divided into two areas:

* Shop - Front customer facing actions 
* Admin - Backend actions

### Shop

The shop area will be split into the following micro services:
* HomepageService
* RecommendationService
* FeatureService
* ProductService
* SearchService
* CheckoutService
* DeliveryService
* OrderService
* NewsService

### Admin

The Admin area will be split into the following micro services:
* SKUService
* FileUploadService
* ProductService
* SearchService
* ShopService
* ReportsService
* FulfillmentService
* EnquiryService
* RefundService
* NewsService
* OrderService
* CMSService
* SettingService

### DataStore
Where necessary each service will have their own database. Initially this will be a NoSQL distributed store.
I am on the fence on which one to choose, but to just get things going I am going to start to use Riak.

### Communication between services
I am going to explore using IBM's MQ Light messaging system.  This will allow servies to be decoupled from each other and will allow a pub/sub architecture. For example if an admin user makes a change to a prodcut (using the admin product service), this is then pushed to the frontend product service which in turn updates the product. Otherwise we would have to have a post made to the frontend service when the admin service is updated. This would couple the two services together.

### Where are the micro services?
As it is difficlut to change service boundries once they have been split up. I am going to develop this entirly in one
application to begin with and simply use modules to split out the different services. This will help me when splitting
the application into actual microservices in the not to distant future.

### Work done so far
Not too much.  I have started on the Shop ProductService using Sinatra and Riak. I am going to try and use the curator
gem as a model and repository framework. This will help me conform to domain driven design principles (hopefully). 

### Contribute
If you have any ideas on how to make this awsome get in touch and submit a pull request :)
