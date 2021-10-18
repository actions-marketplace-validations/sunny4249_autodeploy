# 42maru Package Auto Deploy Manager

Automatically deploy a package to 42maru pypi server by release actions that have a 'created', 'deleted'.


## How to use

Install this GitHub action by creating a file in your repo at 
.github/workflows/deploy_package.yml.

A minimal example could be:

```
on:
  release:
    types: [created,deleted]
jobs:
  deploys:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v2
        with:
          python-version: "3.8"
      - name: Deploy pacakge to 42maru pypi
        uses: sunny4249/autodeploy@v0.0.2
        with:
          token: ${{ secrets.PYPI_SECRET }}
          package_name: <package name>
        env:
          GITHUB_CONTEXT: ${{ toJSON(github) }}

```

## When release created 

If that package has been not registered in 42maru pypi, create 42maru pypi
register templete and deploy the package to pypi. But already the package has been 
registered, create 42maru pypi update templete.

- Release a package with specific tags(v0.0.1)
- Go to pypi repo pull request tab and just merge that register or update request.


## When release deleted

If specific release version package is deleted, only delete the package anchor in 
the package index.hml(<package_name>/index.hml). 
But if nothing remains in pypi index related the package, then delete the anchor in main
index.html(./index.html).
 
- Delete a specific version package.
- Go to pypi repo pull request tab and just merge that delete request.

## Config

Because this action is fitted in 42maru pypi deploy management policy, there are not many settings.<br />

There are Just two settings. 

#### PYPI_SECRET
The PYPI_SECRET is just a token string that have workflow and release authorization.

- Generate token in your developer settings.
- Register that tokens in your repository's settings secrets tab.

The name of secret must be `PYPI_SECRET`
 

#### GITHUB_CONTEXT

THe GITHUB_CONTEXT is environment variable that is provided by github and contains 
the event information to be used in actions for deploying.


#### Caustion!!

PYPI_SECRET and GITHUB_CONTEXT is configured different syntax level. 
(PYPI_SECRET is in `with` syntax and GITHUB_CONTEXT is in `env` syntax). 
Because GITHUB_CONTEXT is provided input by actions rather than custom input, but
PYPI_SECRET is the other way around.