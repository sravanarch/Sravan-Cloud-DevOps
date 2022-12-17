_Terraform Core Commands:_

    # Initialize Terraform
    terraform init

    # Validate Terraform
    terraform validate

    # Plan Terraform to validate before it gets created/destroyed/updated
    terraform plan

    # Apply Terraform to apply the changes.
    terraform apply

    # Destroy Terraform to delete all resources 
    terraform destroy

_Terraform Lock File_
    .terraform.lock.hcl
    
*Terraform Basics*
    Terraform Configuration File or Terraform Manifest File:
        Terraform Language is stored in plain text files with .tf extension.
        JSON based Varaint is also available with .tf.json extension.

    Terraform Working Directory:
        It is where Terraform Configurations files exist


*Terraform Configuration Language Syntax*
    _Terraform Blocks_
        The below template and example gives information on how a block is to be built within a Terraform Manifest File.

        Template:
        <block type> <block label> <block label> {
            <block body>
            <identifier> = <expression>         # Arguments
        }

        Example:
        resource "aws_instance" "ec2instance" {
            ami = "ami id"
            instance_type = "t2.medium"
        }

        Types of BLOCK TYPES:
            There are 2 types of Block Types such as:
                1. Top Level
                    - resource, provider, input, output, data, local, terraform settings, modules

                        Top Level Block Types can segregated in 3 different ways:
                            1.1 Fundamental Blocks
                                    - Terraform Block
                                    - Providers Block
                                    - Resources Block
                            1.2 Variable Blocks
                                    - Input Variables Block
                                    - Output Values Block
                                    - Local Values Block
                            1.3 Calling/Referencing Blocks
                                    - Data Sources Block
                                    - Modules Block
                                    
                2. Block inside Blocks
                    - provisioners, resource specific blocks like tags

    _Terraform Arguments_
        The block inside a block body is referred to as "Terraform Arguments"
        Arguments can be optional or required. Required are mandatorily to be given in the Terraform Code.

            Example:
                            {
            <ami> = <ami-xdbdhddhd>         # Arguments
            <instance-type> = <t2.micro>
        }

    _Terraform Attributes_
        Attributes are values exposed by a particular resource.
        Reference to resource attributes takes the format as below:
            resource_type.resource_name.attribute_name

        Example:

            data "aws_ami" "amazonlinux" {
                id = ami.12345678
            }

            resource "aws_instance" "ec2" {
            ami           = data.aws_ami.amazonlinux.id # Data type is being used in a resource block
            instance_type = "t2.micro"
            }

    _Terraform Meta Arguments_
        Changes a resource type's behaviour & are not resource specific.
        Example:
            count
            for_each
            depends_on
            provider
            lifecycle

    _Terraform Identifiers_
        Key's of Block Body are referred as Identifiers (or) Argument key
        Values of Block Body are referred as Expression (or) Argument Value

            Example:
            ami = 
            instance-type = 
    
    _Terraform Comments_
        Comments in Terraform can be done in multiple ways
            Comment - 1: Single-line comment
            // (or) #

            Comment - 2: - Multi-line comment
            /*
            comment 123
            comment 234
            */



*Terraform Real Time Code*

_1.aws_provider_ecs.tf_
    This code provides you the information on creating a basic Terraform file to create a basic ec2 instance