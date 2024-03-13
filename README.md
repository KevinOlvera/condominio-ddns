# DonDominio DDNS Docker Container

This Docker container automates the process of updating your domain's IP address on dondominio.com using a DDNS (Dynamic Domain Name System) update script. It is designed to be lightweight, efficient, and easy to use, ensuring that your domain always points to the correct IP address.

## Prerequisites

Before using this container, you need to have a domain already set up on dondominio.com with a default IP address. The container will update this IP address to the current public IP of the host machine when it runs.

## Building the Container

To build the Docker container, navigate to the directory containing the Dockerfile and run the following command:

```bash
docker build . -t docker pull kolvera/dondominio-ddns:latest
```

This command builds the Docker image with the tag `docker pull kolvera/dondominio-ddns:latest`.

## Running the Container

Use the following command to run the container in detached mode, replacing the environment variable values with your own dondominio.com account details and preferred update interval:

```bash
docker run -d --name dondominio-ddns-container \
-e DDNS_USERNAME='your_username' \
-e DDNS_API_KEY='your_token_here' \
-e DDNS_DOMAIN='your_domain.com' \
-e UTIME='5m' \
docker pull kolvera/dondominio-ddns:latest
```

This will start the container and begin the process of periodically checking and updating the IP address associated with your domain.

## Note on DonDominio DDNS Repository

This container utilizes the DDNS update script provided by dondominio.com.

https://github.com/dondominio/dondns-bash

## Considerations

- The domain must be previously created on dondominio with a default value.
- The first time the container is executed, it will update the domain with the current (public) IP address.
- The update time is set to 5 minutes by default. The UTIME variable accepts the following formats: 5m: 5 minutes, 1h: 1 hour, 1d: 1 day

## Environment Variables

The container uses the following environment variables for configuration:

| Variable        | Description                                    | Format                                    | Default Value |
| --------------- | ---------------------------------------------- | ----------------------------------------- | ------------- |
| `DDNS_USERNAME` | Your dondominio.com account username.          | string                                    | None          |
| `DDNS_API_KEY`  | API key for accessing dondominio.com services. | string                                    | None          |
| `DDNS_DOMAIN`   | The domain you wish to update the IP for.      | string                                    | None          |
| `UTIME`         | Update interval for the domain's IP address.   | `5m` (minutes), `1h` (hours), `1d` (days) | `5m`          |

### Usage Example

To run the container with custom settings, you can modify the environment variables as shown below:

```bash
docker run -d --name dondominio-ddns-container \
-e DDNS_USERNAME='yourUsername' \
-e DDNS_API_KEY='yourApiKey' \
-e DDNS_DOMAIN='yourDomain.com' \
-e UTIME='1h' \
docker pull kolvera/dondominio-ddns:latest
```

This example sets the DDNS update to occur every 1 hour. Adjust the `DDNS_USERNAME`, `DDNS_API_KEY`, `DDNS_DOMAIN`, and `UTIME` values according to your needs.

## Best Practices

- **Security**: Ensure that the environment variables containing sensitive information (e.g., `DDNS_USERNAME`, `DDNS_API_KEY`) are securely managed and not exposed.
- **Monitoring and Logging**: Monitor the container's logs to keep track of the DDNS updates and ensure that the updates are happening as expected.
- **Regular Updates**: Although the container automates IP updates, regularly check your domain's DNS settings on dondominio.com to ensure everything is functioning correctly.
