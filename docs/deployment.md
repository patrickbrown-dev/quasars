## Deployment

### Releases

You will need the [quasars-k8s][2] repo checked out on your local machine and in your `pwd`.

1. Grab the docker image tag you want to deploy (e.g. `de69322`) from [docker hub][1].
2. Alter the `deployment.yml` file's `.spec.template.spec.containers[0].image` tag
   to the docker image tag you grabbed from before (e.g. `image: kineticdial/quasars:de69322`).
3. Run the deployment with `kubectl apply -f deployment.yml`.
4. Monitor the deployment with `kubectl rollout status deployment quasars`.
5. Verify the release was successful by visiting [https://quasa.rs][3] and monitoring email
   for exceptions.
6. Commit and push the changes to the `quasars-k8s` repository.

[1]: https://hub.docker.com/r/kineticdial/quasars/tags
[2]: https://github.com/kineticdial/quasars-k8s
[3]: https://quasa.rs
