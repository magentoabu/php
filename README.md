# Magento PHP Docker Image

This repository contains the Docker image for Magento PHP environment, which can be used to run a Magento-based project in a containerized environment.

## How to Use
## Pull the Docker Image

You can pull the latest version of the magentoabu/php Docker image from Docker Hub by running the following command:

```bash
docker pull magentoabu/php:8.1
```

## Running the Docker Container

```php
docker run -d -p 8080:80 --name magento_container magentoabu/php:8.1
```

## Accessing the Container

```
docker exec -it magento_container bash
```

# Usage in Magento Projects

This Docker image is ideal for running Magento-based projects, ensuring a consistent environment for development, testing, and production workflows.

Please make sure to update tests as appropriate.

## License

This project is licensed under the MIT License.

[MIT](https://choosealicense.com/licenses/mit/)
