# UltraGraphQL Examples

| Example                                          | Description                                                                                                    |
|:-------------------------------------------------|:---------------------------------------------------------------------------------------------------------------|
| [one_service](one_service/README.md)             | UGQL endpoint with one underlying service and all schema features to test them                                 |
| [multiple_services](multiple_services/README.md) | UGQL endpoint with three underlying services to demonstrate the schema generation over multiple service        |
| [extended_mapping](extended_mapping/README.md)   | UGQL endpoint with extended mapping configuration and equivalence relations to demonstrate possible use cases  |
| [mutations](mutations/README.md)                 | UGQL endpoint with enabled mutations to insert and delete data                                                 |

# Service Type (UltragraphQL)
Examples as below shows two different services configurations:
```
  "services": [
    {
      "id": "dataset",
      "type": "LocalModelSPARQLService",
      "filepath": "dataset.ttl",
      "filetype": "Turtle"
    }
  ]

or,

  "services": [
    {
      "id": "dataset",
      "type": "SPARQLEndpointService",
      "url": "https://dbpedia.org/sparql",
      "graph": "http://dbpedia.org",
      "user": "",
      "password": ""
    }
  ]
  
```
