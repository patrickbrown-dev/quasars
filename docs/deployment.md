## Deployment

### Releases

1. Create a [new release][2] and bump tag version (e.g. `0.0.1` to `0.0.2`).
2. Do a `git pull` in your local codebase on `master`.
3. Initiate a capistrano deploy (e.g. `cap production deploy`)
4. Supply tag when prompted (it should default to latest tag).
5. Monitor release and post-deploy.

Floating IP assignment is completely automated during deploy.

### Rollbacks

In the case of a bad deploy, issue the `rake digital_ocean:floating_ip[DEPLOY]`
command where `DEPLOY` is the previous deployment environment. For more
information, refer to the capistrano [rollback documentation][1].

[1]: https://capistranorb.com/documentation/getting-started/rollbacks/
[2]: https://github.com/kineticdial/quasars/releases/new
