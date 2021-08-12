# techdocs-cli

Docker image for running backstage [techdocs-cli](https://backstage.io/docs/features/techdocs/configuring-ci-cd) for generating mkdocs

## pulumi

This is how to configure it in pulumi python

```python
pulumi_gcp.cloudbuild.Trigger(
    resource_name="docs-generate-docs", build=pulumi_gcp.cloudbuild.TriggerBuildArgs(
        steps=[
            pulumi_gcp.cloudbuild.TriggerBuildStepArgs(
                name='confiq/techdocs-cli:latest',
                id="build_docs",
                entrypoint="sh",
                args=[
                    '-c',
                    'techdocs-cli generate --no-docker && '
                    'techdocs-cli publish --publisher-type=googleGcs --storage-name=[BUCKET_NAME] '
                    '--entity=default/Resource/docs',
                ]
            )
        ]
    ),
    github={
        'owner': '[org]',
        'name': '[repo]',
        'push': {
            'branch': f'^master$',
        }
    }
)

```
