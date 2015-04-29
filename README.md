#Scaling API

This lightweight app scales an array of image dimensions according to a bounding box input. Both arrays of image dimensions and bounding box are passed in the URL query string, then the app outputs the scaled dimensions in JSON.

Check out the app using these queries:

[One pair of image dimensions][simple_query]
[simple_query]: https://scalingapi.herokuapp.com/?image_dimensions=[400,200]&bounding_box=[200,200]

GET REQUEST:
`{
  image_dimensions: [400,200],
  bounding_box: [200,200]
}`

JSON RESPONSE:
`{
  scaled_dimensions:  [200,100],
  bounding_box:  [200,200]
}`

[Multiple pairs of image dimensions][multiple_query]
[multiple_query]: https://scalingapi.herokuapp.com/?image_dimensions=[1256,1200,600,800,200,200,400,200,800,1256]&bounding_box=[200,200]

GET REQUEST:
`{
  image_dimensions: [1256,1200, 600, 800, 200, 200, 400, 200, 800,1256],
  bounding_box: [200,200]
}`

JSON RESPONSE:
`{
  scaled_dimensions:  [200, 191, 150, 200, 200, 200, 200, 100, 127, 200],
  bounding_box:  [200,200]
}`


## Technical Overview

This app is built on Rails. The controller passes the get request query parameters to the `Scaler` model, which performs all of the calculations.

### Controller
The controller initializes a Scaler object with the query parameters (`image_dimensions` and `bounding_box`). After the scaler object performs the scaling, the new dimensions are rendered as JSON.

#### Validations
The controller validates presence of both `image_dimensions` and `bounding_box` parameters.

### Model
The `Scaler` model accepts `image_dimension` and `bounding_box` as strings. Then, the model parses the strings into arrays and performs the `scale_dimensions` operation.

#### Validations
The model checks if the `image_dimensions` are passed as pairs and if they are all integers. Also, it checks if two `bounding_box` dimensions are supplied and if they're both integers.
