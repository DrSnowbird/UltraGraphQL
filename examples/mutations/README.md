# mutations Example
This example allows to test insert and delete mutations on a sample data structure that supports several schema features.
The dataset and configuration are the same as in the example *one_service* but with the following addition to the configuration which enables the mutations for the service endpoint.
```json
  "mutations": true,
  "mutationService": "dataset",
```

To start the UGQL instance of this example run the following command from this folder.

```bash
java -jar ../../build/libs/ultragraphql-<version>-exe.jar --config config.json
```
e.g.:
```bash
java -jar ../../build/libs/ultragraphql-1.1.0-exe.jar --config config.json


Then, you will see the console eventually print instructions like below for you to try 'graphiql':

     _   _ _ _              ____                 _      ___  _
    | | | | | |_ _ __ __ _ / ___|_ __ __ _ _ __ | |__  / _ \| |
    | | | | | __| '__/ _` | |  _| '__/ _` | '_ \| '_ \| | | | |
    | |_| | | |_| | | (_| | |_| | | | (_| | |_) | | | | |_| | |___
     \___/|_|\__|_|  \__,_|\____|_|  \__,_| .__/|_| |_|\__\_\_____|
                                          |_|
----------------------------------------------------------------------

16:11:24 INFO  Application :: Starting controller...
HGQL service name: one_service
GraphQL server started at: http://localhost:8000/graphql
GraphiQL UI available at: http://localhost:8000/graphiql

Assuming you use port 8000 on the host, then the above URLs are for you to access 'graphiql'

```

> Performed mutations on the dataset are persisted. To reset the dataset reload it form the repository or make a local copy.


## Sample Mutations

### Insert Mutation

The example insertion inserts a new car with data for *brand*, *model* and *color*.
Afterwards the ID and model of all cars are queried.
```graphql
mutation{
  insert_ex_Car(_id:"http://example.org/car_3", ex_brand:"BMW", ex_model:"2000", ex_color:"gray"){
    _id
    ex_model
  }
}
```

### Handy Scripts
The following graphql scripts is for handy useage for convience - just copy it over to graphiql web ui and you can comment/uncomment fragments to try out 'mutations':
```graphql
# Welcome to GraphiQL
#
# GraphiQL is an in-browser tool for writing, validating, and
# testing GraphQL queries.
#
# Type queries into this side of the screen, and you will see intelligent
# typeaheads aware of the current GraphQL type schema and live syntax and
# validation errors highlighted within the text.
#
# GraphQL queries typically start with a "{" character. Lines that starts
# with a # are ignored.
#
# An example GraphQL query might look like:
#
#     {
#       field(arg: "value") {
#         subField
#       }
#     }
#
# Keyboard shortcuts:
#
#       Run Query:  Ctrl-Enter (or press the play button above)
#
#   Auto Complete:  Ctrl-Space (or just start typing)
#


query {
  ex_Car {
    _id
    ex_model
  }
}

# mutation{
#   insert_ex_Car(_id:"http://example.org/car_3", ex_brand:"BMW", ex_model:"2000", ex_color:"gray"){
#     _id
#     ex_model
#   }
# }

# mutation{
#   delete_ex_Car(_id:"http://example.org/car_3"){
#     _id
#     ex_model
#   }
# }

# mutation{
#   delete_ex_Car(ex_brand:"BMW", ex_model:"2000", ex_color:"gray"){
#     _id
#     ex_model
#   }
# }
```

### Delete Mutations

#### Delete by ID
All data about cars with the IRI **http://example.org/car_3** are deleted.
Meaning that all triples where the IRI is the subject and any field from the object type *ex_Car* is the predicate are deleted from the service.
The limitation of the deletion to only delete all data of the type for the given ID is because in RDF IRIs can have multiple types.
To avoid the deletion of data that is assigned to the IRI in the context of another type the deletion is limited to the type of the mutation field.
```graphql
mutation{
  delete_ex_Car(_id:"http://example.org/car_3"){
    _id
    ex_model
  }
}
```

#### Delete Provided Data
The provided data about the fields *ex_brand*, *ex_model* and *ex_color* is deleted from the object with the given ID.
The object itself is not deleted because other data of the object can still be avaliable.
To delete the whole object look [here](#delete-by-id).
```graphql
mutation{
  delete_ex_Car(_id:"http://example.org/car_3", ex_brand:"BMW", ex_model:"2000", ex_color:"gray"){
    _id
    ex_model
  }
}
```

#### Delete by Matching Mask
Delete all cars that match the defined mask.
In this example all cars of the brand "BMW" with model "2000" in "gray" are deleted from the service.
```graphql
mutation{
  delete_ex_Car(ex_brand:"BMW", ex_model:"2000", ex_color:"gray"){
    _id
    ex_model
  }
}
```
