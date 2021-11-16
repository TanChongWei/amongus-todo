# PowerX Fundamentals in Developer Tools - Capstone Project

This capstone project has 2 requirements: 
- Build a CI/CD pipeline for an already existing application
- The infrastructure required for this deployment has to be provided by terraform

For this capstone project, I have used the AWS Elastic Container Registry (ECR) to host my docker image and have deployed my docker image to an EC2 instance.

## CI CD pipeline
The CI/CD pipeline involves the following tasks
- Running of test cases to ensure the functionality of the app
- Building and scanning of the docker image
- Pushing the docker image onto AWS ECR
- Deploying the image onto EC2 by using remote ssh commands to pull the image from AWS ECR and run the image 

## Infrastructure provisioned by terraform
Terraform is utilised to defined the following infrastructure
- Creating the necessary s3 backend bucket
- EC2 instance where the app will be deployed to (and the security group)
- ECR where docker image will be hosted
- aws_key_pair referencing a tls_private_key

## End results

CI/CD pipeline status:

![image](https://user-images.githubusercontent.com/72724926/141985510-dfd584c5-2803-4141-823c-6f94692eb2bd.png)

AWS ECR with hosted image:

![image](https://user-images.githubusercontent.com/72724926/141985357-57563594-7410-43bc-8268-78a1739bec6c.png)

Instance details with corresponding key pair:

![image](https://user-images.githubusercontent.com/72724926/141984981-892e4d0d-e4d1-4362-a40b-08676f0ee260.png)

Deployed app:
http://175.41.163.76

---

# Among Us TODOs API

![Among Us banner](docs/img/banner.jpg)

Fake REST API server of tasks from Among Us

## Getting Started

This application is backed by the default data from a json file (default to be `db.json`, however it can be specified through an environment variable).
The underlying server that power the application is [json-server](https://github.com/typicode/json-server)

### Starting the application

Simply `npm start` and the server will be started with the default configurations on port 3000 and db file to be `db.json`

### App-level configurations

- `DB`: path to the json file that will be used as the database
- `PORT`: port that the app will start on

### Testing

- Code linting: `npm run lint`
- Full test suite: `npm test`

## API Reference

Data from the json database file will be loaded every time the app starts and db writes will be made to the same file as well. Hence, a note on if the data is not commited into source, we might see differences between environments.

Listed below are basic usages of the API, more advanced usages can be found [here](https://github.com/typicode/json-server#routes).

### POST /todos

Create a new tasks

```
POST /todos

{
    text: string,
    type: "short" | "long" | "common"
}
```

### GET /todos/:id

Get task by ID

```
GET /todos/:id
```

### GET /todos

Get tasks

```
GET /todos
```

Possible query parameters:

- `q`: full text search
- `_page` and `_limit`: paginate
- any fields from the TODO object: filter using specific fields
- `_start` and `_end`: slice based on TODO ID

### PUT /todos/:id

Replace whole TODO item content

```
PUT /todos/:id

{
    text: string,
    type: "common" | "long" | "short"
}
```

### PATCH /todos/:id

Partial update TODO item

```
PATCH /todos/:id

{
    text?: string,
    type?: "common" | "long" | "short"
}
```

### DELETE /todos/:id

Delete a TODO item

```
DELETE /todos/:id
```

## Contributing

For any requests, bug or comments, please [open an issue](https://github.com/stanleynguyen/amongus-todo/issues) or [submit a pull request](https://github.com/stanleynguyen/amongus-todo/pulls).
