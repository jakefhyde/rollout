# rollout
Helm chart for a cron job that will periodically check (default 1 minute) for a new image, and conditionally restart a deployment.

The deployment *must* have `imagePullPolicy: Always` for the `targetImage` or the restart will not have the intended effect.

Currently this chart has values specific to rancher with docker as the underlying CRI, however this will be removed in a future version.

