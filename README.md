# Terraform Application

This project demonstrates how to use Terraform to create an instance and output its IP address.

## Prerequisites
  
- Terraform installed on your machine
- AWS account with appropriate permissions

## Installation

### Install Terraform

1. Download the Terraform binary from the [official website](https://www.terraform.io/downloads.html).
2. Unzip the downloaded file and move the binary to a directory included in your system's `PATH`.

    ```sh
    sudo mv terraform /usr/local/bin/
    ```

3. Verify the installation:

    ```sh
    terraform -v
    ```

### Configure AWS CLI

1. Install the AWS CLI by following the instructions on the [official AWS CLI website](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
2. Configure the AWS CLI with your credentials:

    ```sh
    aws configure
    ```

3. Follow the prompts to enter your AWS Access Key ID, Secret Access Key, region, and output format.


## Usage

1. Initialize the Terraform configuration:

    ```sh
    terraform init
    ```

2. Apply the Terraform configuration to create the instance:

    ```sh
    terraform apply
    ```

3. After the apply command completes, Terraform will output the IP address of the created instance.

## Example Output

```sh
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

instance_ip = "XX.XX.XX.XX"
```

Replace `XX.XX.XX.XX` with the actual IP address output by Terraform.

## Cleanup

To destroy the created instance, run:

```sh
terraform destroy
```

## Files

- `main.tf`: Contains the Terraform configuration for creating the instance.
- `outputs.tf`: Defines the output variables for the instance IP address.

## License

This project is licensed under the MIT License.
