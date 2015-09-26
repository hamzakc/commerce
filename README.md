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
I am on the fence on which one to choose, but to just get things going I am going to start to use MongoDB or
Riak

### Where are the micro services?
As it is difficlut to change service boundries once they have been spltit up. I am going to develop this entirly in one
application to begin with and simply use modules to split out the different services. This will help me when splitting
the application into actual microservices in the not to distant future.

### Work done so far
Not too much.  I have started on the Shop ProductService using Sinatra and mongoDB. I am going to try and use the curator
gem as a model and repository framework. This will help me conform to domain driven design principles (hopefully). 
Unfortulitly curator do not have any plans to support the MongoDB v2 driver.  The API has completly changed so I need to
get it working with v2 before I can make any progress.  In the mean time I might just use Riak.  I am only put off from
Riak as you have to give them your email address before you can download it and their sales team then follow up with you 
a little more then I would like.

### Contribute
If you have any ideas on how to make this awsome get in touch and submit a pull request :)
