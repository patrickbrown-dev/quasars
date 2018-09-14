Infrastructure
==============

![Infrastructure overview](/infra.svg)

## Pros

- Active-Active
- No downtime during deployment
- Swap out floating IP for load balancer for quick scaling

## Cons

- Deployer needs to know which box isn't serving requests (prone to human error)
