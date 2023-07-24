<h1 align="center">
  <img src="https://img.icons8.com/external-soft-fill-juicy-fish/60/external-terraform-space-exploration-soft-fill-soft-fill-juicy-fish.png" alt="Terraform Logo" width="96"> 
  <br>
  Monitoring Terraform Module
</h1>

<p align="center">
  <a href="https://github.com/theArcianCoder/monitoring-module">
    <img src="https://img.icons8.com/bubbles/50/github.png" alt="GitHub Repo Icon" width="100">
  </a>
</p>

## Introduction

This Terraform module deploys and configures resources for your Kubernetes cluster using AWS EKS and Helm. It sets up the Kube Prometheus stack to enable monitoring and observability for your cluster.

<p align="center">
  <img src="https://img.icons8.com/color/48/prometheus-app.png" alt="Prometheus Stack" width="100">
  <img src="https://img.icons8.com/color/48/kubernetes.png" alt="Prometheus Stack" width="100">
  <img src="https://img.icons8.com/fluency/48/grafana.png" alt="Prometheus Stack" width="100">
  
</p>

## Prerequisites

Before using this module, ensure that you have the following prerequisites:

- An existing AWS EKS cluster
- AWS CLI and AWS IAM Authenticator configured
- Terraform installed locally
- kubectl and Helm installed locally
- AWS credentials with necessary permissions

## Usage

To use this module in your infrastructure, create a `main.tf` file and include the following code:

```terraform
module "my_kube_prometheus" {
  source           = "git::https://github.com/theArcianCoder/monitoring-module.git"
  cluster_name     = "cluster's-name"
  cluster_endpoint = "cluster's-endpoint"
  namespace        = "monitoring"
  stack_name       = "monitoring-stack"
}

output "eks_cluster_id" {
  description = "The endpoint URL of the EKS cluster."
  value       = module.my_kube_prometheus.eks_cluster_id
}

```
   1. **Initialize Terraform:**

      Run the following command to initialize Terraform in the project directory:

      ```bash
      terraform init
      ```

      This command downloads the necessary plugins and sets up the working directory.

   2. **Review the Terraform Plan:**

      To see what changes will be applied to the infrastructure, run:

      ```bash
      terraform plan
      ```

   3. **Apply the Terraform Changes:**

      Once you are satisfied with the plan, apply the changes to create or update the infrastructure:

      ```bash
      terraform apply --auto-approve
      ```

      The `--auto-approve` flag will automatically approve the plan without requiring manual confirmation.

#### Usage using MAKEFILE
Now, we need to assume that the Terraform file `main.tf` exists in the same directory as the Makefile. This is a common practice when working with Terraform projects.

For example, suppose you have the following directory structure:

```
my_project/
|-- Makefile
|-- main.tf
```
Creating a Makefile that interacts with user input is not a straightforward task since Makefiles do not natively support user input. However, we can achieve this functionality by using environment variables and conditional statements. Keep in mind that the use of environment variables makes this Makefile system-dependent, and it may not work as expected on all platforms.

Assuming you have Terraform installed and available in your system's PATH, here's an example of a Makefile that interacts with user input and runs Terraform accordingly:

```make
# Check if the "monitoring" variable is set to "true" or "false"
ifdef monitoring
  ifeq ($(monitoring), true)
    TF_CMD := terraform init && terraform plan && terraform apply --auto-approve
  else
    TF_CMD := @echo "Monitoring module not installed"
  endif
else
  TF_CMD := @read -p "Enable monitoring (true/false)? " monitoring; \
            if [ $$monitoring = "true" ]; then \
              terraform apply; \
            else \
              echo "Monitoring module not installed"; \
            fi
endif

.PHONY: apply
apply:
	$(TF_CMD)

```

With this Makefile, you can use the `make apply` command to run Terraform and prompt the user for input. If the user inputs "true," the Terraform apply command will be executed. If the user inputs "false," the Makefile will display the message "Monitoring module not installed."

Please note the following points:

1. The Makefile uses the `monitoring` environment variable to store the user input. If the variable is not set, it will prompt the user for input using the `read` command.

2. The `TF_CMD` variable is set based on the value of `monitoring`. If `monitoring` is set to "true," the Terraform apply command will be executed; otherwise, it will display the message.

3. The `@` symbol before commands prevents Make from printing the command itself while executing it.

To use this Makefile, you can run it in the terminal like this:

```bash
make apply monitoring=true
```

or

```bash
make apply monitoring=false
```

Keep in mind that this approach is not as flexible as directly using a script or other programming languages for handling user input. If you need more complex user interactions, you may consider using a different scripting language like Python or Bash to create a more user-friendly interface.
### Module Input Variables

- `cluster_name`: (Required) Name of the EKS cluster.
- `cluster_endpoint`: (Required) Endpoint URL of the EKS cluster.
- `namespace`: (Required) Namespace for the Helm release.
- `stack_name`: (Required) Name of the Helm release stack.

### Module Output
- `cluster_endpoint`: Endpoint URL of the EKS cluster.

## Resources Created
The module creates the following Kubernetes resources:
- Prometheus server deployment
- Grafana deployment
- ConfigMap for Grafana datasources
- ConfigMap for Grafana dashboards
- ServiceMonitor to monitor Prometheus and Grafana
- Service for Grafana
- Service for Prometheus 
- Ingress for Grafana
## Variables and Customization
You can customize the Grafana datasources and dashboards by providing additional values to the module. Please refer to the [Helm chart documentation](https://github.com/theArcianCoder/monitoring-setup) for more details.
## Note :-
- Please provide required permissions to the node  for the CloudWatch Access to Grafana.
