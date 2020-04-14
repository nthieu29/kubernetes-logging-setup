# kubernetes-logging-setup
Kubernetes Logging with Graylog and Fluent Bit in an easy and effective way.
## What will we setup
We will setup the centralize logging in Kubernetes as following:
![Alt text](images/architecture.png?raw=true "Kubernetes Logging")
- In each node in Kubernetes cluster, there is an agent to collect the logs of all the containers that run on the node, then process the logs and send to Graylog. We use Fluent Bit as log collector agent and deploy it as DaemonSet so that we have all nodes run a copy of a Fluent Bit pod.
- Graylog takes care all the things for us: Graylog interacts with the logging agents, manages the storage in Elastic Search, provide an easy to use Web UI and a REST API also. Graylog need MongoDB because Graylog uses MongoDB to store metadata (stream, dashboards, roles, etc). 
## Prerequisites
* A working Kubernetes cluster (or use Minikube on your local machine).
* kubectl is installed and configured correctly.
## How to setup
All the stuff were already prepared in this repository to help you **get the logging system up and running quickly in just 3 steps**:
#### 1. Setup Graylog, MongdoDB, Elasticsearch

- **Make sure you set _max_map_count_ to 262144**. It's a requirement and recommendation from Elasticsearch, you could refer [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#_set_vm_max_map_count_to_at_least_262144) for the reason and how-to. 
- Run the command:

      docker-compose -f compose-graylog.yml up
- What does it do? We use [docker-compose](https://docs.docker.com/compose/) to define an application with 3 containers MongoDB, Elasticsearch and Graylog, we also configured them to work correctly.
      
#### 2. Deploy Fluent Bit in Kubernetes
- Update _<your-graylog-ip-address>_ with your Graylog server IP address in file _fluent-bit-configmap.yml_.
- Run the command:
          
      deploy.sh
- What does it do?
    - Create a new namespace _logging_.
    - Create the base resources for Fluent Bit: Service Account, Role, RoleBinding.
    - Create ConfigMap for Fluent Bit.
    - Create DaemonSet with Fluent Bit.
#### 3. Configure Input in Graylog
- Login to Graylog with default username:password (admin:admin) at http://localhost:9000/.
- Choose **System/Inputs**.
- Click **Select input**, then choose **GELF TCP**. Click **Launch New Input**.
- Give it a meaningful name in **Title** field, you could modify other fields, then click **Save**.
- Your new Input will be displayed, click **Show received messages** to view your first logs which coming from Kubernetes.
## Where to go next
This guide provides a minimum setup that can be used for smaller, non-critical, or test setups. For production environments, please refer [Graylog document](https://docs.graylog.org/en/3.2/pages/architecture.html#bigger-production-setup).
