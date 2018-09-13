Deployment
==========

## Releases

1. Tag master for release (e.g. `git tag 0.0.1 -m 0.0.1`)
2. Push tag to origin (e.g. `git push 0.0.1`)
3. Initiate a capistrano deploy (e.g. `cap green deploy`)
4. Supply tag when prompted (it should default to latest tag).
5. Monitor release and post-deploy.

In these examples `green` is the stage and `0.0.1` is the tag. You may
supply a branch instead of a tag to deploy a branch.

## Rollbacks

In the case of a bad deploy, issue the `cap green deploy:rollback`
command. For more information, refer to the capistrano
[rollback documentation][1]

[1]: https://capistranorb.com/documentation/getting-started/rollbacks/
